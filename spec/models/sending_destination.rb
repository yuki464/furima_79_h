require 'rails_helper'
describe SendingDestination do
  describe '#create_address' do
    it "post_code、preficture_code、city、house_number、building_name、phone_numberが存在すれば登録できること" do
      sending_destination = build(:sending_destination)
      expect(address).to be_valid
    end
    it "post_codeがない場合は登録できないこと" do
      sending_destination = build(:sending_destination, post_code: "")
      sending_destination.valid?
      expect(sending_destination.errors[:post_code]).to include("を入力してください")
    end
    it "post_codeが7桁未満の場合は登録できないこと" do
      sending_destination = build(:sending_destination, post_code: "123456")
      sending_destination.valid?
      expect(sending_destination.errors[:post_code]).to include("はハイフンなしで、半角数字で7桁入力して下さい")
    end
    it "post_codeが8桁以上の場合は登録できないこと" do
      sending_destination = build(:sending_destination, post_code: "12345678")
      sending_destination.valid?
      expect(sending_destination.errors[:post_code]).to include("はハイフンなしで、半角数字で7桁入力して下さい")
    end
    it "post_codeが7桁の場合は登録できること" do
      sending_destination = build(:sending_destination, post_code: "8000022")
      expect(sending_destination).to be_valid
    end
    it "post_codeが半角数字でない場合は登録できないこと" do
      sending_destination = build(:sending_destination, post_code: "１２３４５６７")
      sending_destination.valid?
      expect(sending_destination.errors[:post_code]).to include("はハイフンなしで、半角数字で7桁入力して下さい")
    end
    it "post_codeが半角数字である場合は登録できること" do
      sending_destination = build(:sending_destination, post_code: "8000022")
      expect(sending_destination).to be_valid
    end
    it "preficture-codeがない場合は登録できないこと" do
      sending_destination = build(:sending_destination, preficture_code: "")
      sending_destination.valid?
      expect(sending_destination.errors[:preficture_code]).to include("を入力してください")
    end
    it "preficture_codeが含まれているpreficture_codeは登録できること" do
      sending_destination = build(:sending_destination, preficture_code: "東京都")
      expect(sending_destination).to be_valid
    end
    it "cityがない場合は登録できないこと" do
      sending_destination = build(:sending_destination, city: "")
      sending_destination.valid?
      expect(sending_destination.errors[:city]).to include("を入力してください")
    end
    it "house_numberがない場合は登録できないこと" do
      sending_destination = build(:sending_destination, house_number: "")
      sending_destination.valid?
      expect(sending_destination.errors[:house_number]).to include("を入力してください")
    end
    it "building_nameがなくても登録できること" do
      sending_destination = build(:sending_destination, building_name: "")
      expect(sending_destination).to be_valid
    end
    it "phone_numberがなくても登録できること" do
      sending_destination = build(:sending_destination, phone_number: "")
      expect(sending_destination).to be_valid
    end
  end
end