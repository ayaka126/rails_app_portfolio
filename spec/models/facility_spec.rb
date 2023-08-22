require 'rails_helper'

RSpec.describe Facility, type: :model do
  describe '新規登録' do
    context '有効な場合' do
      it 'name,address,station,tel,homepage,opening_hoursが正しく入力されていれば有効であること' do
        facility = create(:facility)
        expect(facility).to be_valid
      end
    end

    context '無効な場合' do
      it 'nameが入力されていないと登録できないこと' do
        facility = build(:facility, name: nil)
        facility.valid?
        expect(facility.errors[:name]).to include("を入力してください")
      end

      it 'nameが重複していると登録できないこと' do
        facility = create(:facility, name: 'test')
        facility2 = build(:facility, name: 'test')
        facility2.valid?
        expect(facility2.errors[:name]).to include("はすでに存在します")
      end

      it 'nameが4文字未満だと登録できないこと' do
        facility = build(:facility, name: 'abc')
        facility.valid?
        expect(facility.errors[:name]).to include("は4文字以上で入力してください")
      end

      it 'nameが31文字以上だと登録できないこと' do
        facility = build(:facility, name: 'a' * 31)
        facility.valid?
        expect(facility.errors[:name]).to include("は30文字以内で入力してください")
      end

      it 'addressが入力されていないと登録できないこと' do
        facility = build(:facility, address: nil)
        facility.valid?
        expect(facility.errors[:address]).to include("を入力してください")
      end

      it 'stationが入力されていないと登録できないこと' do
        facility = build(:facility, station: nil)
        facility.valid?
        expect(facility.errors[:station]).to include("を入力してください")
      end

      it 'telが入力されていないと登録できないこと' do
        facility = build(:facility, tel: nil)
        facility.valid?
        expect(facility.errors[:tel]).to include("を入力してください")
      end

      it 'telが重複していると登録できないこと' do
        facility = create(:facility, tel: '000-0000-0000')
        facility2 = build(:facility, tel: '000-0000-0000')
        facility2.valid?
        expect(facility2.errors[:tel]).to include("はすでに存在します")
      end

      it 'homepageが不正な値だと登録できないこと' do
        facility = build(:facility, homepage: 'aaaaaaaa')
        facility.valid?
        expect(facility.errors[:homepage]).to include("は不正な値です")
      end

      it 'opening_hoursが入力されていないと登録できないこと' do
        facility = build(:facility, opening_hours: nil)
        facility.valid?
        expect(facility.errors[:opening_hours]).to include("を入力してください")
      end
    end
  end

  describe '.search' do
    context 'キーワードが入力された場合' do
      it 'キーワードを含む施設のみが返されること' do
        facility1 = create(:facility, name: 'aaa保育園')
        facility2 = create(:facility, name: 'bbb保育園', tel: '000-1111-1111')

        results = Facility.search('aaa')

        expect(results).to include(facility1)
        expect(results).not_to include(facility2)
      end
    end

    context 'キーワードが入力されなかった場合' do
      it '全ての施設が返されること' do
        facility1 = create(:facility, name: 'aaa保育園')
        facility2 = create(:facility, name: 'bbb保育園', tel: '000-1111-1111')

        results = Facility.search('')

        expect(results).to include(facility1, facility2)
      end
    end
  end

  describe '.search_by_area' do
    it '選択したエリア名が住所に含まれる施設が返されること' do
      facility1 = create(:facility, name: 'ccc保育園', address: '北区志茂1丁目')
      facility2 = create(:facility, name: 'ddd保育園', address: '北区赤羽1丁目', tel: '000-2222-2222')

      results = Facility.search_by_area('志茂')

      expect(results).to include(facility1)
      expect(results).not_to include(facility2)
    end
  end
end
