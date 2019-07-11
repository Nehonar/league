defmodule LeagueTest.PairsControllerTest do
  @moduledoc false
  use ExUnit.Case
  use Plug.Test

  alias League.Web.Controllers.PairsController

  test "Get pairs" do
    conn = conn(:get, "/available_pairs")
    resp = PairsController.init(conn)

    # IO.inspect resp
    assert true
  end
end
