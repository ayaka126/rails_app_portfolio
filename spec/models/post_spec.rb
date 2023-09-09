require 'rails_helper'

RSpec.describe Post, type: :model do
  describe '新規投稿' do
    context '有効な場合' do
      it 'title,contentが正しく入力されていれば有効であること' do
        post = create(:post)
        expect(post).to be_valid
      end
    end

    context '無効な場合' do
      it 'titleが入力されていないと登録できないこと' do
        post = build(:post, title: nil)
        post.valid?
        expect(post.errors[:title]).to include("を入力してください")
      end

      it 'titleが3文字未満だと登録できないこと' do
        post = build(:post, title: 'aa')
        post.valid?
        expect(post.errors[:title]).to include("は3文字以上で入力してください")
      end

      it 'titleが26文字以上だと登録できないこと' do
        post = build(:post, title: 'a' * 26)
        post.valid?
        expect(post.errors[:title]).to include("は25文字以内で入力してください")
      end

      it 'contentが入力されていないと登録できないこと' do
        post = build(:post, content: nil)
        post.valid?
        expect(post.errors[:content]).to include("を入力してください")
      end

      it 'contentが10文字未満だと登録できないこと' do
        post = build(:post, content: 'a' * 9)
        post.valid?
        expect(post.errors[:content]).to include("は10文字以上で入力してください")
      end

      it 'contentが501文字以上だと登録できないこと' do
        post = build(:post, content: 'a' * 501)
        post.valid?
        expect(post.errors[:content]).to include("は500文字以内で入力してください")
      end
    end
  end
end
