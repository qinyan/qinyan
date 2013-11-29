FactoryGirl.define do
  factory :user do
    sequence(:name){|n| "user#{n}" }
    gender 'F'
    logo File.open(File.join(Rails.root, '/spec/support/test_images/3lian_com_005.jpg'))
    sequence(:email) { |n| "test#{n}@163.com" }
    password '123456'
  end
end