FactoryBot.define do
  factory :user do
    email { "test@example.com" }
    password { "password" }
    telegram_id { "000000" }
  end
end
