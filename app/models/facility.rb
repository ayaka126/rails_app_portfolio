class Facility < ApplicationRecord
    acts_as_mappable lat_column_name: :latitude, lng_column_name: :longitude
    has_many :posts, dependent: :destroy
    geocoded_by :address
    after_validation :geocode
    validates :name, presence: true, uniqueness: true, length: { minimum: 4, maximum: 30 }
    validates :address, presence: true
    validates :station, presence: true
    validates :tel, presence: true, uniqueness: true
    validates :homepage, format: /\A#{URI::regexp(%w(http https))}\z/
    validates :opening_hours, presence: true

  def self.search(keyword)
    if keyword != ""
      Facility.where('name LIKE(?)', "%#{keyword}%")
    else
      Facility.all
    end
  end

  def self.search_by_area(area_name)
    Facility.where('address LIKE ?', "%#{area_name}%")
  end
end
