# AGENTS.md

> **このファイルは OpenAI Codex‑1 エージェント向けの開発ガイドです。**
>
> リポジトリ全体（より深い階層にある AGENTS.md が優先）に適用されます。

## 1. プロジェクト概要

このレポジトリは Go 製の CLI ツール **git‑go‑assist** を格納しています。`git` と `gh` の高頻度オペレーションを、人間の代わりに安全かつ高速に実行することが目的です。

## 2. コードスタイル

* すべての Go ファイルは `go fmt ./...` と `goimports -w` で整形してください。
* `golangci-lint run` がエラー無しで完了することが必須です。
* [Effective Go](https://go.dev/doc/effective_go) の命名規約を尊重し、エクスポート識別子はパスカルケースとします。
* 1 ファイルの関数は 40 行以内、単一責務を保持してください。
* `panic` の使用は CLI エントリーポイント (`cmd/*`) に限定し、ライブラリ層では `error` を返却してください。

## 3. コミット & PR ルール

* [Conventional Commits](https://www.conventionalcommits.org/) に従い、例: `feat: add interactive stash`。
* PR タイトルは `<type>: <imperative summary>` (最大 72 文字)。
* PR 本文には以下のセクションを含めてください:

  * **Summary** – 変更の目的／背景
  * **Test Plan** – 動作確認手順
  * **Docs** – ユーザ向けドキュメントを変更した場合の参照先
* **main** ブランチへ直接 push してはいけません。必ずブランチを切り PR を作成してください。

## 4. テスト & 検証

以下コマンドを順に実行し、全て成功してから PR を作成してください。

```bash
make tidy    # go mod tidy + goimports
make test    # go test ./...
make vet     # go vet ./...
make lint    # golangci-lint run
```

テストカバレッジは常に **80% 以上** を維持してください。

## 5. ビルド & リリース

* **Go 1.22** をターゲットにします。
* `make build` で `bin/git-go-assist` を生成します。
* タグは Semantic Versioning: `vMAJOR.MINOR.PATCH`。
* GitHub Actions `release.yml` がクロスコンパイルバイナリを生成し、リリースへ添付します。

## 6. 依存関係 & セキュリティ

* CI で `go mod vendor` を実行し、依存を vendor 配下へ固定。
* 依存を更新した際は `govulncheck ./...` を実行し、脆弱性ゼロを確認してください。
* cgo をデフォルトで呼び出す依存追加は禁止です。

## 7. エージェント特記事項

* Git 操作は **go‑git** と **go‑gh** を優先使用し、どうしても不足する場合のみ `git`/`gh` のサブプロセスを呼び出してください。
* `.pre-commit-config.yaml` が存在する場合、全フックを通過させてください。
* ユーザーの明示指示が本ファイルと衝突する場合は、**ユーザー指示を優先**してください。

## 8. プログラマティックチェック

`make ci` は全必須チェックを連鎖実行します。パッチ確定前に必ず:

```bash
make ci
```

を実行し成功させてください。

---

*より深い階層の AGENTS.md が本ファイルに優先し、直接の prompt 指示が最優先であることを忘れないでください。*
