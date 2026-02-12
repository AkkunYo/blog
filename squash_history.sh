#!/bin/bash
# 将全部提交压缩为 1 个，减小仓库体积（会改写历史，需 force push）
# 用法：在仓库根目录执行 bash squash_history.sh

set -e
# 若在仓库子目录执行，可改为: cd /path/to/blog
REPO_DIR="${1:-$(dirname "$0")}"
cd "$REPO_DIR"

if ! git rev-parse --git-dir >/dev/null 2>&1; then
  echo "错误: 当前目录不是 Git 仓库。请在博客仓库根目录执行此脚本。"
  exit 1
fi

echo "仓库: $(pwd)"
echo "当前提交数: $(git rev-list --count HEAD)"
echo "当前 .git 大小: $(du -sh .git | cut -f1)"
echo ""

# 1. 记下当前最新内容对应的 tree
TREE=$(git write-tree)

# 2. 用当前 tree 生成一个「无父提交」的新提交（相当于把全部历史压成 1 个）
NEW_COMMIT=$(git commit-tree "$TREE" -m "chore: squash all history into one commit")

# 3. 让当前分支指向这个新提交
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
git reset --hard "$NEW_COMMIT"

# 4. 清理松散对象、打包，减小 .git
git reflog expire --expire=now --all
git gc --prune=now --aggressive

echo ""
echo "压缩后 .git 大小: $(du -sh .git | cut -f1)"
echo "当前提交数: $(git rev-list --count HEAD)"
echo ""
echo "如需推送到远程（会覆盖远程历史）:"
echo "  git push --force origin $CURRENT_BRANCH"
echo "注意: 若他人也在用该仓库，请先沟通后再 force push。"
