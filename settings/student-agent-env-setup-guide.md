# 学员通用环境配置指南：Python、Stata、nbstata 与 Agent 协作

本文档用于课堂学员配置本机 Python、Stata、`nbstata`、Jupyter / VS Code Notebook 和 Quarto 环境。适用对象包括 Codex、Claude Code，以及通过 cc-switch 调用 DeepSeek、Qwen、Kimi 等模型的用户。

本文档的核心思路是：**先把本机软件路径查清楚并记录下来，再把记录交给 Agent 执行配置**。不要让 Agent 一开始就猜路径、改系统设置或全局重装环境。

`retrieved_date`: 2026-07-10

## 1. 本文档要解决什么问题

本课程会用到 Python、Stata 和 Notebook。不同学员电脑环境差异很大，常见问题包括：

- Python 装了多个版本，Agent 调用了错误的 `python.exe`。
- 安装了 Anaconda，但不知道 `conda.exe` 在哪里。
- Stata 已经安装，但 Agent 找不到 `StataMP-64.exe`、`StataSE-64.exe` 或 `StataBE-64.exe`。
- `nbstata` 安装到了一个 Python 环境，但 Jupyter 使用的是另一个环境。
- `nbstata.conf` 中的 `stata_dir` 写成了 Stata 可执行文件，而不是 Stata 安装目录。
- Windows 中文路径、PowerShell 编码或网络下载导致安装失败。

因此，配置工作分成三段：

1. **记录本机路径**：先找出 Python、Conda、Stata、R、Quarto、Jupyter 的真实路径。
2. **交给 Agent 配置**：让 Agent 根据路径记录表安装或修正 `nbstata`。
3. **运行最小测试**：先跑 `sysuse auto, clear`，再跑课程中的 Notebook 和脚本。

## 2. 学员先做什么

每位学员先在自己的项目目录或桌面新建一个文件：

```text
my-local-env.md
```

把下面模板复制进去。能填多少填多少，不确定的先留空。

```markdown
# 我的本机环境记录

## 1. 操作系统

- Windows 版本：
- 用户名：
- 是否有中文路径：是 / 否 / 不确定

## 2. Python

- 我希望课程使用的 Python 路径：
- Python 版本：
- 是否使用 Anaconda / Miniconda：是 / 否 / 不确定
- Conda 路径：
- 课程使用的 Conda 环境名称：
- `pip` 路径或 `python -m pip` 是否可用：

## 3. Stata

- Stata 版本：17 / 18 / 19 / 其他 / 不确定
- Stata edition：MP / SE / BE / 不确定
- Stata 可执行文件路径：
- Stata 安装目录：
- 是否能手动打开 Stata：是 / 否

## 4. Jupyter / VS Code / Quarto

- 是否使用 VS Code：是 / 否
- 是否安装 Jupyter 或 JupyterLab：是 / 否 / 不确定
- 是否安装 Quarto：是 / 否 / 不确定
- 是否已经能打开 `.ipynb` 文件：是 / 否 / 不确定

## 5. Agent 工具

- 我使用的 Agent：Codex / Claude Code / cc-switch / 其他
- 如果使用 cc-switch，后端模型是：

## 6. 当前问题

- Agent 报错原文：
- 我希望 Agent 完成的事情：
```

这个文件是后续配置的基础。Agent 读到它以后，应该优先使用里面的路径，而不是重新猜。

## 3. 如何查找本机软件路径

### 3.1 方法一：用 PowerShell 自动探测

打开 PowerShell，先运行：

```powershell
[Console]::InputEncoding = [System.Text.UTF8Encoding]::new()
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()
$OutputEncoding = [System.Text.UTF8Encoding]::new()
$env:PYTHONIOENCODING = "utf-8"
```

检查常见命令：

```powershell
Get-Command python -ErrorAction SilentlyContinue
Get-Command py -ErrorAction SilentlyContinue
Get-Command conda -ErrorAction SilentlyContinue
Get-Command jupyter -ErrorAction SilentlyContinue
Get-Command quarto -ErrorAction SilentlyContinue
```

检查版本：

```powershell
python --version
py --version
conda --version
quarto --version
```

如果有些命令失败，不要急着重装，继续查常见路径。

### 3.2 查找 Python 和 Conda

```powershell
$pythonCandidates = @(
    ".\.venv\Scripts\python.exe",
    "$env:USERPROFILE\.conda\envs\dml050\python.exe",
    "$env:USERPROFILE\.conda\envs\base\python.exe",
    "$env:USERPROFILE\anaconda3\python.exe",
    "$env:USERPROFILE\miniconda3\python.exe",
    "C:\ProgramData\anaconda3\python.exe",
    "C:\ProgramData\miniconda3\python.exe",
    "C:\Python312\python.exe",
    "C:\Python311\python.exe",
    "C:\Python310\python.exe"
)

foreach ($p in $pythonCandidates) {
    if (Test-Path $p) {
        Write-Host "FOUND_PYTHON=$p"
        & $p --version
    }
}
```

查找 Conda：

```powershell
$condaCandidates = @(
    "$env:USERPROFILE\anaconda3\Scripts\conda.exe",
    "$env:USERPROFILE\miniconda3\Scripts\conda.exe",
    "C:\ProgramData\anaconda3\Scripts\conda.exe",
    "C:\ProgramData\miniconda3\Scripts\conda.exe"
)

foreach ($c in $condaCandidates) {
    if (Test-Path $c) {
        Write-Host "FOUND_CONDA=$c"
        & $c --version
        & $c info --envs
    }
}
```

把输出中的 `FOUND_PYTHON`、`FOUND_CONDA` 和 Conda 环境名称填入 `my-local-env.md`。

### 3.3 查找 Stata

先查常见安装位置：

```powershell
$stataCandidates = @(
    "C:\Program Files\Stata19\StataMP-64.exe",
    "C:\Program Files\Stata19\StataSE-64.exe",
    "C:\Program Files\Stata19\StataBE-64.exe",
    "C:\Program Files\Stata18\StataMP-64.exe",
    "C:\Program Files\Stata18\StataSE-64.exe",
    "C:\Program Files\Stata18\StataBE-64.exe",
    "C:\Program Files\Stata17\StataMP-64.exe",
    "C:\Program Files\Stata17\StataSE-64.exe",
    "C:\Program Files\Stata17\StataBE-64.exe",
    "D:\stata19\StataMP-64.exe",
    "D:\stata18\StataMP-64.exe",
    "D:\stata17\StataMP-64.exe"
)

foreach ($s in $stataCandidates) {
    if (Test-Path $s) {
        Write-Host "FOUND_STATA=$s"
    }
}
```

如果没有找到，可以扩大搜索。这个命令可能较慢：

```powershell
Get-ChildItem -Path "C:\Program Files","C:\Program Files (x86)","D:\" `
    -Filter "Stata*-64.exe" -Recurse -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty FullName
```

把找到的 Stata 可执行文件路径填入 `my-local-env.md`。Stata 安装目录就是这个 `.exe` 文件所在的文件夹。

例如：

```text
Stata 可执行文件路径：D:\stata19\StataMP-64.exe
Stata 安装目录：D:\stata19
Stata edition：MP
```

### 3.4 方法二：用 Everything 人工搜索

如果 PowerShell 搜不到，可以使用 Everything 搜索以下文件名：

```text
python.exe
conda.exe
StataMP-64.exe
StataSE-64.exe
StataBE-64.exe
Rscript.exe
quarto.exe
jupyter.exe
```

Everything 的好处是速度快，适合课堂现场排查。找到路径后，右键复制完整路径，填入 `my-local-env.md`。

需要注意：

- `python.exe` 可能有多个，优先选择课程使用的 Conda 环境或项目 `.venv` 中的 Python。
- Stata 的 `stata_dir` 应写安装目录，不写 `.exe` 文件。
- 不确定哪个 Python 正确时，把所有候选路径都写进 `my-local-env.md`，让 Agent 帮你判断。

## 4. 交给 Agent 的任务

准备好 `my-local-env.md` 后，把它和本文档一起交给你的 Agent，并要求 Agent 按下面顺序执行：

1. **只读文档，不要立即安装**。
2. 根据 `my-local-env.md` 判断 Python、Conda 和 Stata 路径。
3. 如果路径不完整，先运行诊断命令补全路径。
4. 设置当前 shell 的环境变量。
5. 先运行 Stata 命令行 smoke test。
6. 检查 `nbstata` 是否已安装。
7. 如未安装，再安装 `nbstata` 和 Jupyter。
8. 注册 `nbstata` kernel。
9. 写入或检查 `nbstata.conf`。
10. 用 Jupyter / VS Code Notebook 跑最小 Stata cell。

Agent 不应一开始就修改系统级 `PATH`，也不应删除已有配置文件。

## 5. Agent 可使用的环境变量

Agent 找到路径后，应在当前 PowerShell 会话设置：

```powershell
$env:PYTHON_EXE = "替换为本机 python.exe 路径"
$env:CONDA_EXE = "替换为本机 conda.exe 路径；如果没有 Conda 可留空"
$env:STATA_EXE = "替换为本机 Stata*-64.exe 路径"
$env:STATA_DIR = Split-Path $env:STATA_EXE -Parent
```

根据 Stata 文件名判断 edition：

```powershell
if ($env:STATA_EXE -match "StataMP") { $env:STATA_EDITION = "mp" }
elseif ($env:STATA_EXE -match "StataSE") { $env:STATA_EDITION = "se" }
elseif ($env:STATA_EXE -match "StataBE") { $env:STATA_EDITION = "be" }
else { $env:STATA_EDITION = "mp" }
```

验证：

```powershell
& $env:PYTHON_EXE --version
& $env:PYTHON_EXE -m pip --version
Test-Path $env:STATA_EXE
$env:STATA_DIR
$env:STATA_EDITION
```

## 6. Stata 命令行最小测试

Agent 应先确认 Stata 命令行可用，再处理 `nbstata`。

```powershell
New-Item -ItemType Directory -Force -Path "tmp","logs"

$do = @"
clear all
set more off
capture log close _all
log using "logs/stata_smoke_test.log", replace text
display "Stata version: " c(stata_version)
display "Stata edition: " c(edition)
sysuse auto, clear
summarize price mpg weight
display "Stata smoke test OK"
log close
exit, clear
"@

Set-Content -Path "tmp\stata_smoke_test.do" -Value $do -Encoding utf8
& $env:STATA_EXE /e do "tmp\stata_smoke_test.do"
Get-Content "logs\stata_smoke_test.log" -Encoding utf8 -TotalCount 80
```

成功标准：

- 生成 `logs/stata_smoke_test.log`。
- 日志中出现 `Stata smoke test OK`。
- 日志中没有 `r(...)` 错误。

如果 `/e do` 不能正常结束，可尝试：

```powershell
& $env:STATA_EXE /b do "tmp\stata_smoke_test.do"
```

## 7. 安装和检查 nbstata

先检查：

```powershell
& $env:PYTHON_EXE -m pip show nbstata
& $env:PYTHON_EXE -c "import nbstata; print(nbstata.__file__)"
```

如果未安装：

```powershell
& $env:PYTHON_EXE -m pip install --upgrade pip
& $env:PYTHON_EXE -m pip install nbstata jupyterlab
```

如果网络失败，Agent 应报告错误，不要擅自修改系统代理，也不要安装未知来源包。

安装 kernel：

```powershell
& $env:PYTHON_EXE -m nbstata.install --sys-prefix --conf-file
& $env:PYTHON_EXE -m jupyter kernelspec list
```

## 8. 配置 nbstata.conf

`nbstata.conf` 中最关键的是：

```ini
[nbstata]
stata_dir = 你的 Stata 安装目录
edition = mp 或 se 或 be
```

注意：`stata_dir` 是 Stata 安装目录，不是 `.exe` 文件。

Agent 可以这样写入当前 Python 环境的配置文件：

```powershell
$pythonPrefix = & $env:PYTHON_EXE -c "import sys; print(sys.prefix)"
$nbstataConfDir = Join-Path $pythonPrefix "etc"
$nbstataConf = Join-Path $nbstataConfDir "nbstata.conf"
New-Item -ItemType Directory -Force -Path $nbstataConfDir

$conf = @"
[nbstata]
stata_dir = $env:STATA_DIR
edition = $env:STATA_EDITION
splash = False
graph_format = png
graph_width = default
graph_height = default
echo = False
browse_auto_height = False
"@

Set-Content -Path $nbstataConf -Value $conf -Encoding utf8
Get-Content -Path $nbstataConf -Encoding utf8
```

如果用户主目录也有配置文件，它可能覆盖当前环境配置。先检查，不要直接删除：

```powershell
$userConf = Join-Path $env:USERPROFILE ".config\nbstata\nbstata.conf"
if (Test-Path $userConf) {
    Write-Host "User config exists:"
    Write-Host $userConf
    Get-Content $userConf -Encoding utf8
}
```

## 9. Notebook 验证

启动 JupyterLab：

```powershell
& $env:PYTHON_EXE -m jupyter lab
```

或在 VS Code 中打开 `.ipynb`，选择 `Stata` / `nbstata` kernel。

第一个 Stata cell 运行：

```stata
about
display c(stata_version)
display c(edition)
sysuse auto, clear
summarize price mpg
%status
```

图形测试：

```stata
sysuse auto, clear
scatter price mpg
```

成功标准：

- Notebook 可以选择 `Stata` 或 `nbstata` kernel。
- `sysuse auto, clear` 可以运行。
- `%status` 能显示 `stata_dir`。
- 图形能显示为 PNG。

## 10. Quarto 验证

如果课程材料使用 `.qmd`，可以创建一个测试文件：

````markdown
---
title: "nbstata test"
jupyter: nbstata
format: html
---

```{stata}
sysuse auto, clear
summarize price mpg
```
````

渲染前先检查 kernel：

```powershell
& $env:PYTHON_EXE -m jupyter kernelspec list
```

如果 Quarto 找不到 kernel，重新注册：

```powershell
& $env:PYTHON_EXE -m nbstata.install --sys-prefix --conf-file
```

## 11. 常见错误

### 11.1 pip 装到了错误环境

错误做法：

```powershell
pip install nbstata
```

推荐做法：

```powershell
& $env:PYTHON_EXE -m pip install nbstata
```

### 11.2 把 stata_dir 写成了 exe

错误：

```ini
stata_dir = D:\stata19\StataMP-64.exe
```

正确：

```ini
stata_dir = D:\stata19
```

### 11.3 Stata 授权问题

如果命令行启动 Stata 后很快退出，或提示 license 问题，先让学员手动打开 Stata，确认授权可用。Agent 不应处理激活码、账户或密码。

### 11.4 网络下载失败

如果出现 `ProxyError`、`Connection timed out` 或 `Could not fetch URL`，先记录报错。可以换网络或使用老师提供的离线包。Agent 不应擅自改系统代理。

## 12. Agent 完成后的报告格式

Agent 完成后，应向学员报告：

```markdown
# 环境配置报告

## 已确认路径

- Python:
- Conda:
- Stata exe:
- Stata dir:
- Stata edition:

## 已完成检查

- Python 版本：
- pip 可用：是 / 否
- Stata smoke test：通过 / 失败
- nbstata 安装：已安装 / 新安装 / 失败
- Jupyter kernel：已注册 / 未注册
- Notebook 测试：通过 / 失败

## 仍需人工处理

- 

## 原始报错

```text
如有失败，把关键报错粘贴在这里
```
```

这份报告很重要。后续如果课堂代码仍然不能运行，老师或助教可以根据报告快速判断问题在哪里。

## 13. 不要做的事情

Agent 不应做以下事情：

- 不要猜路径。
- 不要修改系统级 `PATH`。
- 不要修改注册表。
- 不要删除已有 Python、Conda、Stata、Jupyter 配置。
- 不要读取或写入密钥、token、账户密码。
- 不要把老师电脑路径写入学员电脑。
- 不要把本机绝对路径写入公开仓库。
- 不要在没有确认的情况下重装 Anaconda、Stata 或 VS Code。

简言之：先诊断，后安装；先最小测试，后运行课程代码。

