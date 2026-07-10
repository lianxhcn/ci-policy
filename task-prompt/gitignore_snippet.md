# .gitignore 建议片段

请将以下内容加入 `ci-policy/.gitignore`。

```gitignore
# 本地素材与过程文件，不提交 GitHub
refers/
working/

# 如不希望学生看到 Codex 任务说明，也可忽略
# task-prompt/

# 运行日志与临时文件
logs/*.tmp
*.log

# Notebook 缓存
.ipynb_checkpoints/

# Python 缓存
__pycache__/
*.pyc

# R / Stata / 系统临时文件
.Rhistory
.RData
*.stswp
.DS_Store
Thumbs.db
```

说明：

- `refers/`：本地素材库，Codex 可以读取，但不提交 GitHub；
- `working/`：Codex 过程文件，不提交 GitHub；
- `task-prompt/`：可提交也可忽略。若希望未来复盘写作过程，可以保留；若希望仓库更干净，可以忽略。
