class RecyclingSpot < ApplicationRecord
  has_many :recycling_spot_tags

  validates :category, presence: true
  validates :address, presence: true
end
