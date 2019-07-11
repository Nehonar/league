defmodule League.Web.Controllers.PairsController do
    @moduledoc """
    Returns optional pairs
    """
    import Plug.Conn

    alias League.PairsLogic

    defmodule State do
        @moduledoc """
        CONN --> The connection
        DATA --> List of pairs season and leagues
        """
        defstruct [
            :conn,
            :data,
        ]
    end

    def init(conn) do
        %State{conn: conn}
        |> call_logic()
        |> send_respond()
    end

    # Send data to logic 
    def call_logic(%State{} = state) do
        data =
            PairsLogic.init
            |> Enum.into(%{})

        %State{state | data: data}
    end

    # Send the answer with data
    def send_respond(%State{conn: conn, data: data}) do
        conn
        |> put_resp_header("content-type", "application/json")
        |> send_resp(200, Jason.encode!(data))
    end
end
