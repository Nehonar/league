defmodule League.Web.Controllers.SeasonLeagueController do
    @moduledoc """
    We control the parameters, we collect the data, 
    we send it to the logic and we return 
    the response of the already built pairs.
    """
    import Plug.Conn

    require Logger

    alias League.SeasonLeagueLogic

    defmodule State do
        @moduledoc """
        state structure to handle 
        the variables in a comfortable way
        """
        defstruct [
            :conn,
            :data,
            :div_data,
            :season_data,
            :params
        ]
    end

    defmodule Error do
        @moduledoc """
        Error structure to handle errors and reaosns
        """
        defstruct [
            :reason,
            :state
        ]    
    end

    def init(conn) do
        %State{conn: conn}
        |> get_params()
        |> validate_params()
        |> send_data_logic()
        |> send_respond()
    end

    def get_params(%State{conn: conn} = state) do
        params = 
            URI.decode_query(conn.query_string)
        
        %State{state | params: params}
    end

    def validate_params(%State{params: params} = state) do
        case params do
            %{"div" => _, "season" => _} ->
                %State{state | params: params}
            _ ->
                %Error{reason: "Parameters are wrong", state: state}
        end
        
    end

    def send_data_logic(%State{params: params} = state) do
        case SeasonLeagueLogic.init(params) do
            {:ok, data} ->
                %State{state | data: data}
            {:error, reason} ->
                %Error{reason: reason, state: state}
        end
    end
    def send_data_logic(%Error{} = error), do: error

    def send_respond(%State{conn: conn, data: data}) do
        conn
        |> put_resp_header("content-type", "application/json")
        |> send_resp(200, Jason.encode!(data))

    end
    def send_respond(%Error{reason: reason, state: state}) do
        Logger.error "#{inspect state}"
        state.conn
        |> put_resp_header("content-type", "application/json")
        |> send_resp(400, Jason.encode!(reason))
    end

end
