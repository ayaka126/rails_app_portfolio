class User < ApplicationRecord
  has_one_attached :userimage
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_secure_password

  validates :username, presence: true, length: { minimum: 1, maximum: 30 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]{6,}+\z/i.freeze
  validates :password, confirmation: true, format: { with: VALID_PASSWORD_REGEX, message: "は半角英数を両方含む6文字以上で設定してください" }, on: :create
end
