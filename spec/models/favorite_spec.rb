require 'rails_helper'

RSpec.describe Favorite, type: :model do
  let!(:user) { create(:user) }
  let!(:facility) { create(:facility) }
  let!(:favorite) { build(:favorite) }

  it "1人のユーザーが保育園に1回お気に入り登録できること" do
    expect(favorite).to be_valid
  end

  it "1人のユーザーが同じ保育園に重複してお気に入り登録できないこと" do
    Favorite.create(user: user, facility: facility)
    duplicate_favorite = Favorite.new(user: user, facility: facility)
    expect(duplicate_favorite).not_to be_valid
  end
end
