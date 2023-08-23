require 'rails_helper'

RSpec.describe "Facilities", type: :system do
  let!(:user){ create(:user) }
  let!(:facility){ create(:facility) }
  let!(:post){ create(:post, user: user, facility: facility) }
  let!(:comment){ create(:comment, user: user, post: post)}

  describe "保育園一覧ページ" do
    before do
      visit facilities_path
    end

    it '保育園一覧が表示されていること' do
      expect(page).to have_content "北区の保育園一覧"
    end

    it '保育園一覧の各項目が表示されていること' do
      expect(page).to have_content "保育園名"
      expect(page).to have_content "住所"
      expect(page).to have_content "最寄駅"
      expect(page).to have_content "電話番号"
      expect(page).to have_content "開園時間"
      expect(page).to have_content "HP"
    end

    it '保育園一覧の各項目の内容が表示されていること' do
      expect(page).to have_content facility.name
      expect(page).to have_content facility.address
      expect(page).to have_content facility.station
      expect(page).to have_content facility.tel
      expect(page).to have_content facility.opening_hours
    end

    it 'HPリンクがアイコンとして表示されていること' do
      within ".table" do
        within ".link-icon" do
          link = find("a")
          expect(link).to have_selector("svg.bi-arrow-up-right-square") 
        end
      end
    end

    it 'HPリンクのアイコンを押下すると新しいタブでリンク先が開かれること' do
      within ".table" do
        within ".link-icon" do
          link = find("a")
          expect(link[:target]).to eq("_blank")
        end
      end
    end

    it '保育園名を押下すると保育園の詳細ページに遷移すること' do
      within "tbody tr" do
        click_on facility.name
      end
      expect(current_path).to eq facility_path(facility)
    end
  end
  describe "保育園詳細ページ" do
    context 'ログアウトしている場合' do
      before do
        visit facilities_path
        click_on facility.name
      end

      it '保育園情報の各項目が表示されていること' do
        expect(page).to have_content "住所"
        expect(page).to have_content "最寄駅"
        expect(page).to have_content "電話番号"
        expect(page).to have_content "開園時間"
        expect(page).to have_content "HPリンク"
      end

      it '保育園情報の各項目の内容が表示されていること' do
        expect(page).to have_content facility.name
        expect(page).to have_content facility.address
        expect(page).to have_content facility.station
        expect(page).to have_content facility.tel
        expect(page).to have_content facility.opening_hours
      end

      it 'HPリンクがアイコンとして表示されていること' do
        within ".table" do
          within ".link-icon" do
            link = find("a")
            expect(link).to have_selector("svg.bi-arrow-up-right-square") 
          end
        end
      end

      it 'HPリンクのアイコンを押下すると新しいタブでリンク先が開かれること' do
        within ".table" do
          within ".link-icon" do
            link = find("a")
            expect(link[:target]).to eq("_blank")
          end
        end
      end

      it '戻るボタンが表示されること' do
        expect(page).to have_content "戻る"
      end

      it '戻るボタンを押下すると1つ前のページに遷移すること' do
        click_on "戻る"
        expect(page).to have_current_path(facilities_path)
      end

      it '投稿一覧を見るボタンは表示されず、ログインすると投稿一覧が見られますと表示されていること' do
        expect(page).to have_no_content "投稿一覧を見る"
        expect(page).to have_content "ログインすると投稿一覧が見られます"
      end

      it '新規登録とログインボタンが表示されること' do
        expect(page).to have_content "新規登録がまだの方"
        expect(page).to have_content "ログインする"
      end
    end

    context 'ログインしている場合' do
      before do
        visit login_path
        fill_in "email", with: user.email
        fill_in "password", with: user.password
        within ".login_button" do
          click_on "ログイン"
        end
        visit facility_path(facility)
      end

      it '投稿一覧を見るボタンが表示されること' do
      expect(page).to have_content "投稿一覧を見る"
      end

      it '投稿一覧を見るボタンを押下すると投稿一覧ページへ遷移すること' do
        click_on "投稿一覧を見る"
        expect(current_path).to eq facility_posts_path(facility)
      end
    end
  end
end
