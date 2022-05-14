# Fork して共同開発

### 1. Fork する

[moyomogi/flutter_testing](https://github.com/moyomogi/flutter_testing) にある Fork ボタンを押すだけ。


## 2. master ブランチをローカルブランチに反映する

### 2-2. Pull する

初回のみ実行すればよい。

```sh
git remote add upstream https://github.com/moyomogi/flutter_testing
```

こちらは毎回実行。

```sh
# master に移動。
git checkout master
# remotes/upstream/master -> master と更新。
git pull upstream master
# remotes/origin/master -> master と更新 (任意)。
git pull origin master

# YOUR_BRANCH に移動。
# (YOUR_BRANCH はあなたの作業ブランチ名に置き換えてください。)
git checkout YOUR_BRANCH
# master -> YOUR_BRANCH と更新。
# git rebase は、やめてましょう
git merge master
git push origin YOUR_BRANCH
```

### 2-3. Push する

```sh
git checkout YOUR_BRANCH
git add --all
git commit -m "Update"
git push origin YOUR_BRANCH
```

## 3. ローカルで master に merge する

### 3-1. なぜローカルで merge するのか

conflict は、GitHub 上でも直せますが、Flutter 開発ではコードが入り組む事が多く、  
入り組んでいるときは、ローカルでシンタックスハイライト付きで merge した方が早いです。  
あと、F5 でデバッグもできるね。

### 3-2. 具体的方法 (個人開発 (fork でない) の場合)
```sh
# master ブランチを最新状態に更新
git pull origin master

git checkout master
git merge YOUR_BRANCH
```

## 参考文献

- [マンガでわかる Git 12 話「本家リポジトリに追従する方法」](https://next.rikunabi.com/journal/20180322_t12_iq/)
- [Github で Fork してから Pull Request をするまでの流れ](http://kik.xii.jp/archives/179)
