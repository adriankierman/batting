# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team do
    team_city "MyText"
    team_name "MyText"
    division nil
  end
end
