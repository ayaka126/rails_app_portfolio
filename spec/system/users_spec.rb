require 'rails_helper'

RSpec.describe "Users", type: :system do
  describe 'ログイン時の表示' do
    let!(:user){ create(:user) }
    let!(:post){ create(:post, user: user) }

    before do
      visit login_path
      fill_in "email", with: user.email
      fill_in "password", with: user.password
      within ".login_button" do
        click_on "ログイン"
      end
    end

    it 'マイページに遷移すること' do
      expect(current_path).to eq user_path
    end
  
    it 'ヘッダーにログアウトのみ表示されていること' do
      within ".navbar" do
        expect(page).to have_content "ログアウト"
      end
    end

    it 'usernameが表示されていること' do
      expect(page).to have_content user.username
    end

    it '自己紹介文が表示されていること' do
      expect(page).to have_content user.introduction
    end

    it 'プロフィール編集とアカウント削除ボタンが表示されていること' do
      expect(page).to have_content "プロフィールを編集"
      expect(page).to have_content "アカウントを削除"
    end

    it 'プロフィール編集を押下すると編集画面へ遷移すること' do
      click_on "プロフィールを編集"
      expect(current_path).to eq edit_user_path
    end

    it 'アカウント削除を押下するとトップページへ遷移すること' do
      click_on "アカウントを削除"
      expect(current_path).to eq root_path
    end

    it '投稿一覧が表示されていること' do
      expect(page).to have_content "あなたの投稿一覧"
    end

    it '投稿一覧の各項目が表示されていること' do
      expect(page).to have_content "保育園名"
      expect(page).to have_content "タイトル"
      expect(page).to have_content "コメント"
      expect(page).to have_content "投稿日"
    end

    it '投稿一覧の各項目の内容が表示されていること' do
      expect(page).to have_content post.facility.name
      expect(page).to have_content post.title
      expect(page).to have_content "コメントを見る（0）"
      expect(page).to have_content post.created_at.strftime('%Y/%m/%d %H:%M')
    end

    it '投稿一覧の項目内の保育園名を押下すると保育園詳細ページに遷移すること' do
      within ".user-posts" do
        click_on post.facility.name
      end
      expect(current_path).to eq facility_path(post.facility)
    end

    it '投稿一覧の項目内のコメントを見るを押下すると投稿の詳細ページに遷移すること' do
      within ".user-posts" do
        click_on "コメントを見る"
      end
      expect(current_path).to eq facility_post_path(post.facility, post)
    end
  end

  describe 'ログアウト時の表示' do
    before do
      visit root_path
    end

    it 'ヘッダーにログインボタンと新規登録ボタンが表示されること' do
      within ".navbar" do
        expect(page).to have_content "ログイン"
        expect(page).to have_content "新規登録"
      end
    end

    it 'トップページにログインまたは新規登録への案内が表示されること' do
      expect(page).to have_content "ログインしていない方はこちらから"
      expect(page).to have_content "ログインする"
      expect(page).to have_content "新規登録する"
    end

    it 'ヘッダーの新規登録ボタンを押すと新規登録画面に遷移すること' do
      within ".navbar" do
        click_on "新規登録"
        expect(current_path).to eq new_user_path
      end
    end

    it 'トップページ内の新規登録するボタンを押下すると新規登録画面に遷移すること' do
      within ".top" do
        click_on "新規登録する"
        expect(current_path).to eq new_user_path
      end
    end
  end
end
