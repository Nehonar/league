defmodule League.SaveData do
  @moduledoc """
  This module will be responsible for reading the csv 
  and saving it in an ETS table when the app is started.
  """
  require Logger
  alias League.Helpers.Ets

  @name_ets :league

  defmodule State do
    @moduledoc """
    Controls the structure of the parameters.
    """
    defstruct [
      :data_csv,
      :file_exist,
      :map_data_list,
      :name_ets
    ]
  end

  defmodule Error do
    @moduledoc """
    Control the structure of the error
    """
    defstruct [
      :reason,
      :state
    ]
  end

  @path_file_csv ~w(Data.csv)

  def init do
    Logger.info("Init extract data from CSV")

    %State{}
    |> controller_file_csv()
    |> get_data_csv()
    |> mapping_data_csv()
    |> create_ets()
    |> save_data_ets()
  end

  def controller_file_csv(%State{} = state) do
    file_exist = File.exists?(@path_file_csv)

    %State{state | file_exist: file_exist}
  end

  def get_data_csv(%State{file_exist: true} = state) do
    Logger.info("Get data from CSV")

    data_csv =
      @path_file_csv
      |> Path.expand()
      |> File.stream!()
      |> CSV.decode(separator: ?,, headers: true)

    %State{state | data_csv: data_csv}
  rescue
    _error in File.Error ->
      %Error{reason: "Error decoding csv file", state: state}
  end

  def get_data_csv(%State{} = state) do
    %Error{reason: "No such file or directory", state: state}
  end

  def mapping_data_csv(%State{data_csv: data_csv} = state) do
    Logger.info("Mapping data from csv")

    map_data_list =
      Enum.map(data_csv, fn row ->
        case row do
          {:ok, data} ->
            data

          _error ->
            :error
        end
      end)

    %State{state | map_data_list: map_data_list}
  end

  def mapping_data_csv(%Error{} = error), do: error

  def create_ets(%State{} = state) do
    name_ets = Ets.create_ets_table(@name_ets)

    %State{state | name_ets: name_ets}
  end

  def create_ets(%Error{} = error), do: error

  def save_data_ets(%State{name_ets: name_ets, map_data_list: map_data_list}) do
    Logger.info("Insert data in table")

    Enum.map(map_data_list, fn row ->
      Ets.insert_data(name_ets, {row[""], row})
    end)
  end

  def save_data_ets(%Error{reason: reason}) do
    Logger.error(reason)
  end
end
