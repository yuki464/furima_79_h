FactoryBot.define do
  factory :item do
    id                 {1}
    name            {"車"}
    introduction    {"自転車よ"}
    price             {300}
    brand         {""}
    condition_id      {1}
    postagepayer_id   {2}
    prefecture_id     {2}
    preparationday_id  {1}
    category_id      {350}
    # buyer_id         {1}
    trait :invalid do
      name {""}
    end
    # after(:build) do |item|
    #   item.images << build(:item_images, item: item)
    # end
    user_id {1}
  end
end