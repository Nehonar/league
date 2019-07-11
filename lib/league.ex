defmodule League do
  @moduledoc false

  use Application

  alias Plug.Cowboy
  alias League.Web.Router
  alias League.SaveData

  def start(_type, _args) do
    children = [
      Cowboy.child_spec(
        scheme: :http,
        plug: Router,
        options: [port: 4001]
      )
    ]
    
    SaveData.init()

    opts = [strategy: :one_for_one, name: League.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
