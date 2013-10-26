# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
    factory :user do
    sequence(:name) { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "password"
    password_confirmation "password"
    #role_ids "2"
    
  end
end
