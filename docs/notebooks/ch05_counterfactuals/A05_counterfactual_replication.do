*==============================================================
*  附录 A5：反事实构造方法的加州禁烟复现（纯 Stata 版）
*  配套：第五章《如果没有政策，会发生什么》
*  方法：SCM (synth2) / Lasso 合成控制 / RCM / SDID (sdid)
*  数据：加州禁烟面板，39 州，1970-2000，加州 1989 年实施 Prop 99
*  说明：讲解版见 A05_counterfactual_replication.ipynb（含逐段解读）
*         本文件为纯代码版，供习惯在 Stata 中直接执行的读者使用
*==============================================================


*-------------------- A5.0 环境准备（首次运行时取消注释安装）
/*
ssc install synth2, replace
ssc install rcm, replace
ssc install sdid, replace all
ssc install schemepack, replace   // 提供 white_tableau 等绘图模板
*/
set scheme white_tableau            // 全局绘图风格

global net "https://github.com/j-hai/synth-stata/raw/refs/heads/main/s"


*-------------------- A5.1 数据与 donor pool（图 5.1）
use "$net/smoking.dta", clear
xtset state year
des                 // 数据概况：state, year, cigsale 及若干预测变量
sum, sep(0)

*-图 5.1：加州（黑）+ 38 州（浅蓝）+ donor pool 均值（绿）
use "$net/smoking.dta", clear
rename (cigsale age15to24 lnincome retprice) (cig age lny p)
reshape wide cig age lny p beer, j(state) i(year)
order year cig* age* lny* p* beer*
keep year cig*

* 生成 38 个 donor pool 州的香烟销售均值（cig3 是加州 CA，需排除）
local donor_vars
foreach i of numlist 1 2 4(1)39 {
    local donor_vars `donor_vars' cig`i'
}
egen cig_donor_mean = rowmean(`donor_vars')
label var cig_donor_mean "Donor pool mean"

#delimit ;
twoway
    (tsline cig3, lcolor(black) lw(medthick))         // 加州 CA
    ,
    ytitle("per-capita cigarette sales (in packs)")
    xtitle("Year")
    tline(1989, lpattern(shortdash) lcolor(black))
    tlabel(1970(5)2000) ylabel(0(50)300);
#delimit cr

foreach i of numlist 1 2 4(1)39 {
    addplot: tsline cig`i', lcolor(blue%40) lw(thin) ylabel(0(50)300)
}
addplot: tsline cig_donor_mean,                            ///
    lcolor("green*1.3") lw(*1.3) ylabel(0(50)300)          ///
    legend(order(1 "California" 40 "Donor pool mean")      ///
           ring(0) pos(2) cols(1))
graph export "scm-rcm-fig-01-raw-data-v2.png", replace width(900)


*-------------------- A5.2 合成控制法 SCM
use "$net/smoking.dta", clear
xtset state year

synth2 cigsale lnincome age15to24 retprice beer(1984(1)1988) ///
       cigsale(1988) cigsale(1980) cigsale(1975),            ///
       trunit(3) trperiod(1989) xperiod(1980(1)1988)         ///
       fig nested allopt frame(CAdata)
* 单位权重：Utah .334 / Nevada .235 / Montana .202 / Colorado .161 / Connecticut .068

graph display bias
graph export "scm-rcm-Abadie10-Tab01-Fig.png", replace width(900)
graph display pred
graph export "scm-Abadie2010-Fig02-pred.png", replace width(900)
graph display eff
graph export "scm-Abadie2010-Fig03-TE.png", replace width(900)

*-核心图：5 个非零权重州（图 5.2）
use "$net/smoking.dta", clear
qui rename (cigsale) (cig)
qui keep state year cig
qui reshape wide cig, j(state) i(year)
qui order year cig*
qui keep year cig*

set scheme rainbow
#delimit ;
twoway
    (tsline cig3, lcolor(black) lw(*1.5))             // 加州 CA
    ,
    ytitle("per-capita cigarette sales (in packs)")
    xtitle("Year")
    tline(1988, lp(shortdash) lc(black))
    tlabel(1970(5)2000) tmtick(##5)
    ylabel(0(50)300)
    aspect(0.8) ysize(4) xsize(5.5)
    legend(order(1 "CA"));
#delimit cr
foreach i of numlist 1 2 4(1)39 {
    addplot: tsline cig`i', lcolor(black*0.7%30) lw(*0.6) lp(solid) ///
        ylabel(0(50)300) tlabel(1970(5)2000) tmtick(##5)           ///
        legend(order(1 "CA" 2 "rest"))
}
foreach i of numlist 34 21 19 4 5 {
    addplot: tsline cig`i', lw(*1) lp(solid)                        ///
        ylabel(0(50)300) tlabel(1970(5)2000) tmtick(##5)           ///
        legend(order(1 "CA" 2 "rest"                               ///
                     40 "Utah, 0.334" 41 "Nevada, 0.235"           ///
                     42 "Montana, 0.202" 43 "Colorado, 0.161"      ///
                     44 "Connecticut, 0.068") row(2))
}
graph export "scm-Figure0-non-zero-weights.png", replace width(900)
set scheme white_tableau


*-------------------- A5.3 Lasso 型合成控制（放开约束）
use "$net/smoking.dta", clear
replace state = 0 if state == 3          // 把加州改记为 0，便于作被解释变量
rename (cigsale age15to24 lnincome retprice) (cig age lny p)
reshape wide cig age lny p beer, j(state) i(year)
order year cig* age* lny* p* beer*
save "smoking_wide.dta", replace

*-plugin 选 λ，处理年 1989
use "smoking_wide.dta", clear
global TreatYear = 1989
lasso linear cig0 cig1-cig39 lny1-lny39 if year <= $TreatYear, select(plugin)
lassocoef
* Lasso 选中 8,15,19,21,29,34 + 截距；synth2 选中 4,5,19,21,34（部分重叠、可含负系数与截距）

cap dropvars cig0_lasso cig0_post gap*
predict cig0_lasso                       // 惩罚系数预测
predict cig0_post, postselection         // 后选择（无惩罚）系数预测
gen gap_lasso = cig0 - cig0_lasso
gen gap_post  = cig0 - cig0_post

#delimit ;
tw (line cig0       year, lc(black))
   (line cig0_lasso year, lc(red))
   (line cig0_post  year, lc(blue))
   (line gap_lasso  year, lc(red)  lp(dash))
   (line gap_post   year, lc(blue) lp(dash))
   ,
   ylabel(-40(20)140) xlabel(1972(4)2000)
   xline($TreatYear 1988, lc(gray) lp(dash_dot))
   yline(0, lc(black) lp(dot))
   xtitle("year") ytitle("per-capita cigarette sales (packs)")
   legend(order(1 "CA" 2 "syn-Lasso" 3 "syn-Post-Lasso" 4 "Gap")
          ring(0) col(1) pos(2))
   aspect(0.8);
#delimit cr

*-绘图子程序：供下面时间安慰剂检验复用
cap program drop lasso_smoking_graph
program define lasso_smoking_graph
#delimit ;
tw (line cig0       year, lc(black))
   (line cig0_lasso year, lc(red))
   (line cig0_post  year, lc(blue))
   (line gap_lasso  year, lc(red)  lp(dash))
   (line gap_post   year, lc(blue) lp(dash))
   ,
   ylabel(-40(20)140) xlabel(1972(4)2000)
   xline($TreatYear 1988, lc(gray) lp(dash_dot))
   yline(0, lc(black) lp(dot))
   xtitle("year") ytitle("per-capita cigarette sales (packs)")
   legend(order(1 "CA" 2 "syn-Lasso" 3 "syn-Post-Lasso" 4 "Gap")
          ring(0) col(1) pos(2))
   aspect(0.8);
#delimit cr
end

*-时间安慰剂检验：plugin，安慰剂年 1984
use "smoking_wide.dta", clear
global TreatYear = 1984
lasso linear cig0 cig1-cig39 lny1-lny39 if year <= $TreatYear, select(plugin)
cap dropvars cig0_lasso cig0_post gap*
predict cig0_lasso
predict cig0_post, postselect
gen gap_lasso = cig0 - cig0_lasso
gen gap_post  = cig0 - cig0_post
lasso_smoking_graph

*-时间安慰剂检验：10 折 CV 选 λ，安慰剂年 1984
use "smoking_wide.dta", clear
global TreatYear = 1984
lasso linear cig0 cig1-cig39 lny1-lny39 ///
      if year <= $TreatYear,           ///
      select(cv, fold(10)) nolog
cap dropvars cig0_lasso cig0_post gap*
predict cig0_lasso
predict cig0_post, postselect
gen gap_lasso = cig0 - cig0_lasso
gen gap_post  = cig0 - cig0_post
lasso_smoking_graph
* 注：若 TreatYear<=1983 则政策前样本太少，10 折 CV 无法执行

*-时间安慰剂检验：自适应 CV 选 λ，安慰剂年 1984
use "smoking_wide.dta", clear
global TreatYear = 1984
lasso linear cig0 cig1-cig39 lny1-lny39 ///
      if year <= $TreatYear,           ///
      select(adaptive, fold(10)) nolog
cap dropvars cig0_lasso cig0_post gap*
predict cig0_lasso
predict cig0_post, postselect
gen gap_lasso = cig0 - cig0_lasso
gen gap_post  = cig0 - cig0_post
lasso_smoking_graph


*-------------------- A5.4 回归控制法 RCM
frame reset
use "$net/smoking.dta", clear
xtset state year

rcm cig, trunit(3) trperiod(1989) method(lasso) criterion(cv) frame(te)
* post-lasso OLS：Colorado .063 / Montana .418 / Nevada .218 / NewHampshire .038 / _cons 12.46
* 政策后期平均处理效应约 -23.1（口径不同于 SDID，勿直接比较）

graph display pred
graph export "rcm-Abadie2010-Fig02.png", replace width(900)
graph display eff
graph export "rcm-Abadie2010-Fig03.png", replace width(900)

*-安慰剂检验：截面（所有对照州轮流当假处理组）+ 时间（假处理年 1984）
rcm cig, trunit(3) trperiod(1989) method(lasso) criterion(cv) ///
         placebo(unit period(1984))


*-------------------- A5.5 合成 DID（SDID）
webuse set www.damianclarke.net/stata/
webuse prop99_example.dta, clear
encode state, gen(id_state)
xtset id_state year
xtdes                                    // 确认为强平衡面板：39 州 × 31 年

*-基础用法：ATT ≈ -15.60
sdid packspercapita state year treated, vce(placebo) seed(1213)

*-带图（图 5.4）：趋势图 + 权重图
#delimit ;
sdid packspercapita state year treated,
     vce(placebo) seed(1213) reps(100)
     graph g1on
     g2_opt(ylabel(0(25)150) ytitle("Packs per capita") scheme(white_tableau))
     g1_opt(xtitle("") ylabel(-35(5)10) scheme(white_tableau))
     graph_export(SDID_cig_002, .png);
#delimit cr

*-三方法对比：SDID -15.6 / DID -27.3 / SC -19.6
global yx "packspercapita state year treated"
global scheme "scheme(white_tableau)"

sdid $yx, method(sdid) vce(noinference) graph                     ///
     g1_opt(ylabel(-110(20)50) xtitle("") $scheme) g1on           ///
     g2_opt(ylabel(0(25)150) ytitle("Packs per capita") $scheme)  ///
     graph_export(comp_cig_01_sdid, .png)

sdid $yx, method(did) vce(noinference) graph msize(small)         ///
     g1_opt(ylabel(-110(20)50) xtitle("") $scheme) g1on           ///
     g2_opt(ylabel(0(25)150) ytitle("Packs per capita") $scheme)  ///
     graph_export(comp_cig_02_did, .png)

sdid $yx, method(sc) vce(noinference) graph msize(small)          ///
     g1_opt(ylabel(-110(20)50) xtitle("") $scheme) g1on           ///
     g2_opt(ylabel(0(25)150) ytitle("Packs per capita") $scheme)  ///
     graph_export(comp_cig_03_sc, .png)


*==============================================================
* 数值汇总（packs per capita）：
*   DID  -27.3  等权平均，受长期趋势不平行拖累最大
*   SC   -19.6  截面加权贴近
*   SDID -15.6  单位+时间双重加权
*   RCM  -23.1  post-lasso 预测（口径不同，勿直接比较）
* 教学要点：数值差异源于反事实构造方式不同，非"谁更准"。
*==============================================================
