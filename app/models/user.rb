class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  has_many :products, dependent: :destroy

  # validates :username
  # validates :email, presence: true, uniqueness: true
  # validates :location
  # validates :emissions
end
