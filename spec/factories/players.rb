# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :player do
    surname "MyText"
    team nil
    given_name "MyText"
    position "MyText"
    games 1
    games_started 1
    at_bats 1
    runs 1
    hits 1
    doubles 1
    triples 1
    home_runs 1
    rbi 1
    steals 1
    caught_stealing 1
    sacrifice_hits 1
    sacrifice_flies 1
    errors 1
    pb 1
    walks 1
    struck_out 1
    hit_by_pitch 1
  end
end
