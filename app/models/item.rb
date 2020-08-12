class Item < ApplicationRecord
  # 必須項目のバリデーション
  validates :item_images, presence: true
  validates :name, presence: true
  validates :introduction, presence: true
  validates :category, presence: true
  # validates :size_id, presence: true
  validates :condition_id, presence: true
  validates :postagepayer_id, presence: true
  # validates :postagetype_id, presence: true
  validates :prefecture_id, presence: true
  validates :preparationday_id, presence: true
  validates :price, presence: true,numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999}


  has_many :item_images, dependent: :destroy
  accepts_nested_attributes_for :item_images, allow_destroy: true
  belongs_to :category
  belongs_to :user


  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :condition
  belongs_to_active_hash :postagepayer
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :size
  belongs_to_active_hash :preparationday
  # belongs_to_active_hash :postagetype
  # belongs_to_active_hash :tradingstatus
  def self.search(search)
    if search
      Item.where('items.name LIKE(?)  ', "%#{search}%")
    else
      Item.all
    end
  end

end
