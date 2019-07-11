defmodule League.PairsLogic do
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
            ets_lookup: &Ets.lookup_all/1
        ]
    end

    def init() do
        %State{}
        |> get_data_ets()
        |> list_seasons_with_leagues()
        |> return_data()
    end

    def get_data_ets(%State{ets_lookup: ets_lookup} = state) do
        all_data =
            ets_lookup.(@ets_table)
        
        %State{state | all_data: all_data}
    end

    def list_seasons_with_leagues(%State{all_data: all_data} = state) do
        data = 
            Enum.reduce(all_data, %{}, fn {_key, %{"Div" => div, "Season" => season}}, acc ->
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

    def return_data(%State{data: data}) do
        data
    end
end