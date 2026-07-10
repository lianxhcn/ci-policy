# 学员环境配置文档使用说明

本文件夹中的文档用于帮助学员配置课程所需的 Python、Stata、`nbstata`、Jupyter / VS Code Notebook 和 Quarto 环境。

课程中的代码和 Notebook 依赖每位学员自己的电脑环境。不同电脑上的 Python、Conda、Stata 路径可能不同，所以不要直接复制老师电脑上的路径。正确做法是：**先记录自己电脑上的路径，再把记录交给 Agent 配置**。

如果你是从在线讲义进入本文件夹，请先阅读书稿中的 `settings.qmd`。那里给出了课前环境准备的整体路线：基础软件缺失时先参考手动安装资料，已有基础软件时再使用本文件夹中的 Agent 辅助配置文档。

## 1. 先读哪一份

所有学员都先读：

```text
student-agent-env-setup-guide.md
```

这是一份完整通用指南，说明如何：

- 查找 Python、Conda、Stata 和 Quarto 的路径；
- 填写 `my-local-env.md`；
- 让 Agent 根据路径安装和配置 `nbstata`；
- 验证 Stata Notebook 是否能运行；
- 排查常见错误。

## 2. 再按自己的 Agent 选择入口

如果你使用 Codex，读：

```text
README-codex.md
```

如果你使用 Claude Code，读：

```text
README-claude-code.md
```

如果你使用 cc-switch，或使用 DeepSeek、Qwen、Kimi 等模型驱动的其他 Agent，读：

```text
README-other-agents.md
```

这三份入口文档不会重复完整技术细节，只告诉你如何把任务交给对应 Agent。

## 3. 推荐使用顺序

1. **Step 1**: 复制 `student-agent-env-setup-guide.md` 中的 `my-local-env.md` 模板。
2. **Step 2**: 用 PowerShell 或 Everything 查找本机软件路径。
3. **Step 3**: 填写 `my-local-env.md`。
4. **Step 4**: 打开你的 Agent 工具。
5. **Step 5**: 把 `my-local-env.md` 和 `student-agent-env-setup-guide.md` 交给 Agent。
6. **Step 6**: 根据你使用的 Agent，再复制对应 README 中的提示词。
7. **Step 7**: 让 Agent 先诊断，不要马上安装。
8. **Step 8**: 诊断通过后，再让 Agent 安装、配置和验证。

## 4. 成功标准

配置完成后，至少应能完成三项测试：

```stata
sysuse auto, clear
summarize price mpg
```

在 Notebook 中能运行：

```stata
%status
```

并且能生成一张简单图：

```stata
scatter price mpg
```

如果这些测试通过，课程中大多数 Stata Notebook 环境问题就已经解决。

## 5. 给学员的提醒

遇到错误时，不要只说“运行不了”。请把下面信息发给老师或助教：

- `my-local-env.md`；
- Agent 的环境配置报告；
- 报错原文；
- 你使用的是 Codex、Claude Code，还是其他 Agent；
- 你电脑上的 Stata 版本和 Python 路径。

这样排查会快很多。
