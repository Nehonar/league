defmodule League do
  @moduledoc false

  use Application

  alias League.SaveData
  alias League.Web.Router
  alias Plug.Cowboy

  def start(_type, _args) do
    children = [
      Cowboy.child_spec(
        scheme: :http,
        plug: Router,
        options: [port: 4001]
      )
    ]

    # Read CSV, Create table ETS and insert data
    SaveData.init()

    opts = [strategy: :one_for_one, name: League.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
