class RecyclingSpot < ApplicationRecord
  acts_as_ordered_taggable

  validates :category, presence: true
  validates :address, presence: true
end
