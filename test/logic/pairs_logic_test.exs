defmodule LeagueTest.PairsLogicTest do
  @moduledoc """
  Check the logic to return the season and league pairs
  """
  use ExUnit.Case
  use Plug.Test

  alias League.PairsLogic

  test "Get pairs" do
    resp = PairsLogic.init()
    resp_valid = {"D1", ["201617"]}
    [h | _t] = resp

    assert h == resp_valid
  end
end
