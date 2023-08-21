FactoryBot.define do
  factory :post do
    title { "testtitle" }
    content { "testcontent" }
    association :user, factory: :user
    association :facility, factory: :facility
  end
end
