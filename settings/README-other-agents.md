# cc-switch 和其他 Agent 用户入口说明

本文档适合使用 cc-switch、DeepSeek、Qwen、Kimi 或其他 Agent 的学员。完整技术步骤请读：

```text
student-agent-env-setup-guide.md
```

这类 Agent 的能力差异较大，有的模型很会解释，但执行本地命令时可能不稳定。因此建议采用更保守的方式：**每一步只做一件事，执行后先汇报结果，再继续下一步**。

## 1. 先准备路径记录

请先填写：

```text
my-local-env.md
```

如果不会用 PowerShell，可以用 Everything 搜索：

```text
python.exe
conda.exe
StataMP-64.exe
StataSE-64.exe
StataBE-64.exe
Rscript.exe
quarto.exe
```

把找到的路径复制到 `my-local-env.md`。如果同一个文件名有多个结果，不要删，全部写进去，让 Agent 帮你判断。

## 2. 发给其他 Agent 的提示词

把下面这段发给你的 Agent：

```text
请阅读 student-agent-env-setup-guide.md 和 my-local-env.md。

你要帮我配置课程环境：Python、Stata、nbstata、Jupyter / VS Code Notebook。

请注意：

1. 每次只执行一个阶段，不要连续执行很多命令。
2. 第一阶段只诊断环境，不安装包，不修改配置。
3. 不要猜路径，优先使用 my-local-env.md 中记录的路径。
4. 如果路径缺失，请运行文档中的 PowerShell 探测命令，列出候选路径。
5. 不要修改系统 PATH，不要修改注册表，不要删除配置文件。
6. 不要读取或处理任何账号、密码、密钥、token。
7. 安装 Python 包时，必须使用完整 Python 路径加 -m pip。
8. 配置 nbstata.conf 时，stata_dir 必须写 Stata 安装目录，不写 Stata*.exe。
9. 每完成一步，请先告诉我结果，再等待我确认继续。

请先执行第一阶段：读取文档、总结路径、列出缺失项。不要安装任何东西。
```

## 3. 推荐阶段

### 阶段一：只诊断

目标：

- 找到 Python。
- 找到 Conda。
- 找到 Stata。
- 判断 Stata edition。
- 判断是否已经安装 `nbstata`。

阶段一不要安装任何东西。

### 阶段二：Stata 命令行测试

目标：

- 设置 `$env:STATA_EXE`。
- 运行 `sysuse auto, clear`。
- 生成 `logs/stata_smoke_test.log`。

### 阶段三：Python 和 nbstata

目标：

- 设置 `$env:PYTHON_EXE`。
- 检查 `pip`。
- 检查或安装 `nbstata`。
- 注册 Jupyter kernel。

### 阶段四：Notebook 测试

目标：

- 打开 Jupyter 或 VS Code Notebook。
- 选择 `Stata` / `nbstata` kernel。
- 运行 `sysuse auto, clear`、`summarize price mpg`、`%status`。

## 4. 如果 Agent 开始乱改怎么办

如果 Agent 准备执行以下操作，请先暂停：

- 修改系统 `PATH`。
- 修改注册表。
- 删除 Python、Conda、Stata 或 Jupyter 配置文件。
- 重装 Anaconda。
- 重装 Stata。
- 修改系统代理。
- 读取账号、密码、密钥或 token。

你可以回复：

```text
请暂停。不要修改系统级配置。请只使用当前会话环境变量和项目目录中的测试文件。
```

## 5. 最省时间的做法

对其他 Agent 用户，最稳的做法是：

1. 自己先用 Everything 找路径。
2. 把路径填进 `my-local-env.md`。
3. 让 Agent 只做路径验证。
4. 验证通过后，再让 Agent 安装和配置。

这样比让 Agent 从零搜索整个硬盘更快，也更不容易出错。

