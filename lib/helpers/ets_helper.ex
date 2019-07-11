defmodule League.Helpers.Ets do
  @moduledoc """
  This module read data
  """

  require Logger

  def create_ets_table(name) do
    Logger.info("Creating ETS table")

    :ets.new(name, [:named_table, :set])
  end

  def insert_data(table_name, atom_row) do
    :ets.insert(table_name, atom_row)
  end

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
