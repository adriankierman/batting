#!/usr/bin/env ruby
# This script performs the task of loading data from the statics xml file. This allows fully custom handling of data input.
# Since 100 percent test coverage is a requirement, this script also performs full round trip validation (writing out the
# same data it reads in to check that the saved data are the same as those loaded initially)

# The parse methods here are kept intentionally separate from the model classes - the reason for this is that it is expected
# that there may be more than one type of source data, and that for this reason each load process should be unique and that
# complexity should be hidden from the models involved in rendering the cleaned data.

# usage:
# ./script/data_loader.rb [xml_data_filename]

require './lib/core_ext/key_manipulation_hash'
require './lib/core_ext/color_strings'

class BaseballDataLoader

  DEFAULT_DATA_FILE = "db/1998statistics.xml"

  def load(filename=DEFAULT_DATA_FILE)
    # initialize
    prepare_load()

    # read the data from the file provided
    data_hash = read_data(filename)

    # convert the keys to appropriate rails format
    data_hash = parse_keys(data_hash)

    # parse the data for the provided season
    parse_season(data_hash[:season])
  end

  def read_data(filename)
    data_hash={}
    File.open(filename, "r") do |file|
      data_hash = Hash.from_xml(file.read)
    end
    data_hash
  end

  def parse_season(season_attributes)
    season=Season.create(season_attributes)
    season.save
    leagues_attributes=season_attributes[:leagues_attributes]
    leagues_attributes.each { |hash|
      parse_league(hash, season)
    }
    show_load_statistics()
    season
  end

  def parse_league(league_attributes, season)
    league=League.create(league_attributes)
    league.season=season
    league.save
    divisions_attributes=league_attributes[:divisions_attributes]
    divisions_attributes.each { |hash|
      parse_division(hash, league)
    }
  end

  def parse_division(division_attributes, league)
    division=Division.create(division_attributes)
    division.league=league
    division.save
    teams_attributes=division_attributes[:teams_attributes]
    teams_attributes.each { |hash|
      parse_team(hash, division)
    }
  end

  def parse_team(team_attributes,division)
    team=Team.create(team_attributes)
    team.division=division
    team.save
    players_attributes=team_attributes[:players_attributes]
    players_attributes.each { |hash|
      parse_player(hash, team)
    }
  end

  def parse_player(player_attributes, team)
    @player_count+=1
    player=Player.create(player_attributes)
    player.team=team
    player.save
    if (!player.valid?)
      @error_count+=1
      puts "Rejected data point #{player.errors.pretty_inspect} \n with data #{player_attributes.pretty_inspect}"
    end
  end

  def parse_keys(data_hash)
    data_hash = data_hash.keys_to_downcase.keys_to_symbols
    data_hash = data_hash.deep_convert_keys { |k|
      case k
        when :league then
          :leagues_attributes
        when :division then
          :divisions_attributes
        when :team then
          :teams_attributes
        when :player then
          :players_attributes
        when :errors then
          :mistakes
        else
          k
      end
    }
    data_hash
  end

  def prepare_load
    @player_count=0
    @error_count=0
  end

  def show_load_statistics
    puts '#'.red + '#'.pink + '#'*150 + '#'.red + '#'.pink
    puts '#'.red + '#'.pink + '#'*150 + '#'.red + '#'.pink
    puts "Load process completed - Summary Information".green
    puts "! #{@error_count} records did not validate as correct or complete - they were excluded automatically ! ".yellow if (@error_count>0)
    puts "Total (including unloadable) records #{@player_count}".green
    puts '#'.red + '#'.pink + '#'*150 + '#'.red + '#'.pink
    puts '#'.red + '#'.pink + '#'*150 + '#'.red + '#'.pink
  end



end


