defmodule League.Web.Controllers.PairsController do
    @moduledoc """
    Controller pairs
    """
    import Plug.Conn

    alias League.Helpers.Ets
    alias League.PairsLogic

    @ets_table :league

    defmodule State do
        defstruct [
            :conn,
            :data,
            :data_pairs
        ]
    end

    def init(conn) do
        %State{conn: conn}
        |> search_pairs()
        |> logic_pairs()
        |> response()
    end

    def search_pairs(%State{conn: conn} = state) do
        data_pairs = 
            Ets.lookup_all(@ets_table)

        %State{state | conn: conn, data_pairs: data_pairs}
    end

    def logic_pairs(%State{data_pairs: data_pairs} = state) do
        data = 
            PairsLogic.init(data_pairs)
        
        %State{state | data: data}
    end

    def response(%State{conn: conn, data: data}) do
        IO.inspect data
        conn
        |> put_resp_header("content-type", "application/json")
        |> send_resp(200, Jason.encode!(data))
    end
end