# 第六章 DID 方法选择：材料汇总

## 第六章定位

第六章题目：

```text
双重差分法怎么选：从 TWFE 到现代 DID 估计量
```

本章不再泛泛讨论所有反事实构造方法，而是聚焦 DID 内部的方法选择问题：

> 当研究者已经确认自己的研究属于 DID 或类 DID 设计以后，面对 TWFE、`csdid`、`drdid`、Sun–Abraham、Borusyak–Jaravel–Spiess、`did2s`、`did_multiplegt_dyn`、DDD 等方法，到底应该如何选择？

正文讲方法选择逻辑，代码和运行结果放 A6 附录。

## 当前第六章结构

```text
为什么 DID 方法突然变多了
从 2×2 DID 看清楚「两次差分」
交错处理：TWFE 到底在比较谁
ATT(g,t)：拆开再加总
三条修正思路，而不是一堆命令
平行趋势的现代理解
DDD：什么时候需要第三重差异
一篇论文里的证据架构：多方法如何分工
方法选择表与通向第七章
```

这 9 节应形成一条认知弧线：

```text
最清楚的 2×2 DID
→ 事件研究把一个效应展开为动态路径
→ 交错处理让比较对象不透明
→ Bacon 分解揭示 TWFE 背后的多个 2×2 比较
→ ATT(g,t) 把比较拆开再加总
→ 现代 DID 方法提供不同修正思路
→ 平行趋势需要现代敏感性理解
→ DDD 处理第三重差异
→ 多方法构成论文证据架构
```

## 必须吸收的 FWL-DID 材料

来源文件：

```text
A5-03-OLS-FWL定理-DID.md
```

其中「FWL 应用 4：倍分法 (DID)」应当成为第六章第 2 节的核心材料。该材料包含：

- DID 基本思想动图；
- 标准 2×2 DID 回归；
- 四个条件均值；
- $\theta_1$、$\theta_2$ 和 $\gamma$ 的系数含义；
- 标准 DID 四格均值表；
- Card and Krueger (1994) 最低工资案例。

### 应转化为正文的核心内容

最基础的 2×2 DID：

$$
y_{it}
=
\alpha
+\theta_1 Treat_i
+\theta_2 Post_t
+\gamma (Treat_i\times Post_t)
+\varepsilon_{it}
$$

四个均值：

$$
E(y_{it}\mid Treat=0,Post=0)=\alpha=C_0
$$

$$
E(y_{it}\mid Treat=1,Post=0)=\alpha+\theta_1=Y_0
$$

$$
E(y_{it}\mid Treat=0,Post=1)=\alpha+\theta_2=C_1
$$

$$
E(y_{it}\mid Treat=1,Post=1)=\alpha+\theta_1+\theta_2+\gamma=Y_1
$$

系数含义：

$$
\theta_1=Y_0-C_0
$$

表示政策前处理组和控制组的水平差异。

$$
\theta_2=C_1-C_0
$$

表示控制组从政策前到政策后的时间变化。

DID 交互项：

$$
\begin{aligned}
\gamma
&=(Y_1-C_1)-(Y_0-C_0)\\
&=(Y_1-Y_0)-(C_1-C_0)
\end{aligned}
$$

这说明 DID 的核心不是比较 $Y_1$ 和 $C_1$，也不是只比较 $Y_1$ 和 $Y_0$，而是用控制组的同期变化扣除共同时间趋势。

## 图形材料

### 已有图形 / 动图

来源于 FWL 讲义材料：

```text
Animation-of-DID-01.gif
```

用途：直观展示 DID 的基本思想。可作为课堂讲解辅助。正文中是否直接引用取决于最终排版和图床可用性。

### 待制作图 6.1：从 TWFE 到现代 DID 的问题链

```text
政策分批执行
→ 处理效应可能异质
→ TWFE 混合多个比较
→ 需要定义有效比较
→ 估计 ATT(g,t)
→ 根据目标参数聚合
```

用途：第六章开篇图，建立全章主线。

### 待制作图 6.2：2×2 DID 四格均值图

| | 政策前 | 政策后 |
|---|---|---|
| 控制组 | $C_0$ | $C_1$ |
| 处理组 | $Y_0$ | $Y_1$ |

图中应当用箭头展示：

- 处理组前后变化：$Y_1-Y_0$；
- 控制组前后变化：$C_1-C_0$；
- DID：$(Y_1-Y_0)-(C_1-C_0)$；
- 或者政策后组间差异减去政策前组间差异：$(Y_1-C_1)-(Y_0-C_0)$。

用途：第六章最适合初学者的一张图，用来解释 $\gamma$ 来自哪两次差分。

### 待制作图 6.3：交错处理下的四类单位时间线

内容：横轴为年份，纵向列出 never-treated、not-yet-treated、already-treated、always-treated，用颜色或阴影标出处理前、处理后，显示哪些时期可以作为有效对照，哪些比较会被 already-treated 污染。

用途：全章招牌图，解释 Goodman-Bacon 分解和现代 DID 的问题来源。

### 待制作图 6.4：$ATT(g,t)$ 矩阵与聚合方向

内容：行为首次处理时间 $g$，列为日历时间 $t$，每个可估格子为 $ATT(g,t)$，用箭头显示 simple、group、calendar、event 四种聚合方向。

用途：解释 $ATT(g,t)$，说明聚合口径不是软件选项，而是目标参数。

### 待制作图 6.5：多估计量事件研究同框对比

来源：A6 附录运行结果。可比较 TWFE event-study、`csdid, agg(event)`、`eventstudyinteract`、`did_imputation`。

用途：展示不同估计量可能回答相近但不完全相同的问题。是否放入正文，待 A6 跑通后决定。

## A6 附录规划

文件：

```text
resources/did_methods/A06_did_method_selection.ipynb
resources/did_methods/A06_did_method_selection.do
```

A6 附录使用在线数据，不在本地存储原始数据。

主数据：

```stata
use https://friosavila.github.io/playingwithstata/drdid/mpdta.dta, clear
```

模块：

```text
A6.1 2×2 DID：四个均值与一个交互项
A6.2 数据与处理时点结构
A6.3 TWFE 基准与 bacondecomp 诊断
A6.4 csdid：ATT(g,t)、never-treated 与 not-yet-treated、聚合口径
A6.5 drdid：两期 DID 的双重稳健示例
A6.6 eventstudyinteract 与 did_imputation：现代事件研究比较
A6.7 honestdid：平行趋势敏感性分析
A6.8 多估计量同框对比图
A6.9 方法与软件地图
```

必跑模块：A6.1、A6.2、A6.3、A6.4、A6.5。

可选模块：`bacondecomp`、`eventstudyinteract`、`did_imputation`、`honestdid`、多估计量同框比较图。

## 外部资源

正文和附录中可列为资源，但不能用它们替代讲义解释。

- Asjad Naqvi, DiD 方法与软件地图：`https://asjadnaqvi.github.io/DiD/`
- Pedro Sant’Anna, DiD Resources：`https://psantanna.com/did-resources/`
- Rios-Avila, `stpackages`：`https://github.com/friosavila/stpackages`
- `csdid`：`https://github.com/friosavila/stpackages/tree/main/csdid`
- `drdid`：`https://github.com/friosavila/stpackages/tree/main/drdid`
- Compare-DiD-Estimators：`https://github.com/friosavila/Compare-DiD-Estimators`
- Stata `honestdid`：`https://github.com/mcaceresb/stata-honestdid`

## 可复现文献建议

不加入中国场景数据。只列少量可复现材料供学生延伸阅读。

### Baker et al. JEL DID practitioner guide

适合放在第六章扩展资源中。Sant’Anna 的 DiD Resources 页面列出 JEL-DiD guide and replication files。该复现材料包含 R 和 Stata workflows、数据文档、生成的图表和 live code appendix。

### Borusyak, Jaravel and Spiess 的 imputation event-study 论文

适合放在「插补反事实」部分。核心是：在 staggered treatment adoption 和 heterogeneous treatment effects 下，用 imputation 思路先构造未处理反事实，再估计动态处理效应。

### Card and Krueger (1994)

适合放在 2×2 DID 基础部分。其作用不是展示现代 DID，而是让初学者看清楚处理组、对照组、政策前、政策后和交互项系数之间的关系。

## 需要避免的问题

第六章不要写成：

- `csdid` 教程；
- DID 软件清单；
- Goodman-Bacon 文献综述；
- 现代 DID 估计量堆砌；
- 平行趋势检验技巧清单；
- 外部链接集合。

第六章应该写成：

- 先讲清楚最基础的 2×2 DID；
- 再讲为什么交错处理让比较对象变复杂；
- 再讲 $ATT(g,t)$ 如何拆开再加总；
- 再讲现代 DID 方法按什么思路修正；
- 再讲平行趋势和 DDD 的适用边界；
- 最后讲一篇论文中如何组织多方法证据架构。
