defmodule League.Web.Controllers.PairsController do
    @moduledoc """
    Returns optional pairs
    """
    import Plug.Conn

    alias League.PairsLogic

    defmodule State do
        @moduledoc """
        State
        """
        defstruct [
            :all_data,
            :conn,
            :data,
            :div_data,
            :season_data,
            :params
        ]
    end

    def init(conn) do
        %State{conn: conn}
        |> call_logic()
        |> send_respond()
    end

    def call_logic(%State{} = state) do
        data = 
            Enum.into(PairsLogic.init(), %{})

        %State{state | data: data}
    end

    def send_respond(%State{conn: conn, data: data}) do
        conn
        |> put_resp_header("content-type", "application/json")
        |> send_resp(200, Jason.encode!(data))
    end
    
end