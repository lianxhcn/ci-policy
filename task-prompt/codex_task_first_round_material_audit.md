# Codex 第一轮任务说明：ci-policy 素材盘点与章节映射

你现在位于 `ci-policy` 项目根目录。本项目最终会同步到 GitHub，并开放给学员访问和 fork。因此，第一轮任务只做素材盘点和章节映射，不写正式讲义，不污染正式目录。

## 1. 先阅读这些任务文件

请按顺序阅读：

```text
task-prompt/00_readme_first_round.md
task-prompt/codex_master_task.md
task-prompt/book_writing_plan.md
task-prompt/material_screening_rules.md
task-prompt/first_round_material_audit_task.md
task-prompt/output_templates.md
task-prompt/gitignore_snippet.md
```

阅读后再开始处理素材。

## 2. 当前目录约束

本项目的素材已经整理为三层：

```text
refers/_active/     第一轮重点读取的素材
refers/_reserve/    后续按章节需要再读取的素材
refers/_archive/    完整复现包、PDF、旧输出和备份资料，第一轮原则上不读
```

第一轮的默认规则是：

- 只读取 `refers/_active/`；
- 不递归读取 `refers/_reserve/`；
- 不递归读取 `refers/_archive/`；
- 不读取 `.zip`、大批量 `.pdf`、`.html`、`out/`、完整 package 源码目录、大批量图片目录；
- 不修改 `refers/` 中的任何原始材料。

## 3. Lane (2025) 主线案例的白名单例外

本讲义以 Lane (2025, QJE) 作为主线案例。该材料目前位于 `refers/_archive/`，但第一轮需要知道它的大致结构。因此，允许你只读取以下白名单文件，禁止递归读取整个复现包：

```text
refers/_archive/lane_2025_qje/lane_2025_qje_notes.md
refers/_archive/lane_2025_qje/replicationpackage/readme.md
refers/_archive/lane_2025_qje/replicationpackage/package_info.txt
refers/_archive/lane_2025_qje/replicationpackage/manifest.txt
refers/_archive/lane_2025_qje/replicationpackage/code/readme.md
refers/_archive/lane_2025_qje/replicationpackage/documentation/workflow.md
```

如果上述文件不存在，或你认为还需要读取其他 Lane 文件，只能在 `working/reserve_reading_requests.md` 中提出申请，不要自行扩大读取范围。

特别禁止第一轮读取：

```text
refers/_archive/lane_2025_qje/replicationpackage/data/
refers/_archive/lane_2025_qje/replicationpackage/output/
refers/_archive/lane_2025_qje/replicationpackage/code/0_analysis/
refers/_archive/lane_2025_qje/replicationpackage/code/1_figures/
refers/_archive/lane_2025_qje/replicationpackage/code/2_tables/
refers/_archive/lane_2025_qje/replicationpackage/code/3_appendix/
refers/_archive/lane_2025_qje/replicationpackage/code/4_suppappendix/
refers/_archive/lane_2025_qje/replicationpackage/data/input/
```

## 4. 第一轮只生成过程文件

请创建或使用 `working/` 目录，并生成以下文件：

```text
working/materials_inventory.md
working/chapter_material_map.md
working/missing_materials.md
working/reserve_reading_requests.md
working/next_questions.md
working/first_round_summary.md
```

除 `.gitignore` 外，第一轮不要修改正式目录中的任何文件，例如：

```text
lectures/
notebooks/
cases/
resources/
refs/
figs/
scripts/
data/
exercises/
```

如果 `.gitignore` 尚未包含 `refers/` 和 `working/`，请按 `task-prompt/gitignore_snippet.md` 追加；如果已经包含，请不要重复追加。

## 5. 任务目标

第一轮的目标不是写正文，而是回答：

- 哪些素材最能服务本书主线；
- 每份素材适合哪一章；
- 哪些素材适合改写为讲义正文；
- 哪些素材适合转化为 Notebook；
- 哪些素材只适合作延伸阅读；
- 哪些素材暂不应该使用；
- 哪些章节还缺材料；
- 后续是否需要读取 `_reserve/` 或 `_archive/` 中的特定文件。

本书主线是：

```text
政策目标 → 政策实施机制 → 数据形成机制 → 识别威胁 → 研究设计 → 估计方法 → 结果解释
```

不要把素材整理成方法百科。所有材料都要围绕「政策评估中的识别思维与实证设计」来判断价值。

## 6. 章节映射标准

请按以下章节做素材映射：

```text
第 1 章 政策评估从政策目标开始
第 2 章 政策如何进入数据：处理组、对照组与政策时点
第 3 章 谁被我们看见了：样本选择、自选择与 Heckman 思维
第 4 章 遗漏变量如何进入模型：控制变量、固定效应、HDFE 与 IntFE
第 5 章 如何构造反事实：DID、DDD、事件研究与合成控制
第 6 章 控制关系不再线性时：FWL、DDML 与设定偏误
第 7 章 从论文阅读到复现：AI 和 Agent 如何帮助继续学习
第 8 章 扩展阅读：书籍、连享会资料与在线课程
附录 A 可复现经典论文清单
```

每份材料最多映射到 2 个主章节。不要把同一份材料随意挂到多个章节。

## 7. 输出文件要求

### 7.1 `working/materials_inventory.md`

为每份材料建立一条记录，字段包括：

```text
编号
文件路径
材料类型
核心主题
可服务章节
建议用途
优先级
处理建议
备注
```

优先级使用：

```text
P1：第一轮核心材料，后续写作应优先使用
P2：有用，但主要作为延伸阅读或备用
P3：暂不使用，除非后续章节需要
P0：不建议使用
```

建议用途使用：

```text
直接改写为正式讲义
改写为案例材料
转化为 Notebook 示例
放入延伸阅读
放入资源索引
暂时保留，后续按需读取
忽略
```

### 7.2 `working/chapter_material_map.md`

按章节整理材料，每章包含：

```text
可用素材
适合改写的内容
适合插入的案例
适合延伸阅读的资源
缺失素材
后续建议
```

### 7.3 `working/missing_materials.md`

列出当前素材不足的地方。每条包括：

```text
缺失内容
对应章节
为什么需要
可以从哪里补
是否必须补
建议处理
```

### 7.4 `working/reserve_reading_requests.md`

如果需要读取 `_reserve/` 或 `_archive/` 中的其他材料，在这里提出申请。每条包括：

```text
拟读取路径
服务章节
读取理由
是否需要全目录
建议文件类型
风险提示
```

不要自行读取未授权路径。

### 7.5 `working/next_questions.md`

只列真正影响写作决策、需要老师确认的问题。不要列泛泛问题。

### 7.6 `working/first_round_summary.md`

写一份 1000–1500 字的第一轮摘要，包括：

- 当前素材总体判断；
- 最适合支撑主线的 5–8 份材料；
- 哪些资料明显过重或暂不适合；
- 哪些章节素材较充分；
- 哪些章节还缺素材；
- 下一轮建议。

## 8. 特别注意

第一轮不要做以下事情：

- 不要写正式讲义；
- 不要生成章节草稿；
- 不要修改 `lectures/`、`notebooks/`、`cases/` 等正式目录；
- 不要大段复制旧材料；
- 不要读取完整复现包；
- 不要修改原始素材；
- 不要把 `refers/` 或 `working/` 中的本地路径写入正式发布内容；
- 不要把讲义整理成 DID、SCM、Heckman、DDML 等方法清单。

## 9. 完成后汇报

完成第一轮后，只向老师汇报：

```text
1. 已生成哪些 working 文件；
2. 哪些章节素材最充分；
3. 哪些章节缺材料；
4. 是否需要读取 _reserve 或 _archive 中的额外材料；
5. 下一步建议。
```

不要在聊天窗口粘贴长篇材料清单。请让老师直接查看 `working/` 下的文件。
