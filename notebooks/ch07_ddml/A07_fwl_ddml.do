/*******************************************************************************
 附录 A7：从 FWL 到双重机器学习的 Stata 实操入口(纯 Stata 版)
 配套：第七章《控制变量既多又非线性时：从 FWL 到双重机器学习》
 数据：A7.1、A7.2 用内置模拟数据；A7.3 用 sipp1991(401k)、A7.4 用 cattaneo2、
       A7.5 用 AJR、A7.6 用 nlswork，全部在线读取，不占本地仓库
 说明：讲解版见 A07_fwl_ddml.ipynb(含逐段解读与对口文献)
       本文件为纯代码版，供习惯在 Stata 中直接执行的读者使用
 稳健性：核心命令用官方规范语法；pystacked 依赖 Python 集成，用 capture 包裹，
        失败不影响主线(主线仍有 reg / rlasso / rforest 等纯 Stata 学习器)
*******************************************************************************/

/*==============================================================
  A7.0 环境准备
==============================================================*/
version 17
set more off

* DDML 及相关命令(在线安装，已装则跳过)
cap which ddml
if _rc ssc install ddml, replace
cap which pystacked
if _rc ssc install pystacked, replace
cap which rlasso                      // 由 lassopack 提供 rlasso / cvlasso / lasso2
if _rc ssc install lassopack, replace
cap which rforest
if _rc ssc install rforest, replace

* 注：pystacked 需要 Stata 的 Python 集成(已装 Python + scikit-learn)。
*     若本机未配置，本文件中 pystacked 的行会被 capture 跳过，
*     主线改用 reg / rlasso / rforest 等纯 Stata 学习器仍可运行。

/*==============================================================
  A7.1 FWL 手算验证：三种回归给出同一个系数
  对应正文「FWL：partial out 是基本功」一节
==============================================================*/
clear
set seed 20260710
set obs 500
gen x2 = rnormal()
gen x1 = 0.7*x2 + rnormal()             // X1 与 X2 相关，制造需要 partial out 的场景
gen y  = 1 + 2*x1 + 3*x2 + rnormal()    // 真值：beta1 = 2

* (1) 完整回归：X1 与 X2 一起进模型
reg y x1 x2
scalar b_full = _b[x1]

* (2) FWL：把 X2 从 Y 和 X1 两边同时 partial out，再残差对残差
reg y x2
predict yt,  resid                      // Y 对 X2 的残差
reg x1 x2
predict x1t, resid                      // X1 对 X2 的残差
reg yt x1t                              // 残差对残差，系数应等于 b_full
scalar b_fwl = _b[x1t]

* (3) 只对 Y 一边剔除 X2(错误做法：漏了 X1 那一边)
reg yt x1                               // 用原始 x1，不是残差 x1t
scalar b_wrong = _b[x1]

di as txt "b_full = " as res %6.4f b_full ///
   as txt "   b_fwl = " as res %6.4f b_fwl ///
   as txt "   b_wrong = " as res %6.4f b_wrong

/*==============================================================
  A7.2 天真估计 vs 正交估计：偏误对比模拟
  对应正文「补救：对处理变量也 partial out」一节
  DGP: D = m0(X)+V,  Y = theta*D + g0(X)+U,  theta_0 = 1
       m0、g0 为二次+交互(非线性混淆)，线性设定不足以吸收
==============================================================*/
clear all
set seed 20260710

cap program drop ddmlsim
program define ddmlsim, rclass
    drop _all
    quietly set obs 500
    forvalues j = 1/10 {
        quietly gen x`j' = rnormal()
    }
    * 非线性混淆
    quietly gen d = 0.8*x1 + 0.5*x2^2 - 0.4*x3*x4 + rnormal()
    quietly gen y = 1*d + 1.0*x1^2 + 0.6*x2 - 0.5*x3*x5 + rnormal()   // theta_0 = 1

    * 带正则化的灵活学习器(二次字典)，拟合两个辅助函数
    quietly rlasso y c.(x1-x10)##c.(x1-x10)
    quietly predict double yhat, xb
    quietly gen double yr = y - yhat                 // Y 的残差

    quietly rlasso d c.(x1-x10)##c.(x1-x10)
    quietly predict double dhat, xb
    quietly gen double dr = d - dhat                 // D 的残差

    * 天真：只对 Y 一边扣掉 X，再用原始 D 回归
    quietly reg yr d
    return scalar naive = _b[d]

    * 正交：对 D 也扣掉 X，用残差对残差
    quietly reg yr dr
    return scalar ortho = _b[dr]
end

simulate naive = r(naive) ortho = r(ortho), reps(200): ddmlsim
summ naive ortho
* 真值 theta_0 = 1：naive 的均值应明显偏离 1，ortho 的均值应接近 1

/*==============================================================
  A7.3 部分线性模型 ddml partial(401k 数据)
  对应正文「DDML 的完整流程」一节、表 @tbl-cipolicy-ddml-models
  官方示例：Y=net_tfa(净金融资产)，D=e401(401k 资格)，X=一组家庭特征
==============================================================*/
use https://github.com/aahrens1/ddml/raw/master/data/sipp1991.dta, clear

global Y net_tfa
global D e401
global X tw age inc fsize educ db marr twoearn pira hown
set seed 42

ddml init partial, kfolds(2)

* 结果侧 E[Y|X]：先加一个纯 Stata 线性学习器(必定可跑)，再加 pystacked 随机森林
ddml E[Y|X]: reg $Y $X
capture noisily ddml E[Y|X]: pystacked $Y $X, type(reg) method(rf)

* 处理侧 E[D|X]：同样两个学习器
ddml E[D|X]: reg $D $X
capture noisily ddml E[D|X]: pystacked $D $X, type(reg) method(rf)

ddml crossfit
ddml estimate, robust allcombos

/*==============================================================
  A7.4 交互模型 ddml interactive(cattaneo2 数据)
  对应表 @tbl-cipolicy-ddml-models 的 interactive 行
  官方示例：Y=bweight(出生体重)，D=mbsmoke(孕期吸烟，二元)，估 ATE
==============================================================*/
webuse cattaneo2, clear

global Y bweight
global D mbsmoke
global X mage prenatal1 mmarried fbaby medu
set seed 42

ddml init interactive, kfolds(5) reps(5)

* 结果侧 E[Y|X,D](交互模型对处理分别建模)
ddml E[Y|X,D]: reg $Y $X
capture noisily ddml E[Y|X,D]: pystacked $Y $X, type(reg) method(gradboost)

* 处理侧 E[D|X]：二元处理用 logit / 分类学习器
ddml E[D|X]: logit $D $X
capture noisily ddml E[D|X]: pystacked $D $X, type(class) method(gradboost)

ddml crossfit
ddml estimate

/*==============================================================
  A7.5 部分线性 IV 模型 ddml iv(AJR 数据)
  对应表 @tbl-cipolicy-ddml-models 的 iv 行
  官方示例：Y=logpgp95，D=avexpr(内生)，Z=logem4(工具)，X=一组地理/制度控制
  注：IV 需要有效工具变量，401k/cattaneo2 没有，故用官方 AJR 示例数据
  学习器用 rforest(纯 Stata 插件，无需 Python)，演示无 pystacked 时的灵活学习器
==============================================================*/
use https://statalasso.github.io/dta/AJR.dta, clear

global Y logpgp95
global D avexpr
global Z logem4
global X lat_abst edes1975 avelf temp* humid* steplow-oilres
set seed 42

ddml init iv, kfolds(30)

ddml E[Y|X]: reg $Y $X
capture noisily ddml E[Y|X], vtype(none): rforest $Y $X, type(reg)
ddml E[D|X]: reg $D $X
capture noisily ddml E[D|X], vtype(none): rforest $D $X, type(reg)
ddml E[Z|X]: reg $Z $X
capture noisily ddml E[Z|X], vtype(none): rforest $Z $X, type(reg)

qui ddml crossfit
ddml estimate, robust

/*==============================================================
  A7.6 面板固定效应：别直接把 within 变换套截面 DDML(最小示意 + 局限)
  对应正文 callout「面板固定效应：别直接套截面 DDML」
  这里只演示「within 变换后套截面 ddml」的做法，并强调其局限，非推荐方案
==============================================================*/
webuse nlswork, clear
xtset idcode year
keep if !missing(ln_wage, union, age, ttl_exp, tenure, hours)

* 手动 within(去个体均值)变换
foreach v in ln_wage union age ttl_exp tenure hours {
    bysort idcode: egen double m_`v' = mean(`v')
    gen double w_`v' = `v' - m_`v'
}

global Y w_ln_wage
global D w_union
global X w_age w_ttl_exp w_tenure w_hours
set seed 42

ddml init partial, kfolds(2)
ddml E[Y|X]: reg $Y $X
capture noisily ddml E[Y|X]: pystacked $Y $X, type(reg) method(rf)
ddml E[D|X]: reg $D $X
capture noisily ddml E[D|X]: pystacked $D $X, type(reg) method(rf)
ddml crossfit
ddml estimate, robust

* 局限提醒：标准 ddml 是截面框架。直接 within 后套 ddml 会有两类问题——
* (1) within 变换引入的依赖，使随机分折不再合理(应按个体分折)；
* (2) 未观测个体异质性的处理更稳妥的做法是相关随机效应(Mundlak/CRE)。
* 系统的面板实现见 R 包 xtdml(Clarke and Polselli 2026)；
* 面板下的分折与 CRE 讨论见 Fuhr and Papies (2024)。本模块仅作风险提示。

/*==============================================================
  对口文献(含复现资料)—— 详见 notebook 各节：
   Frisch-Waugh-Lovell            Filoso (2013, Stata Journal); 李金桐 (2023, 连享会)
   DDML 奠基                       Chernozhukov et al. (2018, Econometrics Journal)
   ddml 官方导论 / Stata 实现       Ahrens et al. (2025, arXiv:2504.08324);
                                   Ahrens et al. (2024, Stata Journal 24(1))
   官方文档站                       https://statalasso.github.io/docs/ddml/
   stacking 学习器                  Ahrens et al. (2024, Model Averaging and DML)
   面板 DDML                       Clarke and Polselli (2026); Fuhr and Papies (2024)
                                   R 包 xtdml: https://github.com/POLSEAN/xtdml
   遗漏变量敏感性                    Chernozhukov et al. (2022, Long Story Short)
  End of A07_fwl_ddml.do
==============================================================*/
