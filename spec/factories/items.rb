FactoryBot.define do
  factory :item do
    name                {Faker::Name.name}
    description         {Faker::Lorem.sentence}
    price               {1000}
    category_id         {2}
    condition_id        {2}
    shipping_burden_id  {2}
    prefecture_id       {2}
    shipping_date_id    {2}
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/star.png'), filename: 'star.png')
    end
  end
end
