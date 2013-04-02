require 'spec_helper'

describe Player do
  before(:each) do
    @valid_attributes={ "surname"=>"Rios", "given_name"=>"Armando", "position"=>"Outfield", "games"=>12, "games_started"=>0, "at_bats"=>7, "runs"=>3, "hits"=>4, "doubles"=>0, "triples"=>0, "home_runs"=>2, "rbi"=>3.0, "steals"=>0, "caught_stealing"=>0, "sacrifice_hits"=>0, "sacrifice_flies"=>0, "mistakes"=>0, "pb"=>0, "walks"=>3, "struck_out"=>2, "hit_by_pitch"=>0, "throws"=>nil, "wins"=>nil, "losses"=>nil, "saves"=>nil, "complete_games"=>nil, "shut_outs"=>nil, "era"=>nil, "innings"=>nil, "earned_runs"=>nil, "hit_batter"=>nil, "wild_pitches"=>nil, "balk"=>nil, "walked_batter"=>nil, "struck_out_batter"=>nil}
    @valid_attributes=@valid_attributes.with_indifferent_access
  end

  it "should calculate derived statistics correctly" do
    rios=Player.create(@valid_attributes)
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
      rios=Player.create(@valid_attributes.except(:rbi))
      rios.save
      rios.valid?.should be_false
  end


  it "should reject a record with no name or surname attribute" do
        rios=Player.create(@valid_attributes.except(:surname))
        rios.valid?.should be_false

        rios=Player.create(@valid_attributes.except(:given_name))
        rios.valid?.should be_false
  end

  it "should default certain attributes to zero" do
    zero_defaults=[:hit_by_pitch, :sacrifice_flies, :walks, :home_runs, :runs, :doubles, :hit_by_pitch, :sacrifice_flies, :triples, :steals]
    zero_defaults.each{|attribute_name|
      rios=Player.create(@valid_attributes.except(attribute_name))
      rios.save
      rios.send(attribute_name).should == 0
    }

  end
end
