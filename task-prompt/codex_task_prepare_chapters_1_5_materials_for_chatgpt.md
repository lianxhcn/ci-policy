# Codex 资料准备任务：为 ChatGPT 重写前五章整理素材包

请将本文件保存为：

```text
ci-policy/task-prompt/codex_task_prepare_chapters_1_5_materials_for_chatgpt.md
```

本轮任务目标：不要继续写正文。请整理一份可交给 ChatGPT 的资料包，帮助 ChatGPT 明天主笔重写第 1–5 章正文。

---

## 1. 执行前必须阅读

请先读取：

```text
AGENTS.md
task-prompt/codex_update_writing_rules_v1.md
working/second_round_plan.md
working/chapter_material_map.md
working/materials_inventory.md
working/second_round_review_notes.md
working/third_round_recommendation.md
working/citation_check_todo.md
working/notebook_plan.md
```

如果某个文件不存在，请在输出日志中说明，不要中断任务。

---

## 2. 本轮不要做什么

本轮只整理资料，不写新正文。

不要执行：

- 不要改写 `lectures/*.qmd`；
- 不要重写章节；
- 不要运行大型复现包；
- 不要修改 `refers/` 原始材料；
- 不要删除任何文件；
- 不要编造文献、DOI、链接或复现包信息。

---

## 3. 需要打包给 ChatGPT 的正式文件

请复制以下文件到临时目录：

```text
working/chatgpt_chapters_1_5_handoff/
```

必须包含：

```text
AGENTS.md
_quarto.yml
index.qmd
syllabus.qmd
lectures/01_policy_target.qmd
lectures/02_policy_to_data.qmd
lectures/03_sample_selection_heckman.qmd
lectures/04_omitted_variables_fe_intfe.qmd
lectures/05_counterfactual_did_ddd_scm.qmd
resources/domestic_policy_examples.qmd
resources/reading_map.qmd
cases/replication_papers.qmd
```

同时复制以下工作文件到：

```text
working/chatgpt_chapters_1_5_handoff/working_files/
```

```text
working/second_round_plan.md
working/chapter_material_map.md
working/materials_inventory.md
working/second_round_review_notes.md
working/third_round_recommendation.md
working/citation_check_todo.md
working/notebook_plan.md
working/first_round_summary.md
working/second_round_supplemental_audit.md
```

如果某个文件不存在，请在 `chatgpt_handoff_readme.md` 中列出。

---

## 4. 需要整理的核心参考资料

请从 `refers/_active/` 和必要的 `refers/_reserve/` 中，整理第 1–5 章真正需要 ChatGPT 阅读的资料。

不要把整个 `refers/` 目录打包。

### 4.1 第 1 章：政策目标与研究问题

请优先寻找并复制或摘录以下材料：

```text
政策冲击筛选标准
China Policy Shocks 相关文档
Lane (2025) 概要材料
政府引导基金相关开放讨论材料
国内政策辅助案例初步材料
```

### 4.2 第 2 章：政策如何进入数据

请优先寻找并复制或摘录以下材料：

```text
政策变量化
处理组和对照组构造
政策时点识别
Lane (2025) 中关于目标产业、政策时点、行业数据、贸易数据的材料
China Policy Shocks 相关材料
```

### 4.3 第 3 章：样本选择与 Heckman

必须包含：

```text
refers/_active/Heckman 模型实操指南.md
```

还可以补充：

```text
Heckman 经典讲义或笔记
样本选择偏误相关材料
管理学中 Heckman 使用误区材料
```

### 4.4 第 4 章：遗漏变量、固定效应、HDFE 与 IntFE

请优先寻找并复制或摘录以下材料：

```text
控制变量相关讲义
面板数据固定效应材料
HDFE 材料
IntFE 材料
OLS / FWL 相关材料中与固定效应解释有关的部分
```

### 4.5 第 5 章：反事实构造、DID、DDD、事件研究与 SCM

请优先寻找并复制或摘录以下材料：

```text
DID / DDD 材料
事件研究材料
交叠 DID 和异质性处理效应提醒材料
SCM 材料
Abadie et al. (2010) 材料
Lane (2025) 中关于 DID、DDD、事件研究、DR DID 的材料
SDID 只作为延伸阅读材料
```

---

## 5. 资料整理方式

请不要机械复制所有大文件。

对于每个核心材料，优先生成摘录文件，放入：

```text
working/chatgpt_chapters_1_5_handoff/refers_extracts/
```

命名格式：

```text
chapter01_policy_target_extract.md
chapter02_policy_to_data_extract.md
chapter03_selection_heckman_extract.md
chapter04_fe_intfe_extract.md
chapter05_did_scm_extract.md
```

每个摘录文件应包括：

```text
1. 材料来源文件路径
2. 适用章节
3. 关键观点
4. 可直接用于讲义的案例
5. 可直接用于讲义的公式或表格
6. 需要核查的文献、DOI 或链接
7. 不建议写入正式讲义的内容
```

注意：

- 可以摘录关键段落，但不要复制整篇长文；
- 如果材料本身很短，可以完整复制；
- 对未公开论文、审稿意见、内部材料，只能摘录可公开讨论的概念，不要复制原文敏感内容；
- 不要包含 sci-hub 链接；
- 不要把本地绝对路径写入正式讲义正文，但可以在交接材料中标注相对路径方便查找。

---

## 6. 请生成总交接文件

请在：

```text
working/chatgpt_chapters_1_5_handoff/chatgpt_handoff_readme.md
```

写一份总说明，内容包括：

```text
# ChatGPT 前五章主笔资料包说明

## 1. 本资料包目的
说明：本包用于交给 ChatGPT 主笔重写第 1–5 章，不用于直接发布。

## 2. 当前项目状态
简要说明 Quarto 骨架、已写章节、已渲染状态。

## 3. 第 1–5 章当前问题
逐章说明当前章节的优点和不足，尤其指出：
- 哪些章节只是提纲；
- 哪些章节正文太浅；
- 哪些章节案例没有讲穿；
- 哪些章节容易写成方法百科。

## 4. 建议 ChatGPT 如何重写
逐章给出建议：
- 第 1 章要讲清政策目标；
- 第 2 章要讲清政策如何进入数据；
- 第 3 章要以妇女工资为主案例讲穿；
- 第 4 章要从遗漏变量进入固定效应，不写面板百科；
- 第 5 章要从反事实构造进入 DID / DDD / SCM，不写 SCM / SDID 专题。

## 5. 每章可用材料
列出每章对应的摘录文件和原始材料路径。

## 6. 仍需核查
列出所有 `TODO: 补文献`、`TODO: 核查 DOI`、`TODO: 核查复现包链接`。

## 7. 给 ChatGPT 的提醒
包括：
- 少例子，讲穿一个例子；
- 每章先讲政策和数据，再讲方法；
- 不要编造文献；
- 保持 `.qmd`、callout、半角括号和交叉引用标签规范。
```

---

## 7. 请生成文件清单

请在：

```text
working/chatgpt_chapters_1_5_handoff/file_manifest.md
```

列出资料包中所有文件，格式：

```markdown
| 文件 | 类型 | 用途 | 对应章节 |
|---|---|---|---|
| lectures/01_policy_target.qmd | 正式章节 | 当前第 1 章草稿 | 第 1 章 |
```

---

## 8. 请生成压缩包

完成整理后，请将目录：

```text
working/chatgpt_chapters_1_5_handoff/
```

压缩为：

```text
working/chatgpt_chapters_1_5_handoff.zip
```

压缩包中应包含：

```text
chatgpt_handoff_readme.md
file_manifest.md
AGENTS.md
_quarto.yml
index.qmd
syllabus.qmd
lectures/
resources/
cases/
working_files/
refers_extracts/
```

---

## 9. 渲染要求

本轮不要求修改正文，因此不必运行 `quarto render`。

如果为了确认当前项目状态已经运行，也可以记录结果，但不要因为渲染问题擅自修改章节正文。

---

## 10. 完成后反馈模板

完成后请回复：

```text
ChatGPT 前五章资料包已准备完成。

输出位置：
- working/chatgpt_chapters_1_5_handoff/
- working/chatgpt_chapters_1_5_handoff.zip

本轮包含：
- 第 1–5 章当前 .qmd
- 项目规则 AGENTS.md
- 第二轮工作文件
- 第 1–5 章参考资料摘录
- 总交接说明 chatgpt_handoff_readme.md
- 文件清单 file_manifest.md

本轮未执行：
- 未重写章节正文
- 未修改 refers/
- 未运行大型复现包

请将 zip 文件发给 ChatGPT。
```
