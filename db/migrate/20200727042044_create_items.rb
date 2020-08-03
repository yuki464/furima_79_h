class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :introduction, null: false
      t.integer :price, null: false
      t.bigint :brand
      t.integer :item_condition, null: false, foreign_key: true  #active_hashを使用
      t.integer :postage_payer, null: false, foreign_key: true  #active_hashを使用
      t.integer :prefecture_code, null: false  #active_hashを使用
      t.integer :size, null: false, foreign_key: true  #active_hashを使用
      t.integer :preparation_day, null: false, foreign_key: true  #active_hashを使用
      t.integer :postage_type, null: false, foreign_key: true  #active_hashを使用
      # t.references :item_image, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.integer :trading_status, null: false  #active_hashを使用


      t.timestamp :deal_closed_date
      t.timestamps
    end
  end
end
