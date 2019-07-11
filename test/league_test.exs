defmodule LeagueTest do
  @moduledoc false
  use ExUnit.Case
  use Plug.Test

  # All alias
  alias League.Web.Controllers.PingController, as: PingController

  test "Ping test" do
    conn = conn(:get, "/ping")
    resp = PingController.ping(conn)

    assert resp.resp_body == "Pong"
  end

  test "flunk test" do
    conn = conn(:get, "/flunk")
    resp = PingController.flunk(conn)

    assert resp.resp_body == "Ooops... We have a several internal error!"
  end
end
