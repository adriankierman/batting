require "rspec"
require 'baseball_data_loader'


describe "When loading test data from xml files" do

  it "should load data which can be confirmed valid" do

    loader=BaseballDataLoader.new
    loader.load()

    rios=Player.find_by_surname_and_given_name('Rios',"Armando")

    # statistics confirmed from two sources
    # http://www.baseball-reference.com/players/r/riosar01.shtml
    rios.on_base_percentage_plus_slugging.round(3).should == 2.129
    rios.batting_average.round(3).should == 0.571
    rios.rbi.should == 3
    rios.home_runs.should == 2
    rios.hits.should == 4
    rios.at_bats.should == 7
    rios.calculate_bases_on_balls.should == 3

  end
end