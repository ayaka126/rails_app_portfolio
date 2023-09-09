require 'rails_helper'

RSpec.describe "GuestLogin", type: :system do
  before do
    visit root_path
  end

  context 'ヘッダー内' do
    it 'ゲストログインを押下するとゲストログインできること' do
      within ".navbar" do
        click_on "ゲストログイン"
      end
      expect(page).to have_content "ゲストユーザーとしてログインしました"
    end
  end

  context 'トップページ内' do
    it 'ゲストログインで試すボタンを押下するとゲストログインできること' do
      within ".top" do
        click_on "ゲストログインで試す"
      end
      expect(page).to have_content "ゲストユーザーとしてログインしました"
    end
  end
end
