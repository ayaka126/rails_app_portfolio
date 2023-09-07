## 東京都北区の保育園 パパ・ママ交流スペース
https://rails-app-portfolio-11fcb35a8b51.herokuapp.com/

北区の保育園に在園中の保護者や保活中の方と気軽に投稿・コメントを通じて交流できるアプリケーションです。  
現在地から近くの保育園を探したり、エリアで絞ったり、フリーワードで検索して気になる保育園を探すことが出来ます。  
ログインすると、保育園の内情を聞いたり、情報交換をしたり出来ます。  


![トップページ](./%E5%8C%97%E5%8C%BA%E3%81%AE%E4%BF%9D%E8%82%B2%E5%9C%92%E3%83%91%E3%83%91%E3%83%BB%E3%83%9E%E3%83%9E%E4%BA%A4%E6%B5%81%E3%82%B9%E3%83%9A%E3%83%BC%E3%82%B9.png)

### 想定ユーザー
- 保育園に通っている子どもの保護者
- 保育園を探している保護者

### 解決したい課題
- いろんな園の情報や口コミを知りたいが、子供を連れて中々見学に行けない  
- 地域にママ友などのコミュニティがなく情報がわからない  
- 保育園の送迎時間が重ならず、普段会えない保護者と話をしたい  

### 使用技術
**フロントエンド**
- HTML
- CSS
- JavaScript
- Bootstrap5

**バックエンド**
- ruby 3.1.4
- MySQL
- Ruby on Rails7.0.5

**インフラ**
- Docker
- Heroku

**テスト**
- rubocop
- Rspec

**その他**
- gitHub

### ER図
![ER図](https://github.com/ayaka126/rails_app_portfolio/assets/125426841/7d607093-fbde-4ed9-87ba-8cfa438b1ea7)

### 機能一覧
- ユーザー登録(CRUD処理)
- ログイン機能(sessionコントローラー)
- ゲストログイン(ログイン時と同じ状態を試せます)
- 保育園検索機能(gem不使用)
1) 保育園名をフリーワードで検索
2) 現在地に近い保育園を地図から検索(google map API)
3) エリア別検索(住所で判別)
- 保育園お気に入り登録機能(JavaScript使用)
- マイページ(username,userimage,introduction,お気に入り施設一覧,自分の投稿一覧が表示)
- 投稿機能(CRUD処理)
- 投稿へのコメント機能(自身のコメントは削除可能)
- 投稿・コメント時の吹き出しアイコンにhoverで各ユーザーのintroductionを表示

### 今後実装したいもの
- circleCI
- googleアカウントでのログイン・登録
- パスワードの再設定
