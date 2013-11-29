FactoryGirl.define do
  factory :product do
    sequence(:name){|n| "prodcut#{n}" }
    price "10"
    description "辣椒，又叫番椒、海椒、辣子、辣角、秦椒等，是一种茄科辣椒属植物。"
    image File.open(File.join(Rails.root, '/spec/support/test_images/3lian_com_005.jpg'))
  end
end
