FactoryBot.define do
  factory :facility do
    name { "testfacility" }
    address { "北区志茂1-1-1" }
    station { "志茂駅 徒歩5分" }
    tel { "000-0000-0000" }
    homepage { "http:test/test" }
    opening_hours { "7:00〜19:00" }
  end
end
