# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) { |i| "email-#{i}@example.com" }
    password "password"
    password_confirmation "password"
    name "John Smith"
    highrise_access_token "an-access-token"
  end
end
