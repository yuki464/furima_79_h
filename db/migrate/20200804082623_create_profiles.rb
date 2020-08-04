class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :family_name
      t.string :first_name_kana
      t.string :family_name_kana
      t.date :birth_year
      t.date :birth_month
      t.date :birth_day
      t.text :introduction
      t.string :avatar
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
