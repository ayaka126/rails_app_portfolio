require 'rails_helper'

RSpec.describe "Posts", type: :system do
  let!(:user){ create(:user) }
  let!(:facility){ create(:facility) }
  let!(:post){ create(:post, user: user, facility: facility) }
  let!(:comment){ create(:comment, user: user, post: post)}

  describe "投稿一覧ページ" do
    before do
      visit login_path
      fill_in "email", with: user.email
      fill_in "password", with: user.password
      within ".login_button" do
        click_on "ログイン"
      end
      visit facility_posts_path(post.facility)
    end

    it '保育園名が表示されていること' do
      expect(page).to have_content facility.name
    end

    it '投稿一覧の各項目が表示されていること' do
      expect(page).to have_content "タイトル"
      expect(page).to have_content "内容"
      expect(page).to have_content "詳細"
      expect(page).to have_content "投稿日"
    end

    it '投稿一覧の各項目の内容が表示されていること' do
      expect(page).to have_content post.title
      expect(page).to have_content post.content
      expect(page).to have_content "コメントを見る（1）"
      expect(page).to have_content post.created_at.strftime('%Y/%m/%d %H:%M')
    end

    it '保育園詳細へ戻るリンクが表示されていること' do
      expect(page).to have_content "保育園詳細へ戻る"
    end

    it '保育園詳細へ戻るを押下すると保育園詳細ページへ遷移すること' do
      click_on "保育園詳細へ戻る"
      expect(current_path).to eq facility_path(facility)
    end

    it '新規投稿するボタンが表示されていること' do
      expect(page).to have_content "新規投稿する"
    end

    it '新規投稿するボタンを押下すると新規投稿ページへ遷移すること' do
      click_on "新規投稿する"
      expect(current_path).to eq new_facility_post_path(facility)
    end

    it 'コメントを見るを押下するとコメントを含む投稿の詳細画面へ遷移すること' do
      click_on "コメントを見る（1）"
      expect(current_path).to eq facility_post_path(post.facility, post)
    end
  end

  describe "投稿詳細ページ" do
    before do
      visit login_path
      fill_in "email", with: user.email
      fill_in "password", with: user.password
      within ".login_button" do
        click_on "ログイン"
      end
      visit facility_post_path(post.facility, post)
    end

    it '保育園名が表示されていること' do
      expect(page).to have_content facility.name
    end

    it '投稿者のusernameと投稿日が表示されていること' do
      expect(page).to have_content post.user.username
      expect(page).to have_content post.created_at.strftime('%Y/%m/%d %H:%M')
    end

    it '投稿の削除ボタンが表示されていること' do
      within ".post-field" do
        expect(page).to have_button "削除"
      end
    end

    it '投稿の削除ボタンを押下すると投稿が削除されること' do
      within ".post-field" do
        click_on "削除"
      end
      expect(page).to have_content "投稿が削除されました"
      expect(current_path).to eq facility_posts_path(facility)
    end

    it 'コメントフィールドが表示されていること' do
      expect(page).to have_field("comment_content")
    end

    it 'コメントするボタンが表示されていること' do
      expect(page).to have_button "コメントする"
    end

    it 'コメントをしたusernameと投稿日が表示されていること' do
      expect(page).to have_content comment.user.username
      expect(page).to have_content comment.created_at.strftime('%Y/%m/%d %H:%M')
    end

    it 'コメント内容が表示されていること' do
      expect(page).to have_content comment.content
    end

    it 'コメントの削除ボタンが表示されること' do
      within ".comment-field" do
        expect(page).to have_button "削除"
      end
    end

    it 'コメントの削除ボタンを押下するとコメントが削除されること' do
      within ".comment-field" do
        click_on "削除"
      end
      expect(page).to have_content "コメントを削除しました"
      expect(page).to have_content "コメントはまだありません"
    end

    it '投稿一覧へ戻るボタンが表示されていること' do
      expect(page).to have_content "投稿一覧へ戻る"
    end

    it '投稿一覧へ戻るボタンを押下すると投稿一覧ページへ遷移すること' do
      click_on "投稿一覧へ戻る"
      expect(current_path).to eq facility_posts_path(facility)
    end
  end
end
