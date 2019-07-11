defmodule LeagueTest.SeasonLeagueLogicTest do
    @moduledoc false
    use ExUnit.Case
    use Plug.Test
    
    alias League.SeasonLeagueLogic

    test "Get pairs" do
        params = %{"div" => "SP1", "season" => "201617"}
        
        resp = SeasonLeagueLogic.init(data_pairs(), params)
        
        # IO.inspect resp.resp_body
        assert true#h["Season"] == "201617"
    end

    def data_pairs() do
        [
            {:key, %{
              "" => "1",
              "AwayTeam" => "Eibar",
              "Date" => "19/08/2015",
              "Div" => "SP1",
              "FTAG" => "1",
              "FTHG" => "2",
              "FTR" => "H",
              "HTAG" => "0",
              "HTHG" => "0",
              "HTR" => "D",
              "HomeTeam" => "La Coruna",
              "Season" => "201617"
            }},
            {:key, %{
                "" => "2",
                "AwayTeam" => "Eibar",
                "Date" => "19/08/2016",
                "Div" => "SP1",
                "FTAG" => "1",
                "FTHG" => "2",
                "FTR" => "H",
                "HTAG" => "0",
                "HTHG" => "0",
                "HTR" => "D",
                "HomeTeam" => "La Coruna",
                "Season" => "201516"
            }}
        ]
    end
end