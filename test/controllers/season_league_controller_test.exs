defmodule LeagueTest.Controllers.SeasonLeagueControllerTest do
  @moduledoc """
  Test to verify if the return of the list works with the league and season 
  """
  use ExUnit.Case
  use Plug.Test

  alias League.Web.Controllers.{SeasonLeagueController, PairsController}

  test "Get season and league OK" do
    path = "/leagues?div=SP1&season=201617"
    conn = conn(:get, path)
    resp = SeasonLeagueController.init(conn)
    
    [h | _t] = Jason.decode!(resp.resp_body)

    assert h["HomeTeam"] == "Valencia"
  end

  test "Get season and league ERROR" do
    path = "/leagues?di=SP1&season=201617"
    conn = conn(:get, path)
    resp = SeasonLeagueController.init(conn)
    
    assert Jason.decode!(resp.resp_body) == "Parameters are wrong"
  end
end
