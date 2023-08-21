require 'rails_helper'

RSpec.describe Comment, type: :model do
  context '有効な場合' do
    it 'contentが正しく入力されていれば登録できること' do
      comment = build(:comment)
      expect(comment).to be_valid
    end
  end

  context '無効な場合' do
    it 'contentが入力されていないと登録できないこと' do
      comment = build(:comment, content: nil)
      comment.valid?
      expect(comment.errors[:content]).to include("を入力してください")
    end

    it 'contentが2文字未満だと登録できないこと' do
      comment = build(:comment, content: 'a' * 1)
      comment.valid?
      expect(comment.errors[:content]).to include("は2文字以上で入力してください")
    end

    it 'contentが501文字以上だと登録できないこと' do
      comment = build(:comment, content: 'a' * 501)
      comment.valid?
      expect(comment.errors[:content]).to include("は500文字以内で入力してください")
    end
  end
end
