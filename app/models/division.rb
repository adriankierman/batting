class Division < ActiveRecord::Base
  attr_accessible :division_name,:teams,:teams_attributes
  attr_accessor :teams_attributes
  belongs_to :league
  has_many :teams

  #accepts_nested_attributes_for :teams
end
