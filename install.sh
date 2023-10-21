#!/bin/sh

set -e

GITHUB_REPO="sota0121/dotfiles"
# *バージョン指定の柔軟性や、各リリースのURIを自動取得するために GitHub APIを利用する
LATEST_RELEASE_URL="https://api.github.com/repos/$GITHUB_REPO/releases/latest"

# 1. 必要なツールの確認
command -v curl >/dev/null 2>&1 || { echo "Error: curl is not installed"; exit 1; }
command -v tar >/dev/null 2>&1 || { echo "Error: tar is not installed"; exit 1; }

# 2. GitHubのリリースからバイナリのダウンロード
download_url() {
  curl -s $LATEST_RELEASE_URL | grep "browser_download_url.*installer-$OS-$ARCH" | cut -d '"' -f 4
}

download_binary() {
  local download_url="$1"
  echo "Downloading binary from $download_url"
  curl -LO $download_url
}

OS="$(uname -s)"
ARCH="$(uname -m)"

download_url=$(download_url)
download_binary "$download_url"

# 3. ダウンロードしたバイナリの検証や実行
# 例: tarでバイナリを解凍し、インストーラを実行する
tar -xzf installer-$OS-$ARCH
./installer

# 4. 後片付け
rm installer-$OS-$ARCH
