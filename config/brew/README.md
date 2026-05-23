# きれいに掃除する方法

- 調べた結果、現段階では openssh / font あたりは Homebrew で入れるしかなさそうだった。
- それ以外は、すべてアンインストールする。
- その手順を以下に記載する。

## 最新の `Brewfile` のディレクトリへ

`config/brew/RihoYoshiokaM2.local/20260523_155300_bk_Brewfile`

```shell
cd ./config/brew/RihoYoshiokaM2.local/20260523_155300_bk_Brewfile
```

## 最新の `Brewfile` をホストマシンに取り込む

```shell
brew bundle --file=Brewfile
```
これには、 `openssh` しか含まれていない。

## マシンに取り込んだ `Brewfile` には記載されていないけど、インストールバイナリとして残っているやつを全部消す

```shell
brew bundle cleanup --force
```

確認

```shell
brew leaves

# expectation:
# これだけになっていること
openssh
```
