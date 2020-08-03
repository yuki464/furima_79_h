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

end
