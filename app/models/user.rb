class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :profile
  accepts_nested_attributes_for :profile
  has_one :sending_destination
  accepts_nested_attributes_for :sending_destination
  validates :nickname,                         presence: true, uniqueness: true
  validates :password,                         length: { in: 7..128 }
  validates :email,                             presence: true, length: { maximum: 255 },
  format: {
  with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}
end
