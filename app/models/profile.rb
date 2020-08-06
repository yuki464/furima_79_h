class Profile < ApplicationRecord
  belongs_to :user, optional: true
  validates :first_name, :family_name,           presence: true
  validates :first_name_kana, :family_name_kana, presence: true,
                                               format: {
                                               with: /\A[ァ-ヶー－]+\z/,
                                               message: "は全角カタカナで入力して下さい"
                                               }
end
