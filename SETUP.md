# SETUP — ダウンロード/クローンして動かすまで

`.venv`（道具の箱）は **git に入れていない**。
理由: venv は数百MBあり、中身は **このOS・CPU専用にコンパイルされたバイナリ**なので、
他マシンに持っていっても動かない（`node_modules` / `.dart_tool` をコミットしないのと同じ）。
代わりに「**何を入れるか**」のリスト `requirements.txt` をコミットしてあり、各マシンでそこから再現する。

---

## いちばん簡単：1コマンド（Mac / Linux）

ZIP を解凍 or `git clone` したフォルダの中で:

```bash
bash setup.sh
```

これだけで **「.venv 作成 → ライブラリ一括インストール → Jupyterカーネル登録 → 動作確認」** まで全部やる。
終わったら VS Code でノートを開き、右上のカーネルに **`kaggle-study`** を選んで **Run All**。

---

## 手動でやる場合

### Mac / Linux
```bash
python3 -m venv .venv
.venv/bin/python -m pip install -r requirements.txt
.venv/bin/python -m ipykernel install --user --name kaggle-study --display-name "Python (kaggle-study)"
```

### Windows（PowerShell）
```powershell
python -m venv .venv
.venv\Scripts\python -m pip install -r requirements.txt
.venv\Scripts\python -m ipykernel install --user --name kaggle-study --display-name "Python (kaggle-study)"
```

### uv がある場合（速い）
```bash
uv venv --python 3.13 .venv
uv pip install --python .venv -r requirements.txt
```

---

## ノートの場所（日付ごとのフォルダ）

| 日 | ノート | テーマ |
|---|---|---|
| Day 2 | `notebooks/day2_decision_tree/day2_decision_tree.ipynb` | 決定木を実物で動かす |
| Day 4 | `notebooks/day4_random_forest/day4_random_forest.ipynb` | ランダムフォレスト |
| Day 5 | `notebooks/day5_gbdt/day5_gbdt.ipynb` | GBDT（勾配ブースティング） |

各ノートは**上から順に実行**:
- 🧱セル（import・データ読込・描画）は **そのまま実行でOK**
- 🎯セル（モデルを建てる部分）は **自分で書く**（書くまで実行するとエラーになる。わざと）

困ったら「今どの Python で動いてる？」を確認:
```python
import sys; print(sys.executable)   # → …/kaggle-study/.venv/bin/python なら正解
```
