defmodule League.Lib.SaveData do
    @moduledoc """
    This module read data
    """
    def init() do
        IO.puts "Init extract data from CSV"

        Path.expand("Data.csv")
        |> File.stream!()
        |> CSV.decode(separator: ?,, headers: true)
        |> Enum.map(fn row ->
            case row do
                {:ok, data} -> data
                _ -> :error
            end
        end)
        |> Enum.filter(fn
            :error -> false
            _ -> true
        end)
    end
end