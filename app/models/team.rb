class Team < ActiveRecord::Base
  attr_accessible :team_city, :team_name, :players, :players_attributes
  attr_accessor :players_attributes
  belongs_to :division
  has_many :players

  #accepts_nested_attributes_for :players
end
