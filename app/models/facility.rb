class Facility < ApplicationRecord
    has_many :posts, dependent: :destroy
    validates :name, presence: true, uniqueness: true, length: { minimum: 4, maximum: 30 }
    validates :address, presence: true
    validates :station, presence: true
    validates :tel, presence: true, uniqueness: true
    validates :homepage, format: /\A#{URI::regexp(%w(http https))}\z/
end
