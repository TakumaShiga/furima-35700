FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.last_name }
    email                 { Faker::Internet.free_email }
    password              {'1a' + Faker::Internet.password(min_length: 6)}
    #password              { password }
    password_confirmation { password }
    family_name           {'ああああ'}
    first_name            {'いいいい'}
    family_name_k         {'アアアア'}
    first_name_k          {'イイイイ'}
    birth_day             {'19860715'}
  end
end
