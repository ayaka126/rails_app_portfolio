FactoryBot.define do
  factory :favorite do
    association :user, factory: :user
    association :facility, factory: :facility
  end
end
