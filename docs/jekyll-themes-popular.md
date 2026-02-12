# GitHub 热门 Jekyll 模板

常用且 star 较多的 Jekyll 主题，适用于 GitHub Pages 博客或文档站。

| 主题 | Stars | 说明 | 仓库 |
|------|-------|------|------|
| **al-folio** | 15k+ | 学术/个人主页，简洁响应式 | [alshedivat/al-folio](https://github.com/alshedivat/al-folio) |
| **Minimal Mistakes** | 13k+ | 个人站、博客、项目文档、作品集 | [mmistakes/minimal-mistakes](https://github.com/mmistakes/minimal-mistakes) |
| **Chirpy** | 10k+ | 技术博客，简约、功能多、PWA | [cotes2020/jekyll-theme-chirpy](https://github.com/cotes2020/jekyll-theme-chirpy) |
| **Just the Docs** | 9k+ | 文档站，内置搜索、可定制 | [just-the-docs/just-the-docs](https://github.com/just-the-docs/just-the-docs) |
| **Hux Blog** | 8k+ | 博客主题，PWA | [Huxpro/huxpro.github.io](https://github.com/Huxpro/huxpro.github.io) |
| **Minima** | 4k+ | 官方 Jekyll 主题，适合写作 | [jekyll/minima](https://github.com/jekyll/minima) |
| **Hyde** | 4k+ | 双栏布局 | [poole/hyde](https://github.com/poole/hyde) |

## GitHub Pages 官方主题

在仓库 **Settings → Pages** 中可直接选用（仅部分环境支持）：

- [Architect](https://github.com/pages-themes/architect)
- [Cayman](https://github.com/pages-themes/cayman)（当前项目所用）
- [Minimal](https://github.com/pages-themes/minimal)
- [Modernist](https://github.com/pages-themes/modernist)
- [Slate](https://github.com/pages-themes/slate)
- 等，详见 [pages.github.com/themes](https://pages.github.com/themes/)

## 使用方式

- **Gem 主题**：在 `_config.yml` 中设置 `theme: 主题名`，并在 `Gemfile` 中引入对应 gem。
- **远程主题**：使用 `remote_theme: 用户名/仓库名`（GitHub Pages 支持）。
- **Fork / 复制**：将主题仓库 fork 后替换为自己的内容。

当前博客使用 `jekyll-theme-cayman`，前台为 Vue 构建的静态站，仅构建与部署走 Jekyll。
