defmodule LeagueTest.Controllers.PairsControllerTest do
  @moduledoc """
  Test to verify if the PairsController it's ok
  """

  use ExUnit.Case
  use Plug.Test

  alias League.Web.Controllers.PairsController

  test "Get pairs" do
    conn = conn(:get, "/available_pairs")
    resp = PairsController.init(conn)
    resp_decode = Jason.decode!(resp.resp_body)
    resp_valid = ["201516", "201617"]

    assert resp_decode["SP1"] == resp_valid
  end
end
