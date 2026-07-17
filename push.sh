#!/bin/bash
# ĐẨY BẢN MỚI LÊN GITHUB PAGES — dùng file này thay vì gõ tay từng lệnh.
#
# VÌ SAO PHẢI CÓ: GitHub Pages trả Cache-Control: max-age=600 cho .html -> 10 phút sau khi
# push, máy vẫn dùng bản 13MB cũ trong bộ nhớ đệm. Trước đây phải bơm ?v=N bằng tay.
# Nay index.html đọc v.txt để tự biết có bản mới -> NHƯNG chỉ đúng nếu v.txt được cập nhật
# MỖI lần push. Quên cập nhật v.txt = người chơi kẹt bản cũ mà không ai biết.
# Script này lo luôn khâu đó, khỏi phụ thuộc trí nhớ.
#
# Dùng:  bash push.sh "nội dung commit"
set -e
cd "$(dirname "$0")"

NGUON="/c/Users/Administrator/Downloads/dau-adventure.html"
[ -f "$NGUON" ] || { echo "!! không thấy $NGUON"; exit 1; }

cp "$NGUON" dau-adventure.html
date -u +"%Y%m%d-%H%M%S" > v.txt          # số hiệu build: giờ UTC, luôn tăng
echo "v.txt = $(cat v.txt)"

git add -A
git commit -q -m "${1:-cập nhật game}" -m "Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>"
git push -q origin main
echo "=== ĐÃ PUSH === $(git log --oneline -1)"
echo "Mở: https://sleepman305.github.io/dauadvanture/   (không cần ?v= nữa)"
