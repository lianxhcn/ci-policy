# ci-policy 下一轮工作交接说明

本文件用于交给 ChatGPT，帮助其理解当前项目状态，并规划后续写作工作。

## 1. 本轮工作概况

本轮按照 `task-prompt/codex_task_second_round_build_outline_v2.md` 完成了第二轮工作，核心目标是搭建可复用的 Quarto 在线讲义骨架和详细写作提纲。

已完成的主要工作：

1. 创建正式 Quarto 讲义骨架，包括首页、建议 6 小时讲授路线、8 个章节文件、案例页、资源页和练习页。
2. 更新 `_quarto.yml`，将导航改为当前正式目录结构。
3. 为每章写入统一结构：本章定位、课堂目标、核心问题、详细写作提纲、主案例与辅助案例、Notebook 规划、延伸阅读、不展开内容和自查清单。
4. 规划国内政策评估辅助案例页，包括数字金融、绿色金融、低碳城市、环保督察、科创板注册制、药品集采、政府引导基金等。
5. 生成第二轮工作文件，包括后续引用核查清单、Notebook 规划、审稿式检查 notes 和第三轮建议。
6. 运行 `quarto render` 验证结构，已成功生成 `docs/index.html`。
7. 本轮没有写完整章节正文，没有运行 Notebook，没有运行 Lane (2025) 复现包，也没有修改 `refers/` 原始材料。

## 2. 下一轮建议

建议第三轮优先写第 1-3 章：

- 第 1 章：政策评估从政策目标开始。
- 第 2 章：政策如何进入数据。
- 第 3 章：样本选择、自选择与 Heckman 思维。

原因：

- 第 1-3 章构成全书前半段的研究设计入口：政策目标、政策进入数据、样本选择。
- 这三章素材相对充分，且技术细节风险较低，适合先定全书语气和写作密度。
- 第 5、6 章方法材料较多，容易写成方法百科，建议等前 3 章风格稳定后再写。

下一轮需要特别注意：

- 不要把讲义写成方法清单。
- 不要过度依赖 Lane (2025)，每章应适当加入国内政策场景。
- 政府引导基金案例只作为开放讨论，不公开论文原文和审稿意见原文。
- 国内政策案例文献尚未核查，不能编造参考文献。
- Notebook 目前只做规划，不要急于写完整代码。

## 3. 需要优先阅读的文件

建议 ChatGPT 先阅读以下文件：

```text
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

如果需要更完整的背景，再阅读：

```text
task-prompt/codex_master_task.md
task-prompt/book_writing_plan.md
working/materials_inventory.md
working/chapter_material_map.md
working/second_round_supplemental_audit.md
```

## 4. dirtree

```text
ci-policy/
├── .quarto/
├── cases/
├── data/
├── docs/
├── exercises/
├── figs/
│   └── notebook/
├── images/
├── lectures/
├── notebooks/
├── refs/
├── resources/
├── scripts/
├── task-prompt/
└── working/
```

## 5. filetree

```text
ci-policy/
├── .gitignore
├── _quarto.yml
├── README.md
├── chatgpt_next_round_handoff.md
├── ci-policy.code-workspace
├── index.qmd
├── styles.css
├── syllabus.qmd
├── cases/
│   └── replication_papers.qmd
├── exercises/
│   └── exercise_overview.qmd
├── lectures/
│   ├── 01_policy_target.qmd
│   ├── 02_policy_to_data.qmd
│   ├── 03_sample_selection_heckman.qmd
│   ├── 04_omitted_variables_fe_intfe.qmd
│   ├── 05_counterfactual_did_ddd_scm.qmd
│   ├── 06_fwl_ddml.qmd
│   ├── 07_ai_agent_replication.qmd
│   └── 08_further_reading.qmd
├── resources/
│   ├── domestic_policy_examples.qmd
│   └── reading_map.qmd
├── task-prompt/
│   ├── 00_README_first_round.md
│   ├── _combined_first_round_guides.md
│   ├── book_writing_plan.md
│   ├── codex_master_task.md
│   ├── codex_task_first_round_material_audit.md
│   ├── codex_task_second_round_build_outline_v2.md
│   ├── first_round_material_audit_task.md
│   ├── gitignore_snippet.md
│   ├── material_screening_rules.md
│   └── output_templates.md
└── working/
    ├── chapter_material_map.md
    ├── citation_check_todo.md
    ├── first_round_summary.md
    ├── materials_inventory.md
    ├── missing_materials.md
    ├── next_questions.md
    ├── notebook_plan.md
    ├── reserve_reading_requests.md
    ├── second_round_plan.md
    ├── second_round_review_notes.md
    ├── second_round_supplemental_audit.md
    └── third_round_recommendation.md
```

## 6. 已生成的 docs 输出

```text
docs/
├── index.html
├── syllabus.html
├── search.json
├── sitemap.xml
├── robots.txt
├── styles.css
├── cases/
│   └── replication_papers.html
├── exercises/
│   └── exercise_overview.html
├── lectures/
│   ├── 01_policy_target.html
│   ├── 02_policy_to_data.html
│   ├── 03_sample_selection_heckman.html
│   ├── 04_omitted_variables_fe_intfe.html
│   ├── 05_counterfactual_did_ddd_scm.html
│   ├── 06_fwl_ddml.html
│   ├── 07_ai_agent_replication.html
│   └── 08_further_reading.html
└── resources/
    ├── domestic_policy_examples.html
    └── reading_map.html
```

## 7. 当前关键判断

### 7.1 Lane (2025)

Lane (2025) 是全书主线案例，但不能压倒全书。建议用于：

- 第 1 章：政策目标如何进入研究问题。
- 第 2 章：政策对象、处理行业、政策时点和数据结构如何转化为变量。
- 第 5 章：DID、DDD、事件研究、DR DID 如何服务反事实构造。
- 第 7 章：如何用 AI / Agent 拆解论文和复现包。

### 7.2 政府引导基金

政府引导基金与产业链长鞭效应案例只作为课堂开放讨论案例。可以讲：

- 政策目标如何影响结果变量选择。
- 政府资金与市场化资金的政策目标差异。
- 产业链韧性、供应链安全和长鞭效应如何作为政策评估对象。
- 样本选择、工具变量排他性和网络结构测度为什么会被审稿人追问。

不要写：

- 不公开论文原文。
- 不公开审稿意见原文。
- 不呈现未公开数据细节。
- 不把该案例写成完整论文解读。

### 7.3 第 5 章方法权重

第 5 章不要写成 SCM / SDID 专题。建议权重：

```text
DID / 事件研究：主线
交叠 DID 和异质性处理效应：必要提醒
DDD：作为进一步比较维度
SCM：作为少数处理对象的副例
SDID：只作为延伸阅读
```

### 7.4 第 6 章方法权重

第 6 章应从 FWL 到 DDML。建议权重：

```text
FWL：解释控制变量和固定效应的 partial out 逻辑
DDML：解释非线性和高维控制关系下的灵活 partial out
Stata ddml：作为主工具入口
Python EconML：只放扩展阅读
```

必须强调：

> DDML 主要处理高维控制变量和非线性函数形式导致的设定偏误，不是所有内生性问题的万能解法。

## 8. 需要后续核查的内容

后续正式写作前，需要核查：

- Lane (2025) 原文、DOI、复现包链接和关键结果表述。
- Abadie et al. (2010) 原文、DOI、数据和复现材料。
- DID / DDD / 事件研究相关文献。
- DDML 经典文献和 Stata `ddml`、Python EconML 文档。
- Heckman 和样本选择相关文献。
- 国内政策辅助案例的正式发表论文、DOI、数据来源和复现材料。
- 教材、online book 和连享会推文链接。

国内政策案例目前统一保留 `TODO: 补文献`，不要编造引用。
