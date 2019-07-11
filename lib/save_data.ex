defmodule League.SaveData do
  @moduledoc """
  This module will be responsible for reading the csv 
  and saving it in an ETS table when the app is started.
  """
  require Logger
  alias League.Helpers.Ets

  # ETS table name
  @name_ets :league

  defmodule State do
    @moduledoc """
    DATA_CSV      --> All CSV data.
    FILE_EXIST    --> Just check if the CSV file exists.
    MAP_DATA_LIST --> A map with the rows in list
    NAME_ETS      --> Just a name of ETS table
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
    REASON  --> Reason of error
    STATE   --> Complete state to see the possible failures
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
    |> check_file_csv()
    |> get_data_csv()
    |> mapping_data_csv()
    |> create_ets()
    |> save_data_ets()
  end

  # Check if the CSV exists
  def check_file_csv(%State{} = state) do
    file_exist = File.exists?(@path_file_csv)

    %State{state | file_exist: file_exist}
  end

  # If the CSV exists, take data from csv
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

  # If the CSV does not exist it will enter here
  def get_data_csv(%State{} = state) do
    %Error{reason: "No such file or directory", state: state}
  end

  # Create a map from CSV data
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

  # Create ETS table
  def create_ets(%State{} = state) do
    name_ets = Ets.create_ets_table(@name_ets)

    %State{state | name_ets: name_ets}
  end

  def create_ets(%Error{} = error), do: error

  # Save data from CSV to ETS
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
