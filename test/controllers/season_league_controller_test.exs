defmodule LeagueTest.SeasonLeagueControllerTest do
    @moduledoc false
    use ExUnit.Case
    use Plug.Test
    
    alias League.Web.Controllers.SeasonLeagueController

    test "Get pairs" do
        conn = conn(:get, "/available_pairs")
        resp = SeasonLeagueController.init(conn)

        IO.inspect resp
        assert true
    end
end