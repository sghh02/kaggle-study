# Day 2 — 決定木を「実物」で動かす

**今日のゴール**
1. Day 1 で頭の中で組み立てた決定木が、現実でも同じ形で動くのを自分の目で確認する
2. Kaggle で毎日使う道具（pandas / scikit-learn）に初めて手を触れる

🧱 = 足場（私が渡した。今日の主役ではない）　🎯 = 本筋（あなたが書く）

## 🧱 1. 道具を読み込む（import）


```python
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.tree import DecisionTreeClassifier, plot_tree

print('準備OK')
```

## 🧱 2. データを読み込んで眺める

`pd.read_csv` は Kaggle でも毎回最初に打つ呪文。今日は足場として渡すが、これは一生使う。


```python
df = pd.read_csv('../data/chat_sessions.csv')

print('形(行, 列):', df.shape)
df.head(8)
```


```python
# ざっくり傾向を見る（足場）
df.describe()
```

## ✋ 走らせる前に「予想」する

次のセルを書く前に、Day 1 のあなたの木を思い出して **予想** してみてください（ここがDay 2の主目的）。

- 機械が一番上に置く手がかりは何になりそう？（`turns` / `used_summary` / `stay_minutes` のどれ？）
- `turns` の線引きは何回あたりに来そう？
- 囮の `stay_minutes` は使われる？ 捨てられる？

予想をメモしてから、下を書いて答え合わせ。

## 🎯 3. ここが今日の本筋 — 決定木に学習させる

下のヒントだけを頼りに、**自分で** 書いてください。コピペで動く完成形は渡しません。

**やること3ステップ:**
1. 手がかり（特徴量）`X` と、本当の答え `y` に分ける
   - `X` … 手がかりの列だけ → `df[["列名", "列名", ...]]`（カッコ二重に注意）
   - `y` … 正解の列ひとつ → `df["列名"]`
2. 決定木の「箱」を作る
   - `DecisionTreeClassifier(...)` を使う。最初は木が深すぎて読めなくなるので、深さを浅く制限する引数を1つ渡すと良い（例: 深さ上限）。引数名は `max_depth`。
3. 学習させる
   - Day 1 の「`fit` で学習させる」。何を渡す？ → 入力（手がかり）と、正解。


```python
# 🎯 ここを自分で埋める（この3行は今 ... のままなので、書き換えるまで実行するとエラーになります）

X = ...   # 手がかりの列だけ
y = ...   # 本当の答えの列

clf = ...           # 決定木の箱を作る
# clf.??? (X, y)    # 学習させる一行を自分で

```

## 🧱 4. できた木を見る（答え合わせ）

上で `clf` を学習させたら、このセルを実行。木の絵が出て、PNGにも保存される。


```python
fig, ax = plt.subplots(figsize=(14, 8))
plot_tree(
    clf,
    feature_names=X.columns,
    class_names=['深まってない', '深まった'],
    filled=True,
    rounded=True,
    fontsize=10,
    ax=ax,
)
fig.savefig('day2_tree.png', dpi=120, bbox_inches='tight')
plt.show()
print('保存: notebooks/day2_tree.png')
```
