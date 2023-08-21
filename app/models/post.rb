class Post < ApplicationRecord
  belongs_to :user
  belongs_to :facility
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: { minimum: 3, maximum: 25}
  validates :content, presence: true, length: { minimum: 10, maximum: 500 }
end
