defmodule LeagueTest.Controllers.VersionControllerTest do
    @moduledoc """
    Test to verify version controller
    """
    use ExUnit.Case
    use Plug.Test
  
    alias League.Web.Controllers.VersionController
  
    test "Get version" do
      conn = conn(:get, "/version")
      resp = VersionController.init(conn)
      version = get_version()
      resp_decode = resp.resp_body
  
      assert resp_decode == version
    end

    def get_version do
        commit =
            'git rev-parse --short HEAD'
            |> :os.cmd()
            |> to_string()
            |> String.trim_trailing("\n")

        "0.1.0+#{commit}"
    end
  end