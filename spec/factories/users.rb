FactoryBot.define do
  factory :user do
    username { "testuser" }
    email { "test@test.com" } 
    password { "testpassword123" }
    password_confirmation { "testpassword123" }
    introduction { "テスト" }
  end
end
