#!/usr/bin/env bash
# 把 prompts/ 下的分栏目文件合并成一份完整版（Markdown + Word）。
set -euo pipefail
cd "$(dirname "$0")"

out_dir="下载"
md="$out_dir/美学选题提示词-完整版.md"
mkdir -p "$out_dir"

{
  echo "# 美学账号选题 · GPT Image 提示词合集"
  echo
  for f in prompts/00-*.md prompts/0[1-7]-*.md prompts/附录-*.md; do
    echo
    # 每个文件的一级标题降为二级，其余标题依次下降一级，合并后层级统一
    # 合并后文件间的相对链接失效，改成纯文本；http 链接保留
    sed -e 's/^#/##/' "$f" | sed -E 's/\[([^]]*)\]\([^):]*\.md\)/\1/g'
    echo
  done
} > "$md"

pandoc "$md" -o "$out_dir/美学选题提示词-完整版.docx"
echo "已生成：$md 和 $out_dir/美学选题提示词-完整版.docx"
