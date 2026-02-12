# 当前博客如何用 Jekyll

## 现状概览

- **站点内容**：前台是 **Vue 打包的静态站**（`index.html` + `css/`、`js/`、`img/` 等），不是 Jekyll 模板生成的页面。
- **Jekyll 的作用**：在 **GitHub Actions** 里用 Jekyll 做「构建 + 部署」：把仓库根目录当 Jekyll 源站，输出到 `_site`，再由 GitHub Pages 发布。

因此：**博客页面来自 Vue 构建结果，Jekyll 负责构建流程和部署。**

---

## 1. 配置（Jekyll 相关）

| 文件/目录 | 作用 |
|-----------|------|
| `_config.yml` | Jekyll 全局配置：`url`、`baseurl`、`theme`、`exclude` 等 |
| `Gemfile` | Jekyll 依赖，本地可 `bundle install && bundle exec jekyll serve` |
| `CNAME` | 自定义域名 `github.zkyml.com`，构建时会被拷到 `_site` |

主题为 `jekyll-theme-cayman`，目前没有用该主题的 Markdown 页面时，主题主要作为兜底；首页是根目录的 `index.html`（Vue 入口）。

---

## 2. 部署流程（GitHub Actions）

- **触发**：推送到 `master`（或手动在 Actions 里运行 workflow）。
- **步骤**：
  1. `actions/checkout@v4` 拉取仓库
  2. `actions/configure-pages@v5` 配置 Pages
  3. `actions/jekyll-build-pages@v1` 用 Jekyll 把 `./` 构建到 `./_site`
  4. `actions/upload-pages-artifact@v3` 上传产物
  5. `actions/deploy-pages@v4` 部署到 GitHub Pages

- **结果**：`_site` 里的内容即线上站点（含你的 Vue 静态资源 + CNAME 等）。

---

## 3. 本地用 Jekyll 预览（可选）

```bash
bundle install
bundle exec jekyll serve
```

浏览器打开 `http://127.0.0.1:4000`。  
此时看到的是「Jekyll 构建后的站点」：和 GitHub Actions 里构建结果一致（含当前 `index.html` 与静态资源）。

---

## 4. 若想用 Jekyll 写博客文章

在保留现有 Vue 站的前提下，可以增加 Jekyll 文章与页面：

1. **文章**：在根目录新建 `_posts`，按 `YYYY-MM-DD-标题.md` 命名，写 Markdown + 头信息，例如：
   ```yaml
   ---
   layout: default
   title: 文章标题
   date: 2025-02-12
   ---
   正文...
   ```
2. **布局**：可建 `_layouts/default.html` 等，或继续用主题自带的 layout。
3. **首页**：当前根目录已有 `index.html`，Jekyll 会原样复制；若希望首页改为 Jekyll 生成，可改为 `index.md` 并使用 `layout`，或保留 `index.html` 仅在其他路径（如 `/blog/`）用 Jekyll 文章。

---

## 5. 小结

| 项目 | 说明 |
|------|------|
| 线上内容来源 | Vue 构建的静态文件（`index.html`、`css/`、`js/`、`img/`） |
| Jekyll 角色 | 在 CI 中执行构建并输出到 `_site`，供 GitHub Pages 部署 |
| 自定义域名 | `CNAME` 中为 `github.zkyml.com`，HTTPS 在 GitHub 设置中启用 |
| 本地预览 | `bundle install && bundle exec jekyll serve` |

当前博客 = **Vue 静态站 + Jekyll 构建/部署**；若以后要用 Jekyll 写文章，按第 4 节增加 `_posts` 与（可选）`_layouts` 即可。
