defmodule LeagueTest.PairsLogicTest do
    @moduledoc false
    use ExUnit.Case
    use Plug.Test
    
    alias League.PairsLogic.{State}

    # test "Get pairs" do
    #     resp = 
    #         PairsLogic.get_data_ets(%State{ets_lookup: data_pairs()})
    #     # IO.inspect resp
        
        
    #     assert true
    # end

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