# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :blogpost do
    title "MyString"
    tags "MyString"
    content "MyText"
  end
end
