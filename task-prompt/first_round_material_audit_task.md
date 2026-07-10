# 第一轮任务：素材盘点与章节映射

本文件规定 Codex 第一轮的具体执行任务。

## 1. 执行前必须阅读

请先阅读：

```text
task-prompt/00_README_first_round.md
task-prompt/codex_master_task.md
task-prompt/book_writing_plan.md
task-prompt/material_screening_rules.md
task-prompt/output_templates.md
```

理解项目目标后，再读取素材。

## 2. 素材读取范围

第一轮只读取：

```text
refers/_active/
```

不要读取：

```text
refers/_reserve/
refers/_archive/
```

不要读取：

```text
.zip
.html
out/
完整 package 源码目录
大量旧输出图片
```

如果一个目录中有大量文件，请先读取目录结构和最可能有用的 `.md`、`.qmd`、`.ipynb`、`.do`、`README`，不要盲目递归读取所有文件。

## 3. 第一轮输出文件

请在 `working/` 目录下生成以下文件：

```text
working/materials_inventory.md
working/chapter_material_map.md
working/missing_materials.md
working/reserve_reading_requests.md
working/next_questions.md
working/first_round_summary.md
```

如果 `working/` 不存在，请创建。

## 4. `working/materials_inventory.md`

这是素材总清单。每份材料一条记录。

字段包括：

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

优先级分为：

```text
P1：第一轮核心材料，后续写作应优先使用
P2：有用，但主要作为延伸阅读或备用
P3：暂不使用，除非后续章节需要
P0：不建议使用
```

建议用途分为：

```text
直接改写为正式讲义
改写为案例材料
转化为 Notebook 示例
放入延伸阅读
放入资源索引
暂时保留，后续按需读取
忽略
```

## 5. `working/chapter_material_map.md`

按章节组织素材。

结构如下：

```markdown
# 章节素材映射

## 第 1 章 政策评估从政策目标开始

### 可用素材

### 适合改写的内容

### 适合插入的案例

### 适合延伸阅读的资源

### 缺失素材

### 后续建议
```

每章都按这个结构整理。

## 6. `working/missing_materials.md`

列出当前素材不足的部分。

每条包括：

```text
缺失内容
对应章节
为什么需要
可以从哪里补
是否必须补
```

例如：

```text
缺失内容：Lane (2025) 复现包的目录说明
对应章节：第 2 章、第 5 章、第 7 章
为什么需要：主线案例需要明确处理变量、对照组、复现任务拆解
是否必须补：是
```

## 7. `working/reserve_reading_requests.md`

如果你认为需要读取 `refers/_reserve/` 或 `refers/_archive/` 中的某些材料，请在这里提出申请。

每条包括：

```text
拟读取路径
服务章节
读取理由
是否需要全目录
是否只需读取特定文件类型
风险提示
```

注意：第一轮不要自行读取 `_reserve/` 和 `_archive/`。

## 8. `working/next_questions.md`

列出需要老师确认的问题。

只列真正影响写作决策的问题。不要问泛泛问题。

问题示例：

```text
1. Lane (2025) 复现包是否放入 refers/_active/，还是后续单独读取？
2. 政府引导基金案例是否可以公开使用，还是只作为课堂口头案例？
3. 第 5 章是否重点讲 SCM，还是只作为少数处理对象的副例？
```

## 9. `working/first_round_summary.md`

第一轮摘要，控制在 1000–1500 字。

内容包括：

- 当前素材总体判断；
- 最适合支撑主线的 5–8 份材料；
- 哪些资料明显过重或暂不适合；
- 哪些章节素材充足；
- 哪些章节还缺素材；
- 下一轮建议。

## 10. 禁止事项

第一轮不要：

- 写正式讲义；
- 写章节草稿；
- 修改正式目录；
- 复制材料到正式目录；
- 修改原始素材；
- 读取未授权目录；
- 生成大量摘要；
- 让项目变成方法资料库。
