# 株式会社ゆめみ iOS エンジニアコードチェック課題

## 概要

本プロジェクトは株式会社ゆめみ（以下弊社）が、弊社に iOS エンジニアを希望する方に出す課題のベースプロジェクトです。本課題が与えられた方は、下記の概要を詳しく読んだ上で課題を取り組んでください。

## アプリ仕様

本アプリは GitHub のリポジトリーを検索するアプリです。

![動作イメージ](README_Images/app.gif)

### 環境

- IDE：Version 13.2.1 (13C100)
- Swift：Apple Swift version 5.5.2
- 開発ターゲット：iOS 15.2
- サードパーティーライブラリーの利用：オープンソースのものに限り制限しない

### 動作

1. 何かしらのキーワードを入力
2. GitHub API（`search/repositories`）でリポジトリーを検索し、結果一覧を概要（リポジトリ名）で表示
3. 特定の結果を選択したら、該当リポジトリの詳細（リポジトリ名、オーナーアイコン、プロジェクト言語、Star 数、Watcher 数、Fork 数、Issue 数）を表示

## 取り組んだ課題
#### 1.ソースの可読性向上
- 命名規約（参考：Swift API Design Guidelines）
[`参考1`](https://qiita.com/fuwamaki/items/f2df71723ab277dffc29) :Swiftの命名規則を理解する（Swift API Design Guidelines - Naming 日本語まとめ）
[`参考2`](https://www.swift.org/documentation/api-design-guidelines/#naming) :swift.org（Naming）
をみながら対策を行なった．
- ネスト
[`参考1`](https://techblog.recochoku.jp/8058) :【Swift】安全にアンラップするために 〜!（強制アンラップ）とif letとguard letと??（Nil coalescing operator）の使い分け〜
guard let ~ else {return} を使用し，if文による深いネストを極力避けた．
- インデント
対策を行なった．
- コメントの適切性
関数としてまとめた機能含め，わかりにくい動作の補足を行なった．
- スペースや改行
書き方を統一した．
- その他
処理を関数としてまとめ，Viewの動作を行う処理が長くなってしまわないよう対処した．
#### 2.ソースコードの安全性の向上
guard let ~ else {return} を使用し，以下の項目に対応した．
- 強制アンラップ
- 強制ダウンキャスト
- 不必要なIUO
- 想定外の nil の握り潰し
[`参考1`](https://techblog.recochoku.jp/8058) :【Swift】安全にアンラップするために 〜!（強制アンラップ）とif letとguard letと??（Nil coalescing operator）の使い分け〜
#### 3.バグを修正
- レイアウトエラー
stackviewの位置が定まっていなかったので修正.
- メモリリーク
クロージャによる循環参照が原因でメモリリークが発生するよう．以下の記事を参考に[weak self]追加で対処．
[`参考1`](https://tm-progapp.hatenablog.com/entry/2021/01/21/215819) : Swiftで循環参照によるメモリリークを起こしてしまった話
- パースエラー
ViewController2.swiftにて,閲覧者数を取得するキーワード"wathcer_count"がtypo.修正済みだが，APIの仕様変更により，現在このキーワードで取得できるのはスター数とのことだった．※少し調査しましたが，閲覧者数の取得方法はわかりま線でした．
#### 4.FatVC
- 本プロジェクトは ViewController が必要以上の責務を抱えており、いわゆる Fat VC 状態です。最低限の責務の切り出しをしてあげましょう。
GitAPIの処理がViewController内に記述されていたので，切り出しを試みた．※結果はshokyu-endブランチに入っています．こちらはバグがあり，正しく動作しないものとなっております．原因はAPIの処理の中にsearchViewController.tableView.reloadData()が入っており，うまくViewControllerとAPI処理を切り分けられていないことにあると思います．アドバイスいただけると幸いです．

コードチェックの課題 Issue は全て [`課題`](https://github.com/yumemi/ios-engineer-codecheck/milestone/1) Milestone がついており、難易度に応じて Label が [`初級`](https://github.com/yumemi/ios-engineer-codecheck/issues?q=is%3Aopen+is%3Aissue+label%3A初級+milestone%3A課題)、[`中級`](https://github.com/yumemi/ios-engineer-codecheck/issues?q=is%3Aopen+is%3Aissue+label%3A中級+milestone%3A課題+) と [`ボーナス`](https://github.com/yumemi/ios-engineer-codecheck/issues?q=is%3Aopen+is%3Aissue+label%3Aボーナス+milestone%3A課題+) に分けられています。課題の必須／選択は下記の表とします：

|   | 初級 | 中級 | ボーナス
|--:|:--:|:--:|:--:|
| 新卒／未経験者 | 必須 | 選択 | 選択 |
| 中途／経験者 | 必須 | 必須 | 選択 |
