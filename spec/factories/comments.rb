FactoryBot.define do
  factory :comment do
    content { "testcontent"}
    association :user, factory: :user
    association :post, factory: :post
  end
end
