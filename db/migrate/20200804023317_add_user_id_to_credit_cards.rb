class AddUserIdToCreditCards < ActiveRecord::Migration[6.0]
  def change
    add_reference :credit_cards, :user_id, foreign_key: true
  end
end
