defmodule League.PairsLogic do
  @moduledoc """
  The logic of the pairs module, locate the different 
  types of combinations you have
  """

  alias League.Helpers.Ets

  # Table Ets name
  @ets_table :league

  defmodule State do
    @moduledoc """
    ALL_DATA      --> Literally all the data.
    DATA          --> List of the season with the leagues.
    ETS_LOOKUP_FN --> By default it uses the ets helper, 
                      but you can send a different data.
    """
    defstruct [
      :all_data,
      :data,
      ets_lookup_fn: &Ets.lookup_all/1
    ]
  end

  def init do
    %State{}
    |> get_data_ets
    |> list_seasons_with_leagues
    |> return_data
  end

  # Take data from the default ETS of the tabla that @ets_table
  def get_data_ets(%State{ets_lookup_fn: ets_lookup_fn} = state) do 
    all_data = 
      ets_lookup_fn.(@ets_table)
      
    %State{state | all_data: all_data}
  end

  # Create a list with each season with your leagues
  def list_seasons_with_leagues(%State{all_data: all_data} = state) do
    data =
      all_data
      |> Enum.reduce(%{}, fn {_key, %{"Div" => div, "Season" => season}}, acc ->
        if Map.has_key?(acc, div) do
          old_season = Map.get(acc, div)
          Map.put(acc, div, old_season ++ [season])
        else
          Map.put_new(acc, div, [season])
        end
      end)
      |> Enum.map(fn {div, season} -> {div, Enum.uniq(season)} end)

    %State{state | data: data}
  end

  # Returns data even if it is an empty list
  def return_data(%State{data: data}) do
    data
  end
end
