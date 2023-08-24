require 'rails_helper'

RSpec.describe "Top page", type: :system do
  let!(:user){ create(:user) }

  before do
    visit root_path
  end

  describe 'ヘッダー' do
    context 'ログアウトしている場合' do
      it 'HOMEへのリンクを押下するとトップページへ遷移すること' do
        click_on "HOME"
        expect(current_path).to eq root_path
      end

      it 'MENUを押下するとドロップダウンが表示されること' do
        click_on "MENU"
        expect(page).to have_content "保育園一覧"
        expect(page).to have_content "北区役所HPはこちら"
      end

      it '保育園一覧へのリンクを押下すると保育園一覧ページへ遷移すること' do
        click_on "MENU"
        click_on "保育園一覧"
        expect(current_path).to eq facilities_path
      end

      it '北区役所HPはこちらを押下すると北区役所のホームページへ遷移すること' do
        click_on "MENU"
        expect(page).to have_link("北区役所HPはこちら", href: "https://www.city.kita.tokyo.jp/k-hoiku/kosodate/hoikuen/hoikuen/moshikomi/index.html", target: "_blank")
      end

      it '検索フォームが表示されていること' do
        within ".navbar" do
          expect(page).to have_field "保育園をフリーワードで検索"
          expect(page).to have_button "検索"
        end
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
        visit root_path
      end

      it 'ドロップダウンの中にマイページへのリンクが表示されること' do
        click_on "MENU"
        expect(page).to have_content "マイページ"
      end

      it 'マイページへのリンクを押下するとマイページへ遷移すること' do
        click_on "マイページ"
        expect(current_path).to eq user_path
      end
    end
  end

  describe 'body内' do
    it 'ページのタイトルが表示されていること' do
      expect(page).to have_content "東京都北区の保育園 パパ・ママ交流スペース"
    end

    it 'ページの説明文が表示されていること' do
      expect(page).to have_content "ここは保育園在園中の方や保活中の方と気軽に交流できる場所です！"
      expect(page).to have_content "ログインして、気になる保育園のことを聞いたり、情報交換をしましょう♪"
    end

    it '検索フォームが表示されていること' do
      expect(page).to have_field "保育園を検索"
      expect(page).to have_button "検索"
    end

    it '地図が表示されていること' do
      expect(page).to have_selector "#map"
    end

    it 'エリア別検索ボタンが表示されていること' do
      expect(page).to have_link "赤羽エリア"
      expect(page).to have_link "志茂エリア"
      expect(page).to have_link "王子エリア"
      expect(page).to have_link "西が丘エリア"
      expect(page).to have_link "神谷エリア"
      expect(page).to have_link "滝野川エリア"
      expect(page).to have_link "田端エリア"
      expect(page).to have_link "浮間エリア"
      expect(page).to have_link "豊島エリア"
      expect(page).to have_link "上中里エリア"
      expect(page).to have_link "十条エリア"
      expect(page).to have_link "堀船エリア"
    end
  end
end
