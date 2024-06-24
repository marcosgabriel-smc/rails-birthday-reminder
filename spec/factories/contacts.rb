FactoryBot.define do
  factory :contact do
    name { "Test Contact" }
    birthday { "2000-01-01" }
    association :user
  end
end
