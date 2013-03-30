class Season < ActiveRecord::Base
  attr_accessible :year,:leagues,:leagues_attributes
  attr_accessor :leagues_attributes
  has_many :leagues

  #accepts_nested_attributes_for :leagues
end
