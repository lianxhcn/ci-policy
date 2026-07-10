# Claude Code 用户入口说明

本文档适合使用 Claude Code 的学员。完整技术步骤请读：

```text
student-agent-env-setup-guide.md
```

## 1. 先准备路径记录

请先填写：

```text
my-local-env.md
```

如果不知道路径，可以先用 Everything 搜索：

```text
python.exe
conda.exe
StataMP-64.exe
StataSE-64.exe
StataBE-64.exe
quarto.exe
```

把候选路径都写入 `my-local-env.md`，Claude Code 可以继续判断。

## 2. 发给 Claude Code 的提示词

把下面这段发给 Claude Code：

```text
请阅读 student-agent-env-setup-guide.md 和 my-local-env.md。

你现在的任务不是重装环境，而是根据我的本机路径记录，配置 Python、Stata、nbstata 和 Jupyter / VS Code Notebook。

请严格按下面顺序执行：

1. 先总结你从 my-local-env.md 中读到的路径，不要立即执行安装。
2. 检查 Python、Conda、Stata 路径是否存在。
3. 如果路径不完整，先运行 student-agent-env-setup-guide.md 中的 PowerShell 探测命令。
4. 不要猜路径，不要修改系统 PATH，不要修改注册表，不要删除已有配置文件。
5. 使用 $env:PYTHON_EXE -m pip，而不是裸 pip。
6. 使用 $env:STATA_EXE /e do 运行 Stata smoke test。
7. 检查 nbstata 是否已经安装。
8. 如需安装，安装到我指定的 Python 环境。
9. 写入或检查 nbstata.conf，确保 stata_dir 是 Stata 安装目录，edition 是 mp、se 或 be。
10. 最后用 Jupyter / VS Code Notebook 测试 sysuse auto, clear、summarize price mpg 和 %status。
11. 完成后写一份环境配置报告，不要泛泛说“已完成”，要列出实际路径和测试结果。
```

## 3. Claude Code 中的注意事项

Claude Code 有时会直接尝试运行 `python`、`pip` 或 `stata`。如果它这样做，请提醒它：

```text
请使用 my-local-env.md 中记录的完整路径，或者先探测路径。不要直接使用裸 python、pip 或 stata。
```

如果 Claude Code 报错说找不到 Stata，但你确认电脑上能打开 Stata，通常是路径没有写清楚。请重新检查 `StataMP-64.exe`、`StataSE-64.exe` 或 `StataBE-64.exe` 的位置。

## 4. 推荐分步执行

建议先让 Claude Code 只做诊断：

```text
请只执行环境诊断，并把 FOUND_PYTHON、FOUND_CONDA、FOUND_STATA 的结果整理出来。不要安装包，不要修改配置。
```

确认路径后，再让它继续：

```text
现在根据诊断结果配置 nbstata，并运行 Stata smoke test 和 Notebook 最小测试。
```

