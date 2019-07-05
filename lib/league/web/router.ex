defmodule League.Web.Router do
  use Plug.Router

  plug(:match)
  plug League.Web.MetricsInstrumenter
  plug League.Web.MetricsExporter
  plug(:dispatch)

  get "/hello" do
    send_resp(conn, 200, "world")
  end

  match _ do
    send_resp(conn, 404, "oops")
  end
end
