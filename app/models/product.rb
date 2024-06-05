class Product < ApplicationRecord
  belongs_to :user
  acts_as_ordered_taggable

  validates :name, presence: true
end
