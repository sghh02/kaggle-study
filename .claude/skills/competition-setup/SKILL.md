---
name: competition-setup
description: Kaggle 等のコンテストを新しく始めるときの「環境構築」を一気に整えるスキル。competition/<slug>/ のディレクトリ・データ取得（kaggle CLI）・.gitignore・本番モードの作業ノートブック（空）まで用意する。ユーザーが「このコンペやりたい」「コンペ環境を作って」「<コンペ名>をセットアップ」「Kaggle始める」などと言ったときに使う。
---

# コンテスト環境構築スキル

新しいコンペに挑むための **足場（環境）だけ** を整えるスキル。
解く中身（特徴量・モデル・提出物）は作らない —— `competition/` は**本番モード**であり、
コードを書く・回すのは学習者本人（`competition/CLAUDE.md` 参照）。このスキルが用意するのは器だけ。

## 大原則
- **解答コードは一切書かない。** 用意するのは器（ディレクトリ・データ・空のノート）まで。
- **既存の認証を再利用する。** アカウント作成やトークン再発行を学習者に無駄にやらせない。
  `~/.kaggle/access_token` か `~/.kaggle/kaggle.json` が既にあれば、まずそれで試す。
- **絶対パスで扱う。** このリポジトリの作業ディレクトリは状況で変わるため（`<repo>` = リポジトリのルート）。

## 手順

### 0. コンペを特定する
- 学習者に **コンペの slug** を聞く（例: `titanic` / `house-prices-advanced-regression-techniques` / `spaceship-titanic`）。
  Kaggle の URL `https://www.kaggle.com/competitions/<slug>` の `<slug>` 部分。
- ついでに **評価指標**（accuracy / RMSE / AUC 等）と **回帰か分類か** も確認（ノートの目標欄に書くため）。

### 1. 道具と認証を確認（足りなければ用意）
- kaggle CLI があるか：`<repo>/.venv/bin/kaggle --version`
  - 無ければ：`uv pip install --python <repo>/.venv/bin/python kaggle` で入れ、`requirements.txt` にも追記。
- 認証が通るか：`<repo>/.venv/bin/kaggle competitions list`（一覧が返れば OK）。
  - `access_token` も `kaggle.json` も無く認証エラーになるとき**だけ**、ここは学習者の作業：
    1. kaggle.com にログイン → 右上 Settings → API → **Create New Token**（`kaggle.json` がDL）
    2. `mkdir -p ~/.kaggle && mv ~/Downloads/kaggle.json ~/.kaggle/ && chmod 600 ~/.kaggle/kaggle.json`
  - 別プロジェクトで認証済みのことが多い。**まず既存を試してから**学習者に頼む。

### 2. コンペ参加を確認
- `<repo>/.venv/bin/kaggle competitions files -c <slug>` がファイル一覧を返せば参加済み。
- 403 等で弾かれたら、**学習者がブラウザで参加**：`https://www.kaggle.com/competitions/<slug>` →「Join Competition」→規約同意。

### 3. ディレクトリを作る
```
mkdir -p <repo>/competition/<slug>/data <repo>/competition/<slug>/submissions
touch <repo>/competition/<slug>/submissions/.gitkeep
```

### 4. データを取得
```
<repo>/.venv/bin/kaggle competitions download -c <slug> -p <repo>/competition/<slug>/data
cd <repo>/competition/<slug>/data && unzip -o '*.zip' >/dev/null 2>&1; rm -f *.zip
```
- 取得後、`train` / `test` の行数・列を確認し、**test に正解列（予測対象）が無い**ことを学習者に見せる（本番構造の腹落ち）。

### 5. .gitignore を確認
- ルート `.gitignore` に次のワイルドカードがあるか確認（無ければ足す）。あれば新コンペも自動でカバー済み：
  ```
  competition/*/data/
  *.zip
  submission.csv
  competition/*/submissions/*.csv
  ```

### 6. 本番モードの作業ノートを作る（空＝学習者が全部書く）
- `<repo>/competition/<slug>/<slug>.ipynb` を **nbformat** で生成。**解答コードは入れない。** 入れるのは次だけ：
  - タイトル＋**本番モードの注記**（コードは学習者が書く/回す、Claude は伴走のみ）
  - 現在地（未提出ならそう書く）と目標、評価指標
  - 本番の流れ図（train で学習 → test を予測 → submission.csv → kaggle submit → リーダーボード）
  - データのパスと提出フォーマット（列名 / `index=False`）
  - 作業の節見出し（読み込み・EDA / 前処理 / モデル＋手元CV / test予測→submission / 提出）と、
    各節に **✋予想** の一言、そして**空のコードセル**
- 雛形は `competition/titanic/titanic.ipynb`。同じ作りで slug・目標・指標だけ差し替える。

### 7. 引き継ぐ
- できたツリーを見せ、「ここから本番モード：コードは全部自分で。詰まったら聞いて／結果を見せて」と一言で渡す。
- 最初のベースライン提出（例: `sample_submission.csv` をそのまま提出して提出パイプラインを一度通す）は
  **やり方だけ案内**し、提出は学習者にやらせる（自分で回せない事情があるときだけ代行）。

## 参考
- 実例一式は `competition/titanic/`（このスキルで作る理想形）。
- 本番モードの定義は `competition/CLAUDE.md`。
