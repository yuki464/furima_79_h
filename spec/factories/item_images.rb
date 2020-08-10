FactoryBot.define do
  factory :item_images  do
    url   {File.open("#{Rails.root}/spec/fixtures/test_image.jpg")}
  end
end