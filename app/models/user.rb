class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  has_many :products, dependent: :destroy

  # validates :username, presence: true, uniqueness: true
  # validates :email, presence: true, uniqueness: true
  # validates :location, presence: true
  # validates :emissions, presence: true
end
