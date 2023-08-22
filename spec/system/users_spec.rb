require 'rails_helper'

RSpec.describe "Users", type: :system do
  describe 'ログイン時の表示' do
    let!(:user) { create(:user) }

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
