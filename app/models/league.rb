class League < ActiveRecord::Base
  attr_accessible :league_name,:divisions,:divisions_attributes
  attr_accessor :divisions_attributes
  belongs_to :season
  has_many :divisions

  #accepts_nested_attributes_for :divisions
end
