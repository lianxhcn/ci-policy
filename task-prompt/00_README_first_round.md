# ci-policy 第一轮 Codex 使用说明

本文件夹中的文档用于指导 Codex 完成 `ci-policy` 项目的第一轮工作。

第一轮不是写讲义，而是做四件事：

1. 理解这本讲义的写作目标和章节结构；
2. 按写作目标筛选 `refers/_active/` 中的素材；
3. 建立素材清单和章节映射；
4. 提出后续写作前需要确认的问题。

请先让 Codex 阅读以下文件，顺序如下：

```text
task-prompt/00_README_first_round.md
task-prompt/codex_master_task.md
task-prompt/book_writing_plan.md
task-prompt/material_screening_rules.md
task-prompt/first_round_material_audit_task.md
task-prompt/output_templates.md
```

第一轮完成后，应生成：

```text
working/materials_inventory.md
working/chapter_material_map.md
working/missing_materials.md
working/reserve_reading_requests.md
working/next_questions.md
working/first_round_summary.md
```

## 目录约束

正式仓库会同步到 GitHub，并供学员访问和 fork。因此，必须区分正式发布内容和本地过程材料。

```text
ci-policy/
├── lectures/       # 正式讲义
├── notebooks/      # 正式 Notebook
├── cases/          # 正式案例材料
├── resources/      # 正式资源索引
├── refs/           # 正式参考文献
├── figs/           # 正式图片
├── scripts/        # 正式脚本
├── data/           # 可公开数据、模拟数据、数据说明
├── exercises/      # 课堂练习与课后任务
├── refers/         # 本地素材库，不提交 GitHub
├── working/        # Codex 过程文件，不提交 GitHub
└── task-prompt/    # Codex 任务说明，可提交或本地保留
```

`refers/` 与 `working/` 应写入 `.gitignore`。`task-prompt/` 可以提交，也可以只保留在本地；若不希望学生看到 Codex 任务说明，也可以写入 `.gitignore`。

## 第一轮禁止事项

- 不要撰写正式讲义正文；
- 不要递归读取整个 `refers/`；
- 不要读取 `refers/_reserve/` 和 `refers/_archive/`；
- 不要读取 `.zip`、大批量 `.pdf`、`.html`、`out/`、完整 package 源码目录；
- 不要修改 `refers/` 中的原始材料；
- 不要把 `refers/` 或 `working/` 中的本地路径写入正式讲义；
- 不要把课程写成因果推断方法大全。

## 第一轮判断标准

所有素材都必须围绕本课程主题判断：

> 因果推断：政策评估中的识别思维与实证设计

本讲义的主线是：

```text
政策目标 → 政策实施机制 → 数据形成机制 → 识别威胁 → 研究设计 → 估计方法 → 结果解释
```

方法只能从具体识别障碍中引出，不能孤立堆叠。
