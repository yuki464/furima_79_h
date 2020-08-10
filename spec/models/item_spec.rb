require 'rails_helper'

describe Item do
  describe '#create' do
    it "全て入力されていればOK" do
      item = create(:item)
      expect(item).to be_valid
    end
    it "nameが空ならNG" do
      item = build(:item, name: nil)
      item.valid?
      expect(item.errors[:name]).to include("を入力してください")
    end
    it "introductionが空ならNG" do
      item = build(:item, introduction: nil)
      item.valid?
      expect(item.errors[:introduction]).to include("を入力してください")
    end
    it "priceが空ならNG" do
      item = build(:product, price: nil)
      item.valid?
      expect(item.errors[:price]).to include("を入力してください")
    end
    it "priceがinteger以外ならNG" do
      item = build(:product, price: "３００")
      item.valid?
      expect(item.errors[:price]).to include("は数値で入力してください")
    end
  #   it "itemが300円未満ならNG" do
  #     item = build(:product, price: "290")
  #     item.valid?
  #     expect(item.errors[:price]).to include("は300以上の値にしてください")
  #   end
  #   it "priceが9999999円よりも高額ならNG" do
  #     item = build(:product, price: "19999999")
  #     item.valid?
  #     expect(item.errors[:price]).to include("は9999999以下の値にしてください")
  #   end
  # end
end