#!/usr/bin/env bash
# ============================================================
#  kaggle-study 環境セットアップ（ZIP/clone を落としたら これ1発）
#    使い方:  bash setup.sh
#  やること: .venv 作成 → ライブラリ一括インストール → Jupyterカーネル登録
#  ※ Mac / Linux 用。Windows は SETUP.md の手動手順を参照。
# ============================================================
set -e
cd "$(dirname "$0")"   # スクリプトのある場所＝リポジトリ直下へ

echo "[1/3] 仮想環境 .venv を作成してライブラリを入れる..."
if command -v uv >/dev/null 2>&1; then
  echo "  uv を検出（速い方を使う）"
  uv venv --python 3.13 .venv
  uv pip install --python .venv -r requirements.txt
else
  echo "  uv 無し → 標準の venv + pip を使う"
  python3 -m venv .venv
  .venv/bin/python -m pip install --upgrade pip
  .venv/bin/python -m pip install -r requirements.txt
fi

echo "[2/3] Jupyter カーネル 'kaggle-study' を登録..."
.venv/bin/python -m ipykernel install --user --name kaggle-study --display-name "Python (kaggle-study)"

echo "[3/3] 動作確認..."
.venv/bin/python -c "import pandas, sklearn, matplotlib; print('  OK  sklearn', sklearn.__version__)"

echo ""
echo "完了！ VS Code でノートを開き、右上のカーネルに 'kaggle-study' を選んで Run All。"
echo "  例: notebooks/day5_gbdt/day5_gbdt.ipynb"
