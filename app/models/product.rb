class Product < ApplicationRecord
  belongs_to :user
  has_many :product_tags

  validates :name, presence: true, uniqueness: true
end
