#!/bin/bash

set -euxo pipefail  # エラーハンドリングを強化

# 定数の定義
SOURCE_PATH="./conf/nginx/nginx.conf"
DEST_PATH="/etc/nginx/nginx.conf"

# コピー前に存在確認
if [[ ! -f $SOURCE_PATH ]]; then
  echo "Error: Source file '$SOURCE_PATH' does not exist." >&2
  exit 1
fi

# コピー操作
echo "Copying $SOURCE_PATH to $DEST_PATH..."
sudo cp "$SOURCE_PATH" "$DEST_PATH"

# 権限の確認
echo "Ensuring appropriate permissions for $DEST_PATH..."
sudo chmod 644 "$DEST_PATH"

# 設定ファイルのテスト
echo "Testing Nginx configuration..."
sudo nginx -t

# Nginxの再起動
echo "Restarting Nginx..."
sudo systemctl restart nginx

echo "Nginx configuration updated successfully!"
