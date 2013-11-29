FactoryGirl.define do
  factory :blog do
    user_id 1
    sequence(:name){|n| "blog#{n}" }
    content 'n'*500
  end
end