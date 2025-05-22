# git-go-assist

git-go-assist は Go 製の CLI ツールです。`git` と `gh` のよく使う操作を自動化することを目的としています。

## セットアップ

まず依存関係を取得します。

```bash
make tidy
```

## ビルド

以下のコマンドで `bin/git-go-assist` が生成されます。

```bash
make build
```

## テスト

```bash
make test
```

## 静的解析

```bash
make vet
make lint
```

## 一括実行

CI で実行しているチェックは次でまとめて実行できます。

```bash
make ci
```

## ライセンス

MIT License
