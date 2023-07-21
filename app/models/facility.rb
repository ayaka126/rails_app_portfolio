class Facility < ApplicationRecord
    has_many :posts, dependent: :destroy
    geocoded_by :address
    after_validation :geocode
    validates :name, presence: true, uniqueness: true, length: { minimum: 4, maximum: 30 }
    validates :address, presence: true
    validates :station, presence: true
    validates :tel, presence: true, uniqueness: true
    validates :homepage, format: /\A#{URI::regexp(%w(http https))}\z/

  def self.search(keyword)
    if keyword != ""
      Facility.where('name LIKE(?)', "%#{keyword}%")
    else
      Facility.all
    end
  end
end
