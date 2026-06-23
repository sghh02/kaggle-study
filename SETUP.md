# SETUP — クローンして動かすまで

`.venv`（道具の箱）は git に入れていないので、クローン後に再現する。

## 1. クローン
```bash
git clone https://github.com/sghh02/kaggle-study.git
cd kaggle-study
git switch day2-decision-tree   # 今日の作業ブランチ
```

## 2. 環境を作る（道具を入れる）

### uv がある場合（速い・おすすめ）
```bash
uv venv --python 3.13 .venv
uv pip install --python .venv -r requirements.txt
```

### uv が無い場合（標準の venv + pip）
```bash
python3 -m venv .venv
.venv/bin/pip install -r requirements.txt
```

## 3. ノートブックを開く

### A) JupyterLab をブラウザで
```bash
.venv/bin/jupyter lab
```
→ ブラウザで `notebooks/day2_decision_tree.ipynb` を開く。
→ 右上のカーネルが `.venv` を指しているか確認（無ければ手順4を先に）。

### B) VS Code で
`notebooks/day2_decision_tree.ipynb` を開き、右上の **カーネル選択**で `.venv/bin/python` を選ぶ。

## 4.（任意）カーネルを登録しておく
VS Code / Jupyter から `.venv` を選びやすくする。
```bash
.venv/bin/python -m ipykernel install --user --name kaggle-study --display-name "Python (kaggle-study)"
```

## 5. 走らせる
ノートブックを上から順に実行。
- 🧱セル（import・データ読込・描画）はそのまま実行でOK。
- 🎯セル（`fit` の部分）は**自分で書く**。書くまでは実行するとエラーになる（わざと）。
- 最後の描画セルで木の絵が出て、`notebooks/day2_tree.png` に保存される。

詳しい「今日やること」は [notebooks/DAY2.md](notebooks/DAY2.md)。
