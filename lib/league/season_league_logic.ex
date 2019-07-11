defmodule League.SeasonLeagueLogic do
  @moduledoc """
  Season and League Logic
  """

  alias League.Helpers.Ets

  @ets_table :league

  defmodule State do
    @moduledoc """
    state
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

  def get_data_ets(%State{} = state) do
    all_data = Ets.lookup_all(@ets_table)

    %State{state | all_data: all_data}
  end

  def get_data_filtered(%State{all_data: all_data, params: params} = state) do
    data =
      all_data
      |> Enum.map(fn {_key, row} ->
        if filter(params, row["Div"], row["Season"]), do: row
      end)
      |> Enum.filter(&(!is_nil(&1)))

    %State{state | data: data}
  end

  defp filter(params, div, season) do
    div == params["div"] and season == params["season"]
  end

  def return_data(%State{data: data}) do
    {:ok, data}
  end
end
