class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_many :item_images. dependent :destroy
  belongs_to :category
  belongs_to :brand

  belongs_to_active_hash :item_condition
  belongs_to_active_hash :postage_payer
  belongs_to_active_hash :prefecture_code
  belongs_to_active_hash :size
  belongs_to_active_hash :preparation_day
  belongs_to_active_hash :postage_type
  belongs_to_active_hash :trading_status

  # 必須項目のバリデーション
  validates :item_image, presence: true
  validates :name, presence: true
  validates :introduction, presence: true
  validates :category, presence: true
  validates :size, presence: true
  validates :item_condition, presence: true
  validates :postage_payer, presence: true
  validates :postage_type, presence: true
  validates :prefecture_code, presence: true
  validates :preparation_day, presence: true
  validates :price, presence: true
end
