defmodule LeagueTest.SeasonLeagueLogicTest do
  @moduledoc """
  Check all logic to season and leagues
  """
  use ExUnit.Case
  use Plug.Test

  alias League.SeasonLeagueLogic

  test "Get Seasons and leagues" do
    params = %{"div" => "SP1", "season" => "201617"}
    {:ok, resp} = SeasonLeagueLogic.init(params)
    [h | _t] = resp

    assert h["AwayTeam"] == "Leganes"
  end
end
