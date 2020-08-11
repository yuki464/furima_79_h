require 'rails_helper'
describe Profile do
  describe '#create_profiles' do
    it "first_name、last_name、first_name_kana、last_name_kanaが存在すれば登録できること" do
      profile = build(:profile)
      expect(profile).to be_valid
    end
    it "first_nameがない場合は登録できないこと" do
      profile = build(:profile, first_name: "")
      profile.valid?
      expect(profile.errors[:first_name]).to include("を入力してください")
    end
    it "last_nameがない場合は登録できないこと" do
      profile = build(:profile, last_name: "")
      profile.valid?
      expect(profile.errors[:last_name]).to include("を入力してください")
    end
    it "first_name_kanaがない場合は登録できないこと" do
      profile = build(:profile, first_name_kana: "")
      profile.valid?
      expect(profile.errors[:first_name_kana]).to include("を入力してください")
    end
    it "first_name_kanaが全角カタカナでない場合は登録できないこと" do
      profile = build(:profile, first_name_kana: "太郎")
      profile.valid?
      expect(profile.errors[:first_name_kana]).to include("は全角カタカナで入力して下さい")
    end
    it "first_name_kanaが全角カタカナである場合は登録できること" do
      profile = build(:profile, first_name_kana: "ジロウ")
      profile.valid?
      expect(profile).to be_valid
    end
    it "last_name_kanaがない場合は登録できないこと" do
      profile = build(:profile, last_name_kana: "")
      profile.valid?
      expect(profile.errors[:last_name_kana]).to include("を入力してください")
    end
    it "last_name_kanaが全角カタカナでない場合は登録できないこと" do
      profile = build(:user, last_name_kana: "山田")
      profile.valid?
      expect(profile.errors[:last_name_kana]).to include("は全角カタカナで入力して下さい")
    end
    it "last_name_kanaが全角カタカナである場合は登録できること" do
      profile = build(:profile, last_name_kana: "スズキ")
      profile.valid?
      expect(profile).to be_valid
    end
  end
end