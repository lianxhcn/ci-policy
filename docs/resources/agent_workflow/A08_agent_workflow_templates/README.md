# A8：Agent 工作流模板包

这套模板用于新建实证项目、审计复现包或处理返修任务。它不替代研究设计，也不要求读者一次使用全部文件。最小用法是：复制 `AGENTS_template.md`、`research_design_template.md` 和 `work_log_template.md`，再让 Agent 根据研究对象补全内容。

## 文件说明

- `AGENTS_template.md`：项目规则，规定数据、代码、输出和确认边界。
- `README_template.md`：项目入口，说明研究问题、运行顺序和目录。
- `research_design_template.md`：记录政策背景、样本、变量和识别假设。
- `replication_audit_checklist.md`：审计公开复现包时使用。
- `work_log_template.md`：记录每次任务、运行和待确认问题。
- `data_issues_template.md`：记录数据缺失、口径和合并问题。
- `model_changes_template.md`：记录样本、变量和模型设定变化。
- `decision_log_template.md`：记录研究者的关键判断。
- `prompts/`：交给 Agent 的本地安装、在线下载和返修任务提示词。

## 最小使用步骤

1. 新建一个空项目文件夹。
2. 复制本目录中需要的模板，或让 Agent 按 `prompts/01_create_project_from_local_templates.md` 创建项目。
3. 先填写研究问题、已有材料和不可修改的文件，再让 Agent 创建目录和脚本。
4. 每完成一个可检查阶段，更新日志并由研究者确认。

## 使用边界

- 不把未公开数据、审稿意见、账号、密钥或受限材料交给外部工具。
- 不让 Agent 覆盖原始数据、主脚本或旧输出，除非研究者明确确认。
- 不把「代码能运行」当作「识别策略成立」。
