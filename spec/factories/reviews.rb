# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :review do
    reviewer "MyString"
    content "MyText"
    place nil
  end
end
