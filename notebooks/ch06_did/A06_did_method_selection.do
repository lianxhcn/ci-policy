/*******************************************************************************
 附录 A6：现代 DID 估计量的 Stata 实操入口（纯 Stata 版）
 配套：第六章《双重差分法怎么选》
 数据：A6.2 用 3 个体×10 期内置模拟；其余用 mpdta.dta（在线读取）
 说明：讲解版见 A06_did_method_selection.ipynb（含逐段解读与对口文献）
       本文件为纯代码版，供习惯在 Stata 中直接执行的读者使用
 稳健性：核心命令用官方规范语法；版本敏感命令用 capture 包裹，失败不影响主线
*******************************************************************************/


/*==============================================================
  A6.0 环境准备
==============================================================*/

clear all
set more off
version 17

* --- 基础依赖 ---
cap which ftools
if _rc ssc install ftools, replace
cap which reghdfe
if _rc ssc install reghdfe, replace

* --- DID 核心命令 ---
cap which drdid
if _rc ssc install drdid, replace        // csdid 的依赖，需先装
cap which csdid
if _rc ssc install csdid, replace
cap which bacondecomp
if _rc ssc install bacondecomp, replace

* --- 可选命令（版本敏感，失败不影响主线）---
cap which eventstudyinteract
if _rc cap ssc install eventstudyinteract, replace
cap which did_imputation
if _rc cap ssc install did_imputation, replace
cap which did2s
if _rc cap ssc install did2s, replace
* honestdid 通常需从 GitHub 安装，见 A6.7


/*==============================================================
  A6.1 2×2 DID：四个均值与一个交互项
==============================================================*/

clear
set seed 20260708
set obs 200
gen id    = _n
gen treat = id > 100                       // 后 100 个为处理组
expand 2                                    // 每个单位两期
bysort id: gen post = _n - 1                // 0=政策前, 1=政策后

* DGP: 个体基线 + 时间趋势 + 政策效应(仅处理组×政策后)
gen y = 10 + 2*treat + 4*post + 3*(treat*post) + rnormal(0,1)
*        C0     θ1        θ2        γ=政策效应

* 四个组别-时期均值
table post treat, stat(mean y) nformat(%6.2f)

* DID 回归：交互项系数应还原 γ≈3
reg y i.treat##i.post, vce(robust)


/*==============================================================
  A6.2 Bacon 分解：三单位最小例子与权重手算
==============================================================*/

clear
set obs 3
gen id = _n
expand 10
bysort id: gen t = _n
xtset id t

* 吸收性处理：id=2 自 t=5 起，id=3 自 t=8 起
gen D = (id==2 & t>=5) | (id==3 & t>=8)

* 结果 = 个体基线 + 共同时间趋势 + 恒定处理效应(2 与 4)
gen y = 2*id + 0.1*t + cond(id==2, 2, cond(id==3, 4, 0))*D

* TWFE：交错处理下的混合系数
reg y D i.id i.t

* Bacon 分解：ddetail 给出每个 2×2 的估计值与权重
capture noisily bacondecomp y D, ddetail
if _rc di as error "bacondecomp 未运行成功，help bacondecomp 核对语法。"


/*==============================================================
  A6.3 数据与处理时点结构
==============================================================*/

use https://friosavila.github.io/playingwithstata/drdid/mpdta.dta, clear

describe
* 关键变量：countyreal(县) year(年) lemp(就业,结果) lpop(人口,协变量)
*           first_treat(首次处理年份, 0=never-treated)

* 处理时点结构：看每个 first_treat 批次各有多少县
tab year first_treat

* 构造"当期是否处于处理中"的状态变量(供 TWFE 用)
gen treated = (first_treat > 0) & (year >= first_treat)
tab year treated
xtset countyreal year


/*==============================================================
  A6.4 TWFE 基准与 Bacon 分解诊断
==============================================================*/

* TWFE 基准
reghdfe lemp treated lpop, absorb(countyreal year) vce(cluster countyreal)
estimates store twfe

* Bacon 分解：把 TWFE 系数拆成若干 2x2 DID 的加权平均
capture noisily bacondecomp lemp treated, ddetail
if _rc di as error "bacondecomp 未运行成功，可 help bacondecomp 核对语法或数据要求。"


/*==============================================================
  A6.5 csdid：估计 ATT(g,t) 再聚合
==============================================================*/

use https://friosavila.github.io/playingwithstata/drdid/mpdta.dta, clear

* 第一步：估计所有 ATT(g,t)，用 never-treated 作对照，双重稳健 IPW
csdid lemp lpop, ivar(countyreal) time(year) gvar(first_treat) method(dripw)

* 第二步：按不同目标参数聚合(postestimation)
estat simple      // 总体 ATT(按组规模加权，非等权)
estat event       // 动态 ATT：处理后第 k 年的效应
estat calendar    // 日历年 ATT
estat group       // 分组 ATT：各批次的效应

* 事件研究图
csdid_plot

* 改用 not-yet-treated 作对照组
csdid lemp lpop, ivar(countyreal) time(year) gvar(first_treat) ///
      method(dripw) notyet
estat event

* 事件研究图
csdid_plot


/*==============================================================
  A6.6 drdid：RA、IPW 与双重稳健的两期对比
==============================================================*/

use https://friosavila.github.io/playingwithstata/drdid/mpdta.dta, clear

* 压成 2×2：2004 处理组 vs never-treated，2003(前) vs 2004(后)
keep if first_treat == 2004 | first_treat == 0
keep if inlist(year, 2003, 2004)

* mpdta 自带 treat 变量(标记 eventually-treated)，先删除以免歧义，再按本例定义重建
drop treat
gen treat = (first_treat == 2004)          // 单位级、时间不变
tab year treat

* 普通 DID 基准
reg lemp i.treat##i.year lpop, vce(cluster countyreal)

* 对应正文三式，逐一估计
drdid lemp lpop, ivar(countyreal) time(year) tr(treat) reg     // RA：只用结果模型
drdid lemp lpop, ivar(countyreal) time(year) tr(treat) ipw     // IPW：只用倾向得分
drdid lemp lpop, ivar(countyreal) time(year) tr(treat) dripw   // 双重稳健 IPW


/*==============================================================
  A6.7 现代事件研究修正（可选模块）
==============================================================*/

use https://friosavila.github.io/playingwithstata/drdid/mpdta.dta, clear

gen never   = (first_treat == 0)
gen treated = (first_treat > 0) & (year >= first_treat)
gen rel   = year - first_treat if first_treat > 0   // 相对处理时间

* 构造 lead/lag 虚拟变量(排除基准期 rel=-1)
forvalues k = -3/3 {
    local nm = cond(`k'<0, "m"+string(abs(`k')), "p"+string(`k'))
    gen g_`nm' = (rel == `k')
    replace g_`nm' = 0 if missing(rel)
}
drop g_m1                                    // 基准期归一化

* 传统 TWFE 事件研究(作对照)
reghdfe lemp g_m3 g_m2 g_p0 g_p1 g_p2 g_p3 lpop, ///
    absorb(countyreal year) vce(cluster countyreal)

* Sun-Abraham：按队列估事件效应，避免污染(可选)
capture noisily eventstudyinteract lemp g_m3 g_m2 g_p0 g_p1 g_p2 g_p3, ///
    cohort(first_treat) control_cohort(never) ///
    absorb(countyreal year) vce(cluster countyreal)
if _rc di as error "eventstudyinteract 未运行成功，help eventstudyinteract 核对语法。"

* BJS 插补法(可选)：参数顺序为 Y i t Ei
capture noisily did_imputation lemp countyreal year first_treat, ///
    horizons(0/3) pretrends(3) fe(countyreal year) controls(lpop) cluster(countyreal)
if _rc di as error "did_imputation 未运行成功，help did_imputation 核对语法。"


* did2s 两步法(可选)：第一步只用固定效应净化结果，第二步在净化后的结果上估事件效应
capture noisily did2s lemp, first_stage(i.countyreal i.year) ///
    second_stage(g_m3 g_m2 g_p0 g_p1 g_p2 g_p3) treatment(treated) cluster(countyreal)
if _rc di as error "did2s 未运行成功，help did2s 核对语法。"


/*==============================================================
  A6.8 honestdid：平行趋势敏感性分析（可选模块）
==============================================================*/

* 安装(以官方 README 为准)
cap which honestdid
if _rc {
    cap net install honestdid, ///
        from("https://raw.githubusercontent.com/mcaceresb/stata-honestdid/main") replace
}

use https://friosavila.github.io/playingwithstata/drdid/mpdta.dta, clear

* 先用 csdid 得到事件研究估计(honestdid 可直接读取 csdid 结果)
qui csdid lemp lpop, ivar(countyreal) time(year) gvar(first_treat) ///
     method(dripw) agg(event)

* 敏感性分析：Mbar 取 0.5、1、1.5、2
* Mbar = 允许的政策后趋势偏离相对于政策前最大偏离的倍数
capture noisily honestdid, pre(1/3) post(4/6) mvec(0.5(0.5)2) coefplot
if _rc di as error "honestdid 未运行成功，请见 GitHub README 核对安装与语法。"


/*==============================================================
  A6.9 多估计量同框对比图（可选模块）
==============================================================*/

use https://friosavila.github.io/playingwithstata/drdid/mpdta.dta, clear

qui csdid lemp lpop, ivar(countyreal) time(year) gvar(first_treat) ///
     method(dripw) agg(event)
csdid_plot

* 多估计量同框思路：
*  1. 分别运行 csdid / eventstudyinteract / twfe，各自取出 event_time、coef、se；
*  2. 拼成长表(event_time coef lb ub method)；
*  3. twoway (rcap lb ub event_time) (connected coef event_time), by(method)
di as text "多估计量同框图：按上述三步在本地整理后绘制。"


/*==============================================================
  A6.10 方法与软件地图
==============================================================*/


/*==============================================================
  对口文献（含复现资料）—— 详见 notebook 各节：
   Goodman-Bacon (2021, JoE)         bacondecomp / Naqvi 教学页
   Callaway & Sant'Anna (2021, JoE)  https://bcallaway11.github.io/did/
   Sant'Anna & Zhao (2020, JoE)      https://github.com/pedrohcgs/DRDID
   Sun & Abraham (2021, JoE)         https://github.com/lsun20/EventStudyInteract
   Gardner (2022)                    https://github.com/kylebutts/did2s_stata
   Borusyak, Jaravel & Spiess (2024, REStud) https://github.com/borusyak/did_imputation
   Rambachan & Roth (2023, REStud)   https://github.com/mcaceresb/stata-honestdid
   Liu (2023, Stata Webinar)         hdidweb1.pdf
  End of A06_did_method_selection.do
==============================================================*/
