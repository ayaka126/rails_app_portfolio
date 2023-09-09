require 'rails_helper'

RSpec.describe User, type: :model do
  context '有効な場合' do
    it 'username,email,password,password_confirmationが正しく入力されていれば有効であること' do
      user = create(:user)
      expect(user).to be_valid
    end
  end

  context '無効な場合' do
    it 'usernameが入力されていないと登録できないこと' do
      user = build(:user, username: nil)
      user.valid?
      expect(user.errors[:username]).to include("を入力してください")
    end

    it 'usernameが31文字以上だと登録できないこと' do
      user = build(:user, username: 'a' * 31)
      user.valid?
      expect(user.errors[:username]).to include("は30文字以内で入力してください")
    end

    it 'emailが入力されていないと登録できないこと' do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end
    
    it 'emailが不正な値だと登録できないこと' do
      user = build(:user, email: 'test@test')
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end

    it 'passwordが入力されていないと登録できないこと' do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    it 'passwordが不正な値だと登録できないこと' do
      user = build(:user, password: 'testpassword')
      user.valid?
      expect(user.errors[:password]).to include("は半角英数を両方含む6文字以上で設定してください")
    end

    it 'passwordとpassword_confirmationが違う値だと登録できないこと' do
      user = build(:user, password: 'testpass123', password_confirmation: 'testpass456')
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end

    it 'emailが重複していると登録できないこと' do
      user = create(:user, email: 'test@test.com')
      user2 = build(:user, email: 'test@test.com')
      user2.valid?
      expect(user2.errors[:email]).to include("はすでに存在します")
    end
  end
end
