require 'spec_helper'

describe Player do
  it "should calculate derived statistics correctly" do
    rios=Player.create(    { "surname"=>"Rios", "given_name"=>"Armando", "position"=>"Outfield", "games"=>12, "games_started"=>0, "at_bats"=>7, "runs"=>3, "hits"=>4, "doubles"=>0, "triples"=>0, "home_runs"=>2, "rbi"=>3.0, "steals"=>0, "caught_stealing"=>0, "sacrifice_hits"=>0, "sacrifice_flies"=>0, "mistakes"=>0, "pb"=>0, "walks"=>3, "struck_out"=>2, "hit_by_pitch"=>0, "throws"=>nil, "wins"=>nil, "losses"=>nil, "saves"=>nil, "complete_games"=>nil, "shut_outs"=>nil, "era"=>nil, "innings"=>nil, "earned_runs"=>nil, "hit_batter"=>nil, "wild_pitches"=>nil, "balk"=>nil, "walked_batter"=>nil, "struck_out_batter"=>nil}
    )
    rios.save
    rios.on_base_percentage_plus_slugging.round(3).should == 2.129
    rios.batting_average.round(3).should == 0.571
    rios.rbi.should == 3
    rios.home_runs.should == 2
    rios.hits.should == 4
    rios.at_bats.should == 7
    rios.calculate_bases_on_balls.should == 3
  end

  it "should reject a record with no rbi attribute" do
      rios=Player.create(    { "surname"=>"Rios", "given_name"=>"Armando", "position"=>"Outfield", "games"=>12, "games_started"=>0, "at_bats"=>7, "runs"=>3, "hits"=>4, "doubles"=>0, "triples"=>0, "home_runs"=>2, "steals"=>0, "caught_stealing"=>0, "sacrifice_hits"=>0, "sacrifice_flies"=>0, "mistakes"=>0, "pb"=>0, "walks"=>3, "struck_out"=>2, "hit_by_pitch"=>0, "throws"=>nil, "wins"=>nil, "losses"=>nil, "saves"=>nil, "complete_games"=>nil, "shut_outs"=>nil, "era"=>nil, "innings"=>nil, "earned_runs"=>nil, "hit_batter"=>nil, "wild_pitches"=>nil, "balk"=>nil, "walked_batter"=>nil, "struck_out_batter"=>nil}
      )
      rios.save
      rios.valid?.should be_false
    end
end
