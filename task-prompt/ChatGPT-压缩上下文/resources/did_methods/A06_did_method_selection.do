/*******************************************************************************
附录 A6：现代 DID 估计量的 Stata 实操入口
说明：本 do-file 与 A06_did_method_selection.ipynb 对应。
数据：全部在线读取，不在本地存储原始数据。
*******************************************************************************/

clear all
set more off
set linesize 120
version 17

/*******************************************************************************
A6.0 环境准备
*******************************************************************************/

cap which ftools
if _rc ssc install ftools, replace

cap which reghdfe
if _rc ssc install reghdfe, replace

cap which csdid
if _rc ssc install csdid, all replace

cap which drdid
if _rc ssc install drdid, replace

cap which bacondecomp
if _rc ssc install bacondecomp, replace

cap which eventstudyinteract
if _rc ssc install eventstudyinteract, replace

cap which did_imputation
if _rc ssc install did_imputation, replace

cap which did2s
if _rc ssc install did2s, replace

/*******************************************************************************
A6.1 数据与处理时点结构
*******************************************************************************/

use https://friosavila.github.io/playingwithstata/drdid/mpdta.dta, clear

describe
summarize lemp lpop first_treat year
tab year
tab first_treat

gen treated = first_treat > 0 & year >= first_treat
label var treated "Treatment status by first_treat and year"

tab year treated
xtset countyreal year

/*******************************************************************************
A6.2 TWFE 基准与 Bacon 分解诊断
*******************************************************************************/

reghdfe lemp treated lpop, absorb(countyreal year) vce(cluster countyreal)
estimates store twfe_base

capture noisily bacondecomp lemp treated, ddetail
if _rc {
    di as error "bacondecomp 未能运行。请检查命令安装或语法版本。"
}

/*******************************************************************************
A6.3 csdid：估计 ATT(g,t) 并聚合
*******************************************************************************/

csdid lemp lpop, ivar(countyreal) time(year) ///
    gvar(first_treat) method(dripw) agg(simple)
estimates store csdid_simple

csdid lemp lpop, ivar(countyreal) time(year) ///
    gvar(first_treat) method(dripw) agg(event)
estimates store csdid_event

capture noisily csdid lemp lpop, ivar(countyreal) time(year) ///
    gvar(first_treat) method(dripw) agg(event) notyet
if _rc {
    di as error "notyet 版本未能运行。请检查当前 csdid 版本帮助文件。"
}

/*******************************************************************************
A6.4 drdid：两期 DID 的双重稳健示例
*******************************************************************************/

use https://friosavila.github.io/playingwithstata/drdid/mpdta.dta, clear

keep if first_treat == 2004 | first_treat == 0
keep if inlist(year, 2003, 2004)

gen treat = first_treat == 2004
gen post  = year == 2004

tab year treat

reg lemp i.treat##i.post lpop, vce(cluster countyreal)

capture noisily drdid lemp lpop, ivar(countyreal) time(year) tr(treat)
if _rc {
    di as error "drdid 未能运行。请在本地执行 help drdid 核验当前版本语法。"
}

/*******************************************************************************
A6.5 现代事件研究修正：可选模块
*******************************************************************************/

use https://friosavila.github.io/playingwithstata/drdid/mpdta.dta, clear

gen treated = first_treat > 0 & year >= first_treat
gen rel_year = year - first_treat if first_treat > 0
gen never_treat = first_treat == 0

forvalues k = -4/5 {
    local nm = cond(`k' < 0, "m" + string(abs(`k')), "p" + string(`k'))
    gen rel_`nm' = rel_year == `k'
    replace rel_`nm' = 0 if missing(rel_`nm')
}

drop rel_m1

reghdfe lemp rel_m4 rel_m3 rel_m2 rel_p0 rel_p1 rel_p2 rel_p3 rel_p4 rel_p5 lpop, ///
    absorb(countyreal year) vce(cluster countyreal)

capture noisily eventstudyinteract lemp rel_m4 rel_m3 rel_m2 rel_p0 rel_p1 rel_p2 rel_p3 rel_p4 rel_p5, ///
    absorb(countyreal year) cohort(first_treat) control_cohort(never_treat) vce(cluster countyreal)
if _rc {
    di as error "eventstudyinteract 未能运行。请检查命令安装和语法版本。"
}

capture noisily did_imputation lemp countyreal year first_treat, ///
    horizons(0/5) pretrend(4) controls(lpop) cluster(countyreal)
if _rc {
    di as error "did_imputation 未能运行。请检查命令安装和语法版本。"
}

/*******************************************************************************
A6.6 honest DiD：平行趋势敏感性分析
*******************************************************************************/

* 可选安装方式，请以 GitHub README 为准：
* net install honestdid, from("https://raw.githubusercontent.com/mcaceresb/stata-honestdid/main") replace
di as text "honestdid 模块为可选敏感性分析。请根据本地安装说明运行。"

/*******************************************************************************
A6.7 多估计量同框对比图
*******************************************************************************/

di as text "多估计量同框图需在本地整理结果后生成。"

/*******************************************************************************
A6.8 方法与软件地图
*******************************************************************************/

di as text "Asjad Naqvi DiD: https://asjadnaqvi.github.io/DiD/"
di as text "Pedro Sant'Anna DiD Resources: https://psantanna.com/did-resources/"
di as text "Rios-Avila stpackages: https://github.com/friosavila/stpackages"
di as text "csdid: https://github.com/friosavila/stpackages/tree/main/csdid"
di as text "drdid: https://github.com/friosavila/stpackages/tree/main/drdid"
di as text "Compare-DiD-Estimators: https://github.com/friosavila/Compare-DiD-Estimators"
di as text "honestdid: https://github.com/mcaceresb/stata-honestdid"

*******************************************************************************
* End of A06_did_method_selection.do
*******************************************************************************
