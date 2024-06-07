class RecyclingSpot < ApplicationRecord
  acts_as_ordered_taggable

  validates :category, presence: true
  validates :address, presence: true

  geocoded_by :address
  after_validation :geocode, if: :address_changed?
end
