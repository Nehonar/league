defmodule League.Helpers.Ets do
  @moduledoc """
  This module is a helper to create ets tables, 
  insert data and search
  """

  require Logger

  # Just give it a name talba name and it will create it 
  def create_ets_table(name) do
    Logger.info("Creating ETS table")

    :ets.new(name, [:named_table, :set])
  end

  # Give it a name table and data, he inserts it for you
  def insert_data(table_name, atom_row) do
    :ets.insert(table_name, atom_row)
  end

  # Search and find any table
  def lookup_all(name_table) do
    :ets.foldl(
      fn data, acc ->
        acc ++ [data]
      end,
      [],
      name_table
    )
  end
end
