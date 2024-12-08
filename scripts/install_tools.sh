#!/bin/bash

# インストールしたいツールのリスト
tools=("make" "git")

# 必要なパッケージリストを更新
echo "パッケージリストを更新しています..."
sudo apt update -y

# 各ツールがインストールされているか確認
for tool in "${tools[@]}"; do
    if command -v "$tool" >/dev/null 2>&1; then
        echo "$tool はすでにインストールされています。"
    else
        echo "$tool がインストールされていません。インストールを開始します..."
        # ツールをインストール
        sudo apt install -y "$tool" && echo "$tool のインストールが完了しました。" || echo "$tool のインストールに失敗しました。"
    fi
done
