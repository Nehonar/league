# League
Elixir application that serves the football results included in the attached data.csv file.

# List of dependencies used for the app
    ```
    {:credo, "~> 1.0", only: [:dev, :test], runtime: false},
    {:csv, "~> 2.3"},
    {:excoveralls, "~> 0.11.1", only: :test},
    {:jason, "~> 1.1.2"},
    {:mix_test_watch, "~> 0.8", only: [:dev, :test], runtime: false},
    {:plug_cowboy, "~> 2.0"},
    {:plug, "~> 1.0"}
    ```
- Credo is a tool to correct the structure, 
can warn from blank spaces to variables that are not used.
- CSV is for decode and encode CSV's.
- Coveralls warns you about the functions that pass the tests 
and the functions that do not.
- Jason is for decode and encode json.
- Mix_test_watch is a observer for when you make changes in live test.
- Plug and Plug_cowboy they are used to create routes connections.

# To start the application:
- mix deps.get
- iex -S mix

# When the app starts, it reads the csv and stores the data in ets tables, 
# the reading of the data is faster and you only have to read the csv once.

- I chose to save the data in ets, because of the speed of reading and writing it offers, 
in the end it occurred to me that I could save individual tables by divisions, 
and thus the reading of a season and division pair would be more optimal, 
but not I had time and I left the code like that.


# The system starts up on: 
- localhost:4001/

# API 
- The api is divided into two endpoints, I have to think about a possible frontend, 
it is interesting that they can choose the list of divisions, 
to be able to offer the user a list.
- I have also included an api that returns the version of the project 
linked to the last commit of github.
- Another basic is the ping, to know if the app is up.

# Routes
- /available_pairs
    - This route offers a list of divisions with their available seasons.
    - Here is an example of how data returns.
    ```
    localhos:4001/available_pairs

    {
        "D1": [
            "201617"
        ],
        "E0": [
            "201617"
        ],
        "SP1": [
            "201516",
            "201617"
        ],
        "SP2": [
            "201617",
            "201516"
        ]
    }
    ```
- /leagues?div=&season=
    - When we know the divisions available with their respective seasons, 
    we can ask for the combination that we want.
    - Here is an example of how data returns.
    ```
    localhost:4001/leagues?div=SP1&season=201516

    [
        {
        "": "465",
        "AwayTeam": "Getafe",
        "Date": "24/10/2015",
        "Div": "SP1",
        "FTAG": "0",
        "FTHG": "5",
        "FTR": "H",
        "HTAG": "0",
        "HTHG": "2",
        "HTR": "H",
        "HomeTeam": "Sevilla",
        "Season": "201516"
        }
    ]
    ```
- /version
    - Returns version of the project.
    ```
    0.1.0+a1a1a1a
    ```
- /ping
    - If returns "pong", it means that the app is working.
    ```
    Pong
    ```


