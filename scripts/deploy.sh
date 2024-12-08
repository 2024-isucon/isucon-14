#!/bin/bash -eux

branch_name=${branch:-main} # デフォルトは "main" ブランチ

echo "Running deploy to this server on branch '${branch_name}'"

# 対象ディレクトリへ移動
cd /path/to/your/repo || exit 1

# 指定したブランチをfetchしてpull
git fetch origin "$branch_name"
git checkout "$branch_name"
git pull origin "$branch_name"

# アプリ・ミドルウェアの再起動
sudo systemctl restart nginx
# sudo systemctl restart mariadb
# sudo systemctl restart isucondition.go

# log permission
# sudo chmod 777 /var/log/nginx /var/log/nginx/*
# sudo chmod 777 /var/log/mysql /var/log/mysql/*
