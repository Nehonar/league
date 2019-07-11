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
        CONN            --> All info of connection
        DATA            --> Data sent to logic
        PARAMS          --> Params is div and season
        """
        defstruct [
            :conn,
            :data,
            :params
        ]
    end

    defmodule Error do
        @moduledoc """
        REASON  --> Reason of error
        STATE   --> Complete state to see the possible failures
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

    # Take the params of the connection
    def get_params(%State{conn: conn} = state) do
        params =
            conn.query_string
            |> URI.decode_query()
        %State{state | params: params}
    end

    # Check that the params exist
    def validate_params(%State{params: params} = state) do
        case params do
            %{"div" => _, "season" => _} ->
                %State{state | params: params}
            _ ->
                %Error{reason: "Parameters are wrong", state: state}
        end
    end

    # Send data to the logic module
    def send_data_logic(%State{params: params} = state) do
        {:ok, data} =
            SeasonLeagueLogic.init(params)
        
        %State{state | data: data}
    end
    def send_data_logic(%Error{} = error), do: error

    # If everything goes well we send the answer with 200
    def send_respond(%State{conn: conn, data: data}) do
        conn
        |> put_resp_header("content-type", "application/json")
        |> send_resp(200, Jason.encode!(data))

    end
    # If something has gone wrong, we send the reason and show the state
    def send_respond(%Error{reason: reason, state: state}) do
        Logger.error "#{inspect state}"
        state.conn
        |> put_resp_header("content-type", "application/json")
        |> send_resp(400, Jason.encode!(reason))
    end

end
