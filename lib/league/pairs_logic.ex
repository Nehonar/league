defmodule League.PairsLogic do
    @moduledoc """
    Pairs Logic
    """ 
    defmodule State do
        defstruct [
            :data_list,
            :data_pairs
        ]
    end

    def init(data_pairs) do
        %State{data_pairs: data_pairs}
        |> list_data()
        |> select_unique_pairs()
    end

    def list_data(%State{data_pairs: data_pairs} = state) do
        data_list = 
            Enum.reduce(data_pairs, fn {_key, data}, acc -> 
                [data | acc]
            end)
        
        %State{state | data_list: data_list}
    end

    def select_unique_pairs(%State{data_list: data_list} = state) do
        unique_pairs = 
            Enum.uniq_by(data_list, fn %{"Div" => div, "Season" => season}, acc -> 
                [%{div, season} | acc]
            end)
        IO.inspect unique_pairs
    end
end