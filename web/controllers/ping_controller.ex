defmodule League.Web.Controllers.PingController do
    @moduledoc """
    This module is to check the functioning of the server
    """
    import Plug.Conn

    @spec ping(%Plug.Conn{}) :: %Plug.Conn{}
    def ping(conn) do
        conn
        |> put_resp_header("content-type", "text/plain")
        |> send_resp(200, "Pong")
    end

    @spec flunk(%Plug.Conn{}) :: %Plug.Conn{}
    def flunk(conn) do
        conn
        |> put_resp_header("content-type", "text/plain")
        |> send_resp(500, "Ooops... We have a several internal error!")
    end
end