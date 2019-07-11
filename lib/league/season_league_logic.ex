defmodule League.SeasonLeagueLogic do
  @moduledoc """
  Here we have the logic of how the table recovers ETS 
  and inside it creates a list with the desired league and season.
  """

  alias League.Helpers.Ets

  @ets_table :league

  defmodule State do
    @moduledoc """
    ALL_DATA  --> Literally all the data.
    DATA      --> Filtered data to return a list with a league and season.
    PARAMS    --> Season and div stablished.
    """
    defstruct [
      :all_data,
      :data,
      :params
    ]
  end

  def init(params) do
    %State{params: params}
    |> get_data_ets()
    |> get_data_filtered()
    |> return_data()
  end

  # Take data from the default ETS of the tabla that @ets_table
  def get_data_ets(%State{} = state) do
    all_data = Ets.lookup_all(@ets_table)

    %State{state | all_data: all_data}
  end

  # Filter data to return a list with the established parameters
  def get_data_filtered(%State{all_data: all_data, params: params} = state) do
    data =
      all_data
      |> Enum.map(fn {_key, row} ->
        if filter(params, row["Div"], row["Season"]), do: row
      end)
      |> Enum.filter(&(!is_nil(&1)))

    %State{state | data: data}
  end

  # Extracted function so do not force too much get_data_filteres
  defp filter(params, div, season) do
    div == params["div"] and season == params["season"]
  end

  # Return tuple with atom ok and data
  def return_data(%State{data: data}) do
    {:ok, data}
  end
end
