alias League.Web.{MetricsExporter, MetricsInstrumenter, Router}
alias Plug.Cowboy

defmodule League.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    MetricsExporter.setup()
    MetricsInstrumenter.setup()

    children = [
      Cowboy.child_spec(
        scheme: :http,
        plug: Router,
        options: [port: 4001]
      )
    ]

    opts = [strategy: :one_for_one, name: League.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
