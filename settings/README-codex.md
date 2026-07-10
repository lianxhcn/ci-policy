# Codex 用户入口说明

本文档适合使用 Codex 的学员。完整技术步骤请读：

```text
student-agent-env-setup-guide.md
```

## 1. 先准备两个文件

请准备：

```text
student-agent-env-setup-guide.md
my-local-env.md
```

`my-local-env.md` 是你自己的本机路径记录。不要直接使用老师电脑上的路径。

## 2. 发给 Codex 的提示词

把下面这段发给 Codex：

```text
请先阅读 student-agent-env-setup-guide.md 和 my-local-env.md。

我的目标是配置本机 Python、Stata、nbstata、Jupyter / VS Code Notebook 环境，用于课程中的 Stata 和 Python Notebook。

请按以下规则执行：

1. 先只做环境诊断，不要马上安装或修改配置。
2. 根据 my-local-env.md 判断 Python、Conda、Stata 的路径是否完整。
3. 如果路径缺失，请用 PowerShell 探测常见路径，并把候选路径列出来让我确认。
4. 不要修改系统 PATH，不要修改注册表，不要删除已有配置文件。
5. 确认路径后，先运行 Stata smoke test。
6. 再检查 nbstata 是否安装。
7. 如需安装，请使用明确的 Python 路径执行 python -m pip，不要使用裸 pip。
8. 配置 nbstata.conf 时，stata_dir 写 Stata 安装目录，不写 Stata*.exe。
9. 最后用 Notebook 运行 sysuse auto, clear、summarize price mpg 和 %status。
10. 完成后生成一份环境配置报告，列出成功项、失败项和原始报错。
```

## 3. Codex 中的注意事项

Codex 可能会请求执行命令或安装包。建议按下面原则处理：

- 诊断命令通常可以允许。
- 安装 Python 包前，先确认它使用的是你希望的 Python。
- 不要允许它删除配置文件，除非你已经明确知道该文件是错误配置。
- 如果它请求修改系统级 `PATH`、注册表或系统代理，先停止并询问老师或助教。

## 4. 让 Codex 分两轮做

第一轮只做诊断：

```text
请只诊断环境并生成报告，不要安装任何包，不要修改配置。
```

第二轮再配置：

```text
根据上一轮诊断结果，请安装或修正 nbstata，并完成 Stata Notebook 最小测试。
```

这样最省时间，也最不容易把环境改乱。

