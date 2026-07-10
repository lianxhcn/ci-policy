# 第六章规划：双重差分法怎么选

> 本文件是《因果推断：政策评估中的识别思维与实证设计》第六章的更新版写作规划。全书采用八章方案：第五章讲反事实构造，第六章讲 DID 方法选择，第七章讲 FWL / DDML，第八章讲 AI Agent 工作流。

## 一、本章定位

第五章已经把政策评估的核心问题讲清楚：政策效果不是政策后的变化本身，而是实际结果与反事实结果之间的差距。第五章的任务是回答「反事实从哪里来」，因此它讨论 ITSA、DID、RDD、SCM、RCM 和 SDID 这些不同反事实构造方式。

第六章进一步聚焦 DID。它不再泛泛讨论所有反事实构造方法，而是回答一个更具体、更常见的实证问题：

> 当研究者已经确认自己的研究属于 DID 或类 DID 设计以后，面对 TWFE、`csdid`、`drdid`、Sun–Abraham、Borusyak–Jaravel–Spiess、`did2s`、`did_multiplegt_dyn`、DDD 等方法，到底应该如何选择？

本章不写成命令手册。正文讲选择逻辑、适用场景和证据组织方式；代码、运行结果和命令比较放到附录 A6。

本次更新特别加入一个重要教学入口：在进入 Goodman-Bacon 分解、交错处理和现代 DID 估计量之前，先用 FWL 讲义中的「DID 四格均值与交互项」把最基础的 2×2 DID 系数含义讲透。这个部分对初学者非常重要，因为现代 DID 的复杂性，本质上是最清楚的 2×2 DID 比较在多期、分批和异质效应场景中被打散了。

## 二、本章核心判断

本章可以用一句话概括：

> 现代 DID 方法的选择，不是看哪个命令最新，也不是看哪个结果更显著，而是看政策的处理时点结构、处理状态、有效对照组来源和研究者想估计的目标参数。先定义有效比较，再选择估计量。

这句话要贯穿全章。第六章不是简单告诉学生「TWFE 不好，改用 `csdid`」，而是帮助他们形成判断：

- 政策是否同一时间发生，还是分批发生？
- 处理状态是否一旦开启就持续存在？
- 是否有 never-treated？
- not-yet-treated 能否作为有效对照？
- already-treated 是否会污染比较？
- 研究目标是总体效应、动态路径、处理批次差异，还是某一日历年份的政策总影响？
- 是否需要控制协变量来使平行趋势更可信？
- 结果是否对平行趋势偏离敏感？
- 是否存在第三类差异趋势，需要使用 DDD？

## 三、与前后章节的关系

### 与第四章的关系

第四章的核心判断是：固定效应不是回归表底部的装饰，而是在声明「拿谁和谁比」。第六章正是这个判断在 DID 中的延伸。

TWFE DID 的问题，不是模型形式太旧，而是在交错处理和异质处理效应下，它的比较对象可能不透明。一个 $\beta$ 可能混合了许多 2×2 DID 比较，其中一些比较是清楚的，一些比较则把 already-treated 单位当作对照，导致反事实被污染。

### 与第五章的关系

第五章讲反事实构造的一般原则。第六章则聚焦 DID 内部的反事实和比较问题。

第五章问：

> 没有政策时，处理组会怎样？

第六章问：

> 如果我们决定采用 DID，应该用哪些单位、哪些时期、哪些对照组来构造这个反事实？

### 与第七章的关系

第六章结尾要自然过渡到第七章。`drdid` 的双重稳健思想已经提示：如果条件平行趋势需要控制协变量，那么就需要估计结果回归和处理倾向得分。若协变量很多、函数形式复杂，就会走向 FWL、partial out 和 DDML。

因此，第六章到第七章的接缝是：

> 条件平行趋势需要控制协变量；双重稳健需要估计 nuisance functions；当这些 nuisance functions 很复杂时，就需要第七章的 FWL / DDML。

## 四、正文结构

本章正文建议控制在 9 节，目标篇幅约 8500–9000 字。它不是 15 个小节的命令清单，而是一条认知弧线。

```text
# 双重差分法怎么选：从 TWFE 到现代 DID 估计量

## 为什么 DID 方法突然变多了
## 从 2×2 DID 看清楚「两次差分」
## 交错处理：TWFE 到底在比较谁
## ATT(g,t)：拆开再加总
## 三条修正思路，而不是一堆命令
## 平行趋势的现代理解
## DDD：什么时候需要第三重差异
## 一篇论文里的证据架构：多方法如何分工
## 方法选择表与通向第七章
```

本次更新将原来的「从 2×2 到事件研究」改为「从 2×2 DID 看清楚『两次差分』」。原因是：对初学者而言，先把四个均值、两个主效应和一个交互项讲清楚，比直接进入事件研究更重要。事件研究仍然要讲，但放在这一节后半部分，作为从一个 DID 系数走向动态路径的自然扩展。

## 五、逐节写作规划

### 为什么 DID 方法突然变多了

本节从读者困惑进入。过去很多论文只需要写一个 TWFE DID：

$$
Y_{it}=\alpha_i+\lambda_t+\beta D_{it}+\varepsilon_{it}
$$

但 Goodman-Bacon 分解以后，研究者意识到，在分批处理和异质处理效应下，这个 $\beta$ 可能不再是一个清楚的平均政策效应。它可能混合了多个 2×2 DID 比较，且其中一些比较并不适合用来构造无政策反事实。

本节要明确三点：

1. DID 没有被推翻；
2. TWFE 仍然可以作为基准展示；
3. 问题在于交错处理和异质效应下，比较对象不透明。

建议插图：图 6.1「从 TWFE 到现代 DID 的问题链」。

图中可以用箭头表示：

```text
政策分批执行
→ 处理效应可能异质
→ TWFE 混合多个比较
→ 需要定义有效比较
→ 估计 ATT(g,t)
→ 根据目标参数聚合
```

### 从 2×2 DID 看清楚「两次差分」

这是本次更新后新增强化的基础节。它应当成为第六章进入现代 DID 之前的关键台阶。

这一节的目的不是重复第五章对 DID 反事实的直观介绍，而是讲清楚 DID 回归系数到底来自哪四个均值。建议吸收 FWL 讲义中「FWL 应用 4：倍分法 (DID)」的核心内容，但改写为讲义正文，不直接照搬幻灯片格式。

#### 标准 DID：四个均值与一个交互项

最基础的 2×2 DID 可以写成：

$$
y_{it}
=
\alpha
+\theta_1 Treat_i
+\theta_2 Post_t
+\gamma (Treat_i\times Post_t)
+\varepsilon_{it}
$$

其中，$Treat_i$ 表示处理组，$Post_t$ 表示政策后时期，真正关心的是交互项系数 $\gamma$。

为了看清楚 $\gamma$ 的含义，先不考虑其他控制变量。四个组别—时期的条件均值分别为：

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

因此：

$$
\theta_1=Y_0-C_0
$$

表示政策前处理组和控制组的水平差异；

$$
\theta_2=C_1-C_0
$$

表示控制组从政策前到政策后的时间变化。

交互项系数则是：

$$
\begin{aligned}
\gamma
&=(Y_1-C_1)-(Y_0-C_0)\\
&=(Y_1-Y_0)-(C_1-C_0)
\end{aligned}
$$

第一种写法是「政策后组间差异」减去「政策前组间差异」；第二种写法是「处理组前后变化」减去「控制组前后变化」。这就是双重差分。

本节要强调：

> DID 的核心不是比较 $Y_1$ 和 $C_1$，也不是只比较 $Y_1$ 和 $Y_0$，而是用控制组的同期变化扣除共同时间趋势。

#### Card and Krueger 的最低工资例子

本节可以用 Card and Krueger (1994) 作为 2×2 DID 的经典例子。处理组是新泽西，控制组是宾夕法尼亚；政策前是最低工资上调前，政策后是上调后。回归式可以写成：

$$
Y_{its}
=
\alpha
+\gamma NJ_s
+\lambda Post_t
+\delta (NJ_s\times Post_t)
+\varepsilon_{its}
$$

其中，$\delta$ 就是 DID 估计量：

$$
\delta
=
(NJ_{Post}-NJ_{Pre})
-
(PA_{Post}-PA_{Pre})
$$

这个例子非常适合初学者，因为处理组、对照组、政策前后和交互项含义都很清楚。

#### 从一个 DID 系数走向事件研究

在 2×2 DID 中，政策效果被压缩成一个 $\gamma$。但许多政策效应不是一个点，而是一条路径。事件研究把一个平均效应展开为处理前后的动态路径：

$$
Y_{it}
=
\alpha_i+\lambda_t+
\sum_{k\ne -1}\beta_k
(D_i\times \mathbf{1}\{t-T_i=k\})
+\varepsilon_{it}
$$

本节可用 Lane (2025) 的韩国 HCI 政策作为例子。Lane 的动态 DID 不是为了画一张漂亮的图，而是为了回答：政策前目标产业是否已经变化？政策后效果是否逐渐出现？政策退出或转向后效果是否持续？

本节末尾应承接下一节：

> 2×2 DID 的最大优点，是比较对象非常清楚。我们知道处理组是谁、对照组是谁、政策前后是哪两个时期，也知道 $\gamma$ 来自哪四个均值。现代 DID 的许多问题，正是从这里开始的：当政策不是同一时间发生，而是分批发生；当处理效应会随处理后时间变化；当已经处理的单位被拿来当作其他单位的对照时，原本清楚的四格比较就会变得不透明。

### 交错处理：TWFE 到底在比较谁

这是本章第一核心节。

交错处理下，不同单位在不同时间接受政策。若仍然使用一个 TWFE 处理变量系数，就会把许多比较混在一起。

本节要讲清楚四类单位：

| 类型 | 含义 | 在 DID 中的作用 |
|---|---|---|
| Never-treated | 样本期内从未接受处理 | 通常可作为对照，但仍需平行趋势 |
| Not-yet-treated | 当前尚未处理，未来会处理 | 在尚未处理前可作为对照 |
| Already-treated | 当前已经处理 | 不宜作为无政策反事实 |
| Always-treated | 进入样本前已处理 | 通常无法识别处理前路径 |

教学上要重点讲透 already-treated 的污染机制。

例如，A 组 2005 年处理，B 组 2008 年处理。2005–2007 年，B 组还没有处理，可以作为 A 组的对照。但 2008 年以后，如果拿 A 组作为 B 组的对照，A 组已经受到政策影响。若政策效应会随时间积累，那么这相当于用一条已经被政策改变过的路径，去代表没有政策时的路径。

Goodman-Bacon 分解只需要给出简化表达：

$$
\widehat{\beta}^{TWFE}
=
\sum_{a,b} w_{ab}\widehat{\tau}_{ab}^{2\times2}
$$

解释即可：TWFE 系数可以看成多个 2×2 DID 的加权平均。问题不只是权重大小，而是某些 2×2 比较本身是否有效。

建议插图：图 6.2「交错处理下的四类单位时间线」。这是全章招牌图。

### ATT(g,t)：拆开再加总

这是本章第二核心节。

现代 DID 的基本思路是：不要把所有比较压缩成一个 TWFE 系数，而是先定义每个处理组别、每个时期的处理效应。

设 $G_i=g$ 表示单位 $i$ 首次接受处理的时间为 $g$，则：

$$
ATT(g,t)=E[Y_t(1)-Y_t(0)\mid G_i=g]
$$

在使用 never-treated 作为对照时，可以直观写成：

$$
ATT(g,t)
=
E(Y_t-Y_{g-1}\mid G_i=g)
-
E(Y_t-Y_{g-1}\mid C_i=1)
$$

如果使用 not-yet-treated，则对照组换成当前尚未处理的单位。

本节要强调：估计出一组 $ATT(g,t)$ 后，还需要根据研究问题聚合。

| 聚合口径 | 回答的问题 |
|---|---|
| Simple ATT | 总体平均政策效应是多少 |
| Group ATT | 不同处理批次效应是否不同 |
| Calendar ATT | 某一日历年份政策总体影响多大 |
| Event / Dynamic ATT | 处理后第 $k$ 年效应如何变化 |

本节要反复强调：

> 聚合口径不是软件选项，而是目标参数。研究者要先说明自己想回答的问题，再选择聚合方式。

建议插图：图 6.3「$ATT(g,t)$ 矩阵与四种聚合方向」。

### 三条修正思路，而不是一堆命令

本节避免按命令逐个介绍，而是按修正思想分类。

| 修正思路 | 代表方法 | 核心直觉 |
|---|---|---|
| 重建有效比较 | Callaway–Sant’Anna / `csdid`；Sun–Abraham / `eventstudyinteract` | 避免 already-treated 等坏比较，让每个事件时间效应有清楚对照 |
| 双重稳健 | `drdid`；`csdid` 中的 DR 方法 | 结合 outcome regression 和 IPW，使条件平行趋势更可操作 |
| 插补反事实 | Borusyak–Jaravel–Spiess / `did_imputation` | 先用未处理样本预测 $Y(0)$，再计算处理效应 |

这一节正文中不放大段代码。代码全部放到 A6 附录。

本节还可以增加一张简短方法地图：

| 方法 | 适合问题 |
|---|---|
| `csdid` / `did` | 多期、交错处理、group-time ATT |
| `eventstudyinteract` | 交错处理下的事件研究修正 |
| `drdid` | 两期 DID 或简单 DID 中的条件平行趋势 |
| `did_imputation` | 用未处理样本插补处理组反事实 |
| `did2s` | 两阶段 DID，形式接近 TWFE |
| `jwdid` | Wooldridge / Mundlak 风格 DID |
| `did_multiplegt_dyn` | 处理状态反复开关或动态处理复杂 |
| `staggered` | 处理时点近似随机 |
| `sdid` | 处理对象少或平行趋势不理想时的加权反事实 |

### 平行趋势的现代理解

本节是新增重点。它回应本书从第一章以来一直强调的判断：假设是否站得住，比结果是否显著更重要。

本节讲三个问题。

第一，pre-trend 不显著不等于平行趋势成立。检验功效不足时，即使真实趋势不同，也可能无法拒绝零假设。

第二，先做 pre-test，通过后再继续估计，会引入选择性报告和推断扭曲。研究者不能把「事前系数不显著」写成平行趋势已经被证明。

第三，honest DiD 的思路不是证明平行趋势成立，而是做敏感性分析：如果平行趋势允许存在一定程度的偏离，结论是否仍然成立？换句话说，它问的是：平行趋势被违反到什么程度，估计结论才会翻转？

正文只讲思想，`honestdid` 的 Stata 演示放到 A6 附录的可选模块。

### DDD：什么时候需要第三重差异

本节把 DDD 放在 DID 方法选择体系中，而不是第五章反事实构造地图的核心位置。

DDD 的基本直觉是：DID 扣除一类共同趋势，DDD 再用另一个 DID 扣除第三维的差异趋势。

清楚的 2×2×2 写法：

$$
\begin{aligned}
DDD
=&\left[(Y_{B,O,1}-Y_{B,O,0})-(Y_{B,Y,1}-Y_{B,Y,0})\right]\\
&-\left[(Y_{A,O,1}-Y_{A,O,0})-(Y_{A,Y,1}-Y_{A,Y,0})\right]
\end{aligned}
$$

本节可用两个案例。

第一，Lane (2025) 的跨国 DDD。韩国 HCI 目标产业和非目标产业的国内 DID 仍可能混入全球产业周期、韩国宏观趋势和国家—产业长期优势。跨国 DDD 通过产业—年份固定效应、国家—年份固定效应、国家—产业固定效应，更严格地构造韩国 HCI 产业的国际反事实。

第二，碳减排 / 财务约束案例。政策后、加州工厂、财务受限企业的三重交互可以帮助识别监管政策是否通过财务约束导致排放重新配置和溢出。

本节要提醒：DDD 不是把三重交互项丢进回归就自动有效。第三重差异必须对应明确的竞争性解释或机制。

### 一篇论文里的证据架构：多方法如何分工

本节解决实证写作中的实际问题：同一篇论文能否同时使用 2–3 种 DID 方法？

答案是可以，但不能机械堆砌。

建议写成证据架构：

| 方法角色 | 作用 |
|---|---|
| TWFE | 给出与既有文献可比的基准 |
| Bacon 分解 | 诊断 TWFE 比较来源和权重 |
| `csdid` / group-time ATT | 作为交错处理下的主估计或核心稳健性 |
| Event study | 展示动态路径和政策前走势 |
| DDD | 排除第三类竞争性解释或识别机制 |
| honest DiD | 检查结果对平行趋势偏离的敏感性 |
| SUTVA / spillover 检查 | 守住无干扰和政策污染边界 |

Lane (2025) 可在这里最后一次作为全书主线案例出现。它不是因为用了很多方法才可信，而是因为这些方法围绕同一个政策问题构成了互相支撑的证据体系。

### 方法选择表与通向第七章

本节是全章落点。

| 研究场景 | 首先问什么 | 推荐入口 |
|---|---|---|
| 统一时间处理 | 平行趋势是否可信？ | TWFE / 事件研究 |
| 两期 DID，协变量差异明显 | 条件平行趋势是否更合理？ | `drdid` |
| 多期、分批、处理后持续 | 是否存在组别和时期异质效应？ | `csdid` / `did` |
| 分批处理，关注动态效应 | TWFE lead / lag 是否污染？ | `eventstudyinteract` / `csdid, agg(event)` |
| 想用未处理结果预测反事实 | 是否适合插补 $Y(0)$？ | `did_imputation` |
| 处理状态反复开关 | 是否违反 absorbing treatment？ | `did_multiplegt_dyn` |
| 处理时点近似随机 | 是否有随机 rollout 依据？ | `staggered` |
| 处理对象少或对照趋势差 | 普通 DID 是否不可信？ | SDID / SCM |
| 需要排除第三类差异趋势 | 第三维是否有明确机制？ | DDD |

最后过渡到第七章：

> `drdid` 的双重稳健已经把我们带到第七章。若 outcome regression 和 propensity score 需要大量协变量，甚至需要机器学习来估计，如何仍然保证处理效应估计不被第一阶段误差主导？这就是 FWL、partial out 和 DDML 要解决的问题。

## 六、附录 A6 规划

附录 A6 不进入正文主线，但要作为正式配套材料。它使用在线数据，不在本地存储原始数据。

### 文件

```text
resources/did_methods/A06_did_method_selection.ipynb
resources/did_methods/A06_did_method_selection.do
```

### 数据

使用 `mpdta.dta` 作为贯穿数据：

```stata
use https://friosavila.github.io/playingwithstata/drdid/mpdta.dta, clear
```

它适合展示交错处理、首次处理时间、TWFE、`csdid`、`drdid` 和事件研究。

第五章 A5 使用加州禁烟案例展示单一处理组 / 少数处理对象下的反事实构造；第六章 A6 使用 `mpdta` 展示交错处理下的 DID 方法选择。两个附录形成对称。

### 模块

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

本次更新在 A6 中加入「2×2 DID：四个均值与一个交互项」。这个模块可以使用一个小型模拟数据，也可以使用 Card and Krueger 的最低工资例子作为延伸。若担心在线数据链接稳定性，建议在 Notebook 中先用模拟数据复现四格均值，再在正文中用 Card and Krueger 作为经典文献例子。

### 必跑模块与可选模块

必跑模块：

- A6.1 2×2 DID；
- A6.2 数据结构；
- A6.3 TWFE；
- A6.4 `csdid`;
- A6.5 `drdid`。

可选模块：

- `bacondecomp`;
- `eventstudyinteract`;
- `did_imputation`;
- `honestdid`;
- 多估计量同框比较图。

这样设计是为了避免某个新命令安装失败影响整个附录运行。

## 七、插图规划

| 图号 | 内容 | 状态 | 作用 |
|---|---|---|---|
| 图 6.1 | 从 TWFE 到现代 DID 的问题链 | 新做 | 开篇建立主线 |
| 图 6.2 | 2×2 DID 四格均值图 | 新做或由 A6 生成 | 解释 $\gamma$ 来自哪两次差分 |
| 图 6.3 | 交错处理下的四类单位时间线 | 新做 | 全章招牌图 |
| 图 6.4 | $ATT(g,t)$ 矩阵与聚合方向 | 新做 | 解释 group-time ATT |
| 图 6.5 | 多估计量事件研究同框对比 | A6 运行后生成 | 展示不同 DID 估计量的动态路径差异 |

图 6.2 是本次新增图。它应当是第六章中最适合初学者的一张图：四个格子分别标出 $C_0$、$Y_0$、$C_1$、$Y_1$，并用箭头展示「先横向差分再纵向差分」或「先纵向差分再横向差分」。

## 八、外部资源与软件地图

正文和附录应放入以下资源链接：

- Asjad Naqvi, DiD 方法与软件地图  
  https://asjadnaqvi.github.io/DiD/

- Pedro Sant’Anna, DiD Resources  
  https://psantanna.com/did-resources/

- Rios-Avila, `stpackages`  
  https://github.com/friosavila/stpackages

- `csdid` GitHub 目录  
  https://github.com/friosavila/stpackages/tree/main/csdid

- `drdid` GitHub 目录  
  https://github.com/friosavila/stpackages/tree/main/drdid

- Compare-DiD-Estimators  
  https://github.com/friosavila/Compare-DiD-Estimators

- Stata `honestdid`  
  https://github.com/mcaceresb/stata-honestdid

## 九、1–2 篇复现资源

不加入中国场景数据。只列少量可复现材料供学生延伸阅读。

### Baker et al. JEL DID practitioner guide

Pedro Sant’Anna 的 DiD Resources 页面列出了 JEL-DiD guide and replication files。该复现材料包含 R 和 Stata workflows、数据文档、生成的图表和 live code appendix。它适合作为学生理解现代 DID 实操规范的资源。

### Borusyak, Jaravel and Spiess 的 imputation event-study 论文

这篇适合放在现代事件研究修正部分。它的核心是：在 staggered treatment adoption 和 heterogeneous treatment effects 下，用 imputation 思路先构造未处理反事实，再估计动态处理效应。

### Card and Krueger (1994) 最低工资论文

Card and Krueger 的新泽西最低工资研究可以作为 2×2 DID 的经典文献例子。它的作用不是展示现代 DID，而是让初学者看清楚处理组、对照组、政策前、政策后和交互项系数之间的关系。

## 十、给 Codex / 另一位 AI 的执行说明

```text
请按照本规划撰写第六章。正文严格控制为识别思路和方法选择，不要写成 Stata 命令教程。第 2 节需要吸收 FWL 讲义中「FWL 应用 4：DID」的核心思想，用四个均值和一个交互项讲清楚 2×2 DID。所有代码、命令安装、运行输出和多估计量比较都放入附录 A6。正文中只保留必要公式、少量经典例子和方法选择表。A6 使用在线 mpdta.dta，不在本地存储原始数据；2×2 DID 可用模拟数据或稳定在线数据展示。若某些命令安装失败，不要中断整个附录，记录失败原因并继续运行必跑模块。
```
