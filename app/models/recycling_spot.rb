class RecyclingSpot < ApplicationRecord
  validates :category, presence: true
  validates :address, presence: true
end
