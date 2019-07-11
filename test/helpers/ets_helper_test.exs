defmodule LeagueTest.Helpers.EtsHelpersTest do
    @moduledoc """
    Check the helper functions of the ets
    """
    use ExUnit.Case
    use Plug.Test
  
    alias League.Helpers.Ets
  
    test "Create ets" do
        Ets.create_ets_table(:test)
        info = :ets.info(:test)
        :ets.delete(:test)

        assert info[:name] == :test
    end

    test "Insert data in ets" do
        Ets.create_ets_table(:test2)
        Ets.insert_data(:test2, [test: {"test"}])
        info = :ets.lookup(:test2, :test)
        :ets.delete(:test2)

        assert info == [test: {"test"}]
    end
  end