class User < ApplicationRecord
  has_secure_password
  has_one_attached :userimage

  # validates :username, presence: true
  # validates :email, presence: true
  # VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]{6,}+\z/i.freeze
  # validates :password, format: { with: VALID_PASSWORD_REGEX, message: "は半角英数を両方含む6文字以上で設定してください" }
end
