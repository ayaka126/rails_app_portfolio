require 'rails_helper'

RSpec.describe "Posts", type: :system do
  let!(:user){ create(:user) }
  let!(:facility){ create(:facility) }
  let!(:post){ create(:post, user: user, facility: facility) }
  let!(:comment){ create(:comment, user: user, post: post)}

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

  it '施設一覧へ戻るリンクが表示されていること' do
    expect(page).to have_content "施設一覧へ戻る"
  end

  it '施設一覧へ戻るを押下すると施設一覧ページへ遷移すること' do
    click_on "施設一覧へ戻る"
    expect(current_path).to eq facilities_path
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
