# Codex 第三轮任务：撰写第 1–3 章正文初稿

本任务文件用于 `ci-policy` 项目的第三轮工作。请将本文件放入：

```text
ci-policy/task-prompt/codex_task_third_round_write_chapters_1_3.md
```

本轮目标：在第二轮 Quarto 骨架和详细提纲基础上，撰写第 1–3 章的正文初稿，并保持全书统一文风。

---

## 1. 执行前必须阅读

请先读取根目录项目规则：

```text
AGENTS.md
```

然后读取以下任务与工作文件：

```text
task-prompt/codex_update_writing_rules_v1.md
task-prompt/codex_task_second_round_build_outline_v2.md
working/second_round_plan.md
working/second_round_review_notes.md
working/third_round_recommendation.md
working/citation_check_todo.md
working/notebook_plan.md
lectures/01_policy_target.qmd
lectures/02_policy_to_data.qmd
lectures/03_sample_selection_heckman.qmd
resources/domestic_policy_examples.qmd
```

如果文件名大小写略有差异，请以当前项目中实际文件名为准。

---

## 2. 本轮任务范围

本轮只写以下三章正文初稿：

```text
lectures/01_policy_target.qmd
lectures/02_policy_to_data.qmd
lectures/03_sample_selection_heckman.qmd
```

不要撰写或扩展：

```text
lectures/04_omitted_variables_fe_intfe.qmd
lectures/05_counterfactual_did_ddd_scm.qmd
lectures/06_fwl_ddml.qmd
lectures/07_ai_agent_replication.qmd
lectures/08_further_reading.qmd
cases/replication_papers.qmd
resources/reading_map.qmd
```

这些文件可以读取以保持一致，但本轮不要实质写作。

---

## 3. 本轮总体目标

第 1–3 章要共同完成全书的研究设计入口：

```text
第 1 章：政策目标如何决定研究问题
第 2 章：政策如何进入数据
第 3 章：谁被我们看见了，样本选择如何影响识别
```

这三章要先稳定全书文风和密度。后续第 4–6 章再进入更明显的方法内容。

本轮不要把讲义写成方法百科。每一章都必须遵守：

```text
先讲政策问题 → 再讲数据形成 → 再讲识别障碍 → 最后引出方法
```

---

## 4. 写作风格硬性规则

请严格遵守 `AGENTS.md` 和 `task-prompt/codex_update_writing_rules_v1.md`，尤其注意：

1. 正式章节使用 `.qmd`；
2. 不写具体授课日期、地点、学校和特定班级；
3. 小括号全部使用半角括号 `()`，不要使用中文全角括号；
4. 3–5 项并列或递进内容优先写成列表；
5. 一组排比最多 3–4 项，超过则改为列表；
6. 适度使用 Quarto callout；
7. 公式标签使用 `eq:cipolicy-章节关键词-公式关键词`；
8. 图表标签使用 `fig:cipolicy-...` 和 `tbl:cipolicy-...`；
9. 不编造参考文献、DOI、政策文件来源和复现包链接；
10. 未核查的文献和链接统一标记 `TODO: 补文献` 或 `TODO: 核查 DOI`；
11. 不修改 `refers/` 中的原始材料；
12. 不把 `refers/` 或 `working/` 的本地路径写入正式讲义正文。

---

## 5. 正文长度建议

本轮不是写极短提纲，而是写可读的正文初稿。但也不要写成完整教材。

建议长度：

```text
第 1 章：3500–5000 字
第 2 章：4000–5500 字
第 3 章：3500–5000 字
```

如果某章暂时材料不足，可以略短，但必须保留完整结构和 TODO 标记。

---

## 6. 第 1 章写作要求

文件：

```text
lectures/01_policy_target.qmd
```

标题：

```text
政策评估从政策目标开始
```

### 6.1 本章核心任务

本章要讲清楚：

- 为什么政策评估不能从模型开始；
- 因果推断的核心困难是反事实不可观测；
- 实证设计的任务是寻找可信反事实；
- 政策目标如何决定结果变量；
- 政策工具如何影响作用机制；
- 政策对象如何影响处理组定义；
- 为什么同一政策可以有多个合理研究问题。

### 6.2 必须保留的主题

本章必须明确扣住全书主题：

```text
因果推断：政策评估中的识别思维与实证设计
```

建议保留或改写如下思想：

```text
本讲义的重点不是记住更多模型名称，而是理解一项政策如何被转化为可评价、可估计、可解释的研究问题。
```

### 6.3 必须使用的例子

本章应使用：

1. **政府引导基金**作为开放讨论案例；
2. **Lane (2025)** 作为主线案例入口；
3. 至少 1 个国内辅助政策场景，例如绿色金融改革创新试验区、低碳城市试点、数字金融或药品集采。

国内案例不需要长篇展开，但要说明它如何帮助学生理解结果变量选择或政策目标拆解。未核查文献时标记：

```text
TODO: 补文献
```

### 6.4 必须使用的列表

以下内容建议使用列表呈现：

```text
一个政策评估问题至少要回答五个基础问题：
1. 政策为什么出台？
2. 政策作用于谁？
3. 政策通过什么工具发挥作用？
4. 政策希望改变什么结果？
5. 政策实施是否具有选择性？
```

### 6.5 可使用的公式

如涉及潜在结果框架，使用带项目名前缀的标签，例如：

```markdown
$$
\tau_i = Y_i(1) - Y_i(0)
$$ {#eq:cipolicy-target-potential-effect}
```

```markdown
$$
Y_i = D_iY_i(1) + (1-D_i)Y_i(0)
$$ {#eq:cipolicy-target-observed-outcome}
```

正文引用时使用：

```text
式 @eq:cipolicy-target-potential-effect
式 @eq:cipolicy-target-observed-outcome
```

不要使用短标签。

### 6.6 不要展开的内容

本章不要展开：

- DID 的完整估计式；
- SCM 的优化问题；
- Heckman 模型细节；
- DDML 算法细节；
- 政府引导基金论文原文；
- 审稿意见原文。

---

## 7. 第 2 章写作要求

文件：

```text
lectures/02_policy_to_data.qmd
```

标题：

```text
政策如何进入数据：处理组、对照组与政策时点
```

### 7.1 本章核心任务

本章要讲清楚：

- 政策文件不是处理变量；
- 政策对象如何转化为 $D$；
- 政策时点如何转化为 $Post$；
- 结果变量 $Y$ 如何从政策目标推导；
- 政策对象和数据观测单位不一致时如何处理；
- 政策分批实施、批次差异和外溢效应为什么重要；
- 数据合并键、时间窗口和样本边界如何影响识别设计。

### 7.2 必须使用的例子

本章应使用：

1. **Lane (2025)**：说明政策行业、政策时点、行业数据和贸易数据如何进入实证设计；
2. **China Policy Shocks**：作为政策卡片和政策变量化资源入口；
3. 至少 1 个国内政策变量化例子，例如：
   - 绿色金融改革创新试验区；
   - 低碳城市试点；
   - 碳交易试点；
   - 药品集中采购；
   - 科创板注册制；
   - 宽带中国。

未核查文献时标记 `TODO: 补文献`。

### 7.3 建议小节结构

建议正文包括：

```text
1. 政策事实如何变成变量
2. 处理组不是政策名称
3. 政策时点不是文件发布日期
4. 对照组来自可辩护的反事实
5. 政策对象和数据单位不一致
6. 分批实施、外溢和政策暴露度
7. 政策进入数据检查表
```

### 7.4 必须使用的列表或表格

请设计一个「政策进入数据检查表」，可以使用表格形式。表格标签使用：

```text
{#tbl:cipolicy-data-policy-checklist}
```

表格字段可包括：

```text
政策事实
实证变量
需要确认的问题
可能的识别风险
```

### 7.5 可使用的公式

如使用 DID 的最基本变量化表达，可以写成：

```markdown
$$
D_{it} = Treat_i \times Post_t
$$ {#eq:cipolicy-data-did-treatment}
```

不要在本章展开完整 DID 回归。完整 DID 放到第 5 章。

### 7.6 不要展开的内容

本章不要展开：

- 完整数据清洗流程；
- Lane 完整复现包；
- 所有行业代码细表；
- DID 新估计量；
- 复杂事件研究模型。

---

## 8. 第 3 章写作要求

文件：

```text
lectures/03_sample_selection_heckman.qmd
```

标题：

```text
谁被我们看见了：样本选择、自选择与 Heckman 思维
```

### 8.1 本章核心任务

本章要讲清楚：

- 研究样本往往不是总体；
- 结果变量为什么只在一部分样本中可观测；
- 样本选择和一般内生性不是一回事；
- 自选择如何影响政策评估；
- 选择方程和结果方程分别回答什么；
- 排他性约束为什么是识别关键；
- Heckman 两步法的教学价值和使用边界；
- 什么时候不应该机械使用 Heckman。

### 8.2 必须使用的例子

本章应使用：

1. 工资只在就业者中可观测；
2. 贷款利率只在获得贷款企业中可观测；
3. 政策评估中的选择后样本，例如：
   - 政府补贴申请；
   - 绿色信贷获得；
   - 上市公司披露样本；
   - 专利申请样本；
   - 环保处罚可观测样本；
   - 存活企业样本。

可使用政府引导基金作为开放讨论中的选择问题，但不要公开论文细节和审稿意见原文。

### 8.3 建议小节结构

建议正文包括：

```text
1. 为什么我们看到的样本不是总体
2. 选择进入样本和政策处理不是一回事
3. 选择方程与结果方程
4. 排他性约束的含义
5. Heckman 两步法的直观逻辑
6. 政策评估中的常见误用
7. 样本选择诊断清单
```

### 8.4 可使用的公式

选择方程：

```markdown
$$
S_i^* = Z_i'\gamma + v_i,\quad S_i = 1(S_i^*>0)
$$ {#eq:cipolicy-selection-latent}
```

结果方程：

```markdown
$$
Y_i = X_i'\beta + u_i,\quad Y_i \text{ is observed only if } S_i=1
$$ {#eq:cipolicy-selection-outcome}
```

正文引用时使用：

```text
式 @eq:cipolicy-selection-latent
式 @eq:cipolicy-selection-outcome
```

### 8.5 必须强调的边界

请明确写出：

- Heckman 不是所有内生性问题的通用修复工具；
- IMR 显著与否不能机械决定是否采用 Heckman；
- 没有合理排他性变量时，Heckman 的说服力会明显下降；
- 样本选择问题首先是数据形成机制问题，不是命令选择问题。

### 8.6 不要展开的内容

本章不要展开：

- 完整 Heckman 命令教程；
- 多种扩展 Heckman 模型；
- 大量分布假设推导；
- 管理学误用案例细节清单；
- 未公开论文材料。

---

## 9. 国内政策文献处理规则

本轮可以写国内政策案例，但不能编造文献。

如果知道有相关方向，但没有核查具体论文，请写：

```text
TODO: 补文献
```

如果需要在资源页同步记录，请更新：

```text
resources/domestic_policy_examples.qmd
```

但本轮不要求完整整理国内文献综述。

---

## 10. Callout 使用建议

每章建议使用 3–5 个 callout，类型包括：

```text
.callout-note       本节要点
.callout-warning    常见误区
.callout-tip        课堂讨论
.callout-important  核心命题
```

不要连续堆叠 callout。callout 应服务授课节奏。

---

## 11. Notebook 处理规则

本轮不写完整 Notebook，但可以在章节中保留 Notebook 规划。

对应关系：

```text
第 3 章：notebooks/03_selection_heckman_demo.ipynb
第 4 章：notebooks/04_fe_hdfe_comparison.ipynb
第 5 章：notebooks/05_did_event_study_demo.ipynb
第 6 章：notebooks/06_fwl_ddml_demo.ipynb
```

本轮只涉及第 3 章，因此可以在第 3 章保留 `03_selection_heckman_demo.ipynb` 的规划说明，但不要创建完整代码。

---

## 12. 自查与日志

完成后必须生成：

```text
working/third_round_chapters_1_3_summary.md
working/third_round_chapters_1_3_review_notes.md
working/third_round_citation_todo.md
```

### 12.1 `working/third_round_chapters_1_3_summary.md`

说明：

- 写了哪些章节；
- 每章主要内容；
- 使用了哪些案例；
- 哪些位置保留了 TODO；
- 是否运行了 `quarto render`。

### 12.2 `working/third_round_chapters_1_3_review_notes.md`

以 reviewer 角色检查：

- 是否偏离政策评估研究设计主线；
- 是否写成方法拼盘；
- 是否过度依赖 Lane (2025)；
- 是否加入国内政策辅助案例；
- 是否遵守半角括号规则；
- 是否使用了合适的 callout；
- 是否存在过长排比句；
- 是否存在过短交叉引用标签。

### 12.3 `working/third_round_citation_todo.md`

列出：

- 需要补文献的国内案例；
- 需要核查 DOI 的文献；
- 需要核查复现包链接的论文；
- 需要核查原文页码或表述的位置。

---

## 13. 渲染检查

完成第 1–3 章后，请运行：

```bash
quarto render
```

如果渲染失败，请：

1. 不要强行改动大范围内容；
2. 先记录错误信息；
3. 修复明显语法问题；
4. 将错误和修复记录写入 `working/third_round_chapters_1_3_summary.md`。

---

## 14. 完成后反馈模板

完成后请向老师反馈：

```text
第三轮已完成。
本轮撰写/更新了：
- lectures/01_policy_target.qmd
- lectures/02_policy_to_data.qmd
- lectures/03_sample_selection_heckman.qmd

本轮生成工作文件：
- working/third_round_chapters_1_3_summary.md
- working/third_round_chapters_1_3_review_notes.md
- working/third_round_citation_todo.md

本轮是否运行 quarto render：
- 是/否
- 如失败，错误摘要为：...

需要老师确认：
1. ...
2. ...
```
