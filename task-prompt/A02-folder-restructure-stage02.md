

# 文件夹重构 - 第二轮

1. 直接把 './exercises/README.md' 合并到 'exercise_overview.qmd' 中，形成新文档 'exercise.qmd'，然后把这个文档放到 './lectures' 文件夹中，作为一个单独的页面存在即可。注意也要相应的调整 _quarto.yml_ 中的章节引用路径。完成后就可以删除 './exercises/' 文件夹了。
2. 'resources/reading_map.qmd' 这个文件我建议把它删掉吧，没什么用。
3. 'A03_heckman_selection_literature' 我觉得这个附录单独存在的必要性不大。考虑到第三章的篇幅本身也不是特别长，我建议可以把这个文档合并到第三章正文里面去。你要酌情调整一下上下文的表述，以便于合并以后仍然能够保持修改后的第三章的内容逻辑顺畅。
4. 'A04_replication_papers.qmd' 这次课里边我不准备讲完整的复现方法了。你帮我检查一下这个文档在书稿正文的哪一章里提到了，如果不是很必要的话，就可以先把它删掉。只需要在正文里面提到 Lane 2025 的论文的时候，告诉读者如果有兴趣做复现，可以查看作者提供的 [Replication Package](https://doi.org/10.7910/DVN/VJECHN)。
   - 该文的完整引文信息：Lane, N. (2025). Manufacturing Revolutions: Industrial Policy and Industrialization in South Korea. The Quarterly Journal of Economics, 140(3), 1683–1741. [Link](https://doi.org/10.1093/qje/qjaf025) (rep), [PDF](https://academic.oup.com/qje/article-pdf/140/3/1683/63400136/qjaf025.pdf), [Google](<https://scholar.google.com/scholar?q=Manufacturing Revolutions: Industrial Policy and Industrialization in South Korea>). [Replication](https://doi.org/10.7910/DVN/VJECHN)
5. 'ci-policy.code-workspace' 文件是我的 VS Code 工作区配置文件，用于记录打开的文件、布局等信息。这个文件可以保留在项目中，但不影响书稿内容的组织。可以把它加到 .gitignore 清单里。

## 章节编号问题

- 「讲义」部分各章可以按顺序编号，但「附录」部分我建议不用顺序编号，可以参考 <https://lianxhcn.github.io/ds2026/> 的做法，附录可以用字母或者其他方式标识，而不必严格按数字顺序。
- 讲义之前的部分，比如前言、导读等，可以不用顺序编号，同时加上表情符号，比如 📖、📝 等，参见 https://lianxhcn.github.io/ds2026/ 