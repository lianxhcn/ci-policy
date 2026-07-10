# 第六章 DID 方法选择工作包（更新版）

本包包含更新后的第六章规划文档，并保留 A6 附录骨架。

## 本次更新

已将 FWL 讲义中「FWL 应用 4：倍分法 (DID)」的核心内容纳入第六章规划。第六章第 2 节调整为「从 2×2 DID 看清楚『两次差分』」，先讲四个均值、两个主效应和一个交互项，再进入事件研究、交错处理和现代 DID 方法选择。

## 文件

```text
chapter6_did_method_selection_package_updated/
├── docs/
│   └── chapter6_did_method_selection_planning.md
└── resources/
    └── did_methods/
        ├── A06_did_method_selection.ipynb
        └── A06_did_method_selection.do
```

## 使用建议

1. 先阅读 `docs/chapter6_did_method_selection_planning.md`。
2. 将 `resources/did_methods/` 复制到 Quarto 项目对应目录。
3. 在本地使用 nbstata 打开 `A06_did_method_selection.ipynb`。
4. 若某些扩展命令安装失败，不要中断主线；优先保证 2×2 DID、`mpdta`、TWFE、`csdid` 和 `drdid` 模块跑通。
5. 第六章正文确认后，再根据 A6 的实际运行结果决定是否把多估计量同框图放入正文。

## 注意

本环境没有实际运行 Stata 命令。Notebook 和 do-file 是可执行骨架，需在本地 Stata / nbstata 中运行后生成输出。
