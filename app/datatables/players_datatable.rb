class PlayersDatatable < AjaxDatatablesRails

  def initialize(view)
    super(view)

    @model_name = Player

    @columns = ["players.given_name",
                "players.surname",
                "players.runs",
                "players.home_runs",
                "players.steals",
                "players.rbi",
                "players.batting_average",
                "players.on_base_percentage_plus_slugging",
                "players.position"
    ]

    @searchable_columns = ["players.given_name",
                           "players.surname"]

  end

  def data
    players.map do |player|
      [
          player.given_name,
          player.surname,
          player.runs,
          player.home_runs,
          player.steals,
          player.rbi,
          player.batting_average.nil? ? "" : "%.3f" % player.batting_average,
          player.on_base_percentage_plus_slugging.nil? ? "" : "%.3f" % player.on_base_percentage_plus_slugging,
          player.position
      ]
    end
  end

  def players
    if (@players.nil?)
      @players = fetch_records
    end
  end

  def get_raw_records
    Player.unscoped
  end

  #def get_raw_record_count
  #  search_records(get_raw_records).count
  #end
end
