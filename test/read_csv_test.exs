defmodule LeagueTest.ReadCSV do
    @moduledoc false
    use ExUnit.Case
    use Plug.Test
    # alias
    alias League.Lib.ReadData

    test "Read headers" do
        headers = ReadData.get_headers_csv
        IO.puts "HEADERS :::: #{inspect headers}"

        assert true
    end
end