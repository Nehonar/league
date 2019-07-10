defmodule League.Web.Router do
  @moduledoc """
  League is a platform....
  TODO
  """

  use Plug.Router
  alias League.Web.Controllers.{PingController, PairsController}
  # Use plug logger for logging request information
  plug(Plug.Logger)

  plug(:match)
  plug(:dispatch)

  get "/ping", do: PingController.ping(conn)
  get "/flunk", do: PingController.flunk(conn)
  get "/available_pairs", do: PairsController.init(conn)

  match _ do
    send_resp(conn, 404, "Ooops.. This not exist")
  end
end
