defmodule League.Web.Controllers.VersionController do
  @moduledoc """
  With this controller we can to know the commit version of sheldon when it is
  in production.
  """
  import Plug.Conn

  @spec init(%Plug.Conn{}) :: %Plug.Conn{}

  def init(conn) do
    conn
    |> put_resp_header("content-type", "text/plain")
    |> send_resp(200, get_commit_version())
  end

  @spec get_commit_version() :: String.t

  def get_commit_version do
    commit =
      'git rev-parse --short HEAD'
      |> :os.cmd()
      |> to_string()
      |> String.trim_trailing("\n")

    "0.1.0+#{commit}"
  end
end
