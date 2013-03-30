class Player < ActiveRecord::Base
  belongs_to :team
  attr_accessible :throws, :wins, :losses, :saves, :complete_games, :shut_outs, :era, :innings, :earned_runs, :hit_batter, :wild_pitches, :balk, :walked_batter, :struck_out_batter, :at_bats, :caught_stealing, :doubles, :mistakes, :games, :games_started, :given_name, :hit_by_pitch, :hits, :home_runs, :pb, :position, :rbi, :runs, :sacrifice_flies, :sacrifice_hits, :steals, :struck_out, :surname, :triples, :walks

  before_validation :apply_default_values
  after_validation :calculate_derived_statistics

  def apply_default_values
    self.hit_by_pitch ||= 0
    self.sacrifice_flies ||= 0
    self.walks ||= 0
    self.home_runs ||= 0
    self.runs ||= 0
    self.doubles ||= 0
    self.hit_by_pitch ||= 0
    self.sacrifice_flies ||= 0
    self.triples ||= 0
    self.steals ||= 0
    true
  end

  # required - must be integer - cannot be blank
  validates :hits,
            :at_bats,
            :numericality => { :only_integer => true, :greater_than => 0 }, :allow_blank=>false

  # required - must be numeric (float ok)
  validates :rbi,
            :numericality => true, :allow_blank=>false

  # required - must be present, any string
  validates :given_name,
            :surname,
            :presence=>true

  # optional - must be numeric (float ok)
  validates :era,
            :pb,
            :rbi,
            :numericality => true, :allow_blank=>true



  # optional - must be integer (no floats)
  validates :wins,
            :losses,
            :saves,
            :complete_games,
            :shut_outs,
            :balk,
            :caught_stealing,
            :doubles,
            :mistakes,
            :games,
            :games_started,
            :sacrifice_hits,
            :struck_out,
            :triples,
            :numericality => { :only_integer => true }, :allow_blank=>true



  # required - defaults to zero if missing
  validates :runs,
            :hit_by_pitch,
            :sacrifice_flies,
            :walks,
            :home_runs,
            :doubles,
            :hit_by_pitch,
            :sacrifice_flies,
            :triples,
            :steals,
            :walks,
            :numericality => { :only_integer => true }, :allow_blank=>true



  def calculate_derived_statistics
    if (self.errors.count<1)
      self.batting_average=calculate_batting_average()
      self.on_base_percentage_plus_slugging=calculate_on_base_percentage_plus_slugging()
    end
    true
  end


  def calculate_batting_average
    avg=(hits.to_f)/(at_bats.to_f)
    avg=0 if avg.nan?
    return avg
  end

  def calculate_on_base_percentage_plus_slugging
    return (self.calculate_on_base_percentage+self.calculate_slugging_percentage)
  end


  #For example, if Shawn Green has 619 at-bats, 184 hits, 72 bases on balls, 5 times hit by pitch
  # and 5 sacrifice flies, his on-base percentage is .372 ((184+72+5)/(619+72+5+5)).
  def calculate_on_base_percentage
    #if (hits.nil? || walks.nil? || hit_by_pitch.nil? || at_bats.nil? || hit_by_pitch.nil? || sacrifice_flies.nil?)
    #  pp self.attributes
    #end
    return (self.hits.to_f+self.calculate_bases_on_balls+self.hit_by_pitch.to_f).to_f/(self.at_bats.to_f+self.calculate_bases_on_balls+self.hit_by_pitch.to_f+self.sacrifice_flies.to_f).to_f
  end

  def calculate_bases_on_balls
     return self.walks.to_f
  end

  # total bases / at bats
  def calculate_slugging_percentage
    return (self.bases().to_f)/(at_bats.to_f)
  end

  #total bases refers to the number of bases a player has gained with hits, i.e., the sum of his hits weighted by 1 for a single, 2 for a double, 3 for a triple and 4 for a home run.
  def bases
    return (self.calculate_singles+(2*self.doubles)+(3*self.triples)+(4*self.home_runs)).to_f
  end

  def calculate_singles
    return self.hits-(self.doubles+self.triples+self.home_runs)
  end

  #def stat_set
  #  puts [runs,home_runs,steals,rbi,self.batting_average()].join(", ")
  #end

  #RUNS, runs
  #HR, Home Runs
  #SB, Stolen Bases
  #
  #RBI, runs batted in
  #
  #AVG, Batting Average
  #OPS On-base Plus Slugging Percentage
  #=on base percentage + slugging percentage
end
