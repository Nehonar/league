defmodule League.Lib.SaveData do
    @moduledoc """
    This module read data
    """
    require Logger
    defmodule State do
        defstruct [
            :data_csv,
            :file_exist,
            :map_data
        ]
    end

    defmodule Error do
        defstruct [
            :reason,
            :state
        ]    
    end

    @path_file_csv ~w(Data.csv)

    def init() do
        Logger.info "Init extract data from CSV"

        %State{}
        |> controller_file_csv()
        |> get_data_csv()
        |> mapping_data_csv()
    end
        
    #     Path.expand()
        
    #     |> File.stream!()
    #     |> CSV.decode(separator: ?,, headers: true)
    #     |> Enum.map(fn row ->
    #         case row do
    #             {:ok, data} -> data
    #             _ -> :error
    #         end
    #     end)
    #     |> Enum.filter(fn
    #         :error -> false
    #         _ -> true
    #     end)
    # end
    def controller_file_csv(%State{} = state) do
        file_exist = 
            File.exists?(@path_file_csv)

        %State{state | file_exist: file_exist}
    end

    def get_data_csv(%State{file_exist: true} = state) do
        data_csv =
            Path.expand(@path_file_csv)
            |> File.stream!()
            |> CSV.decode!(separator: ?,, headers: true)

        %State{state | data_csv: data_csv}

        rescue
            _error in File.Error -> 
                %Error{reason: "Error decoding csv file"}
    end
    def get_data_csv(%State{} = state) do 
        %Error{reason: "No such file or directory", state: state}
    end

    def mapping_data_csv(%State{data_csv: data_csv} = state) do
        Enum.map(data_csv, fn row ->
            case row do
                {:ok, map_data} ->
                    %State{state | map_data: map_data}
                _error -> 
                    IO.puts "Error, We can't mapping this file"
                    %Error{reason: "Error, We can't mapping this file", state: state}
            end
        end)
    end
    def mapping_data_csv(%Error{} = error), do: error
end