# 因果推断：政策评估中的识别思维与实证设计

本项目是一套面向经管类研究者的在线讲义，主线是：

```text
政策目标 → 政策实施机制 → 数据形成机制 → 识别威胁 → 研究设计 → 估计方法 → 结果解释
```

在线版本：<https://lianxhcn.github.io/ci-policy/>

教师或研究者如果希望基于本项目备课，可以先阅读 [参与维护本讲义](CONTRIBUTING.md) 和 [AGENTS.md 模板](AGENTS_template.md)。

## 目录结构

```text
lectures/        正式章节和阅读型附录
notebooks/       学生可运行的 Notebook、Stata do-file 和配套数据
data/            跨章节共享的示例数据
resources/       阅读地图、政策说明和辅助资料
exercises/       练习题
figs/            讲义图片、原尺寸图片源和图片处理 Notebook
task-prompt/     公开的写作规划和备课提示
working/         本地过程文件、草稿和 Agent 协作记录，不参与发布
refers/          原始参考资料，不参与发布
```

## 如何阅读

- 正式内容从 `index.qmd`、`syllabus.qmd` 和 `lectures/` 开始。
- 需要运行示例时，进入 `notebooks/ch03_heckman/`、`notebooks/ch04_fixed_effects/`、`notebooks/ch05_counterfactuals/`、`notebooks/ch06_did/` 或 `notebooks/ch07_ddml/`。
- 阅读型附录位于 `lectures/appendix/`，包括政策案例、政府引导基金、样本选择文献和复现说明。
- 第九章提供一份有限的延伸阅读清单，不把软件包和论文链接当作识别判断的替代品。

## 本地素材与复现资料

`refers/` 保存写作过程中使用的原始资料，包括 Lane (2025) 的论文与复现材料。这些文件体积较大、版本变化较快，也可能包含仅供研究整理使用的材料，因此不纳入公开仓库。正式讲义只引用公开可访问的论文、数据和代码入口。

写作过程中的多版本草稿、比较稿和交接文件保存在 `working/agent-drafts/`，同样不参与 Quarto 发布。

## 本地预览

本项目使用 Quarto Book 构建。安装 Quarto 后，在项目根目录运行：

```powershell
quarto render
```

生成的网页位于 `docs/`。本项目采用静态发布：每次更新后，在本地完成渲染，并将源码和 `docs/` 一并提交到 `main` 分支。GitHub Pages 应设置为从 `main` 分支的 `/docs` 目录发布。

## 反馈

讲义仍在持续修订。发现链接、公式、代码或识别逻辑问题时，欢迎提交 Issue 或 Pull Request。
