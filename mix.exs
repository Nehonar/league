defmodule League.MixProject do
  use Mix.Project

  def project do
    [
      app: :league,
      version: "0.1.0",
      elixir: "~> 1.9",
      elixirc_paths: elixirc_paths(Mix.env),
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      deps: deps(),
      aliases: [test: ["test", "credo --strict"]]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :plug_cowboy],
      mod: {League, []}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_cowboy, "~> 2.0"},
      {:plug, "~> 1.0"},
      {:credo, "~> 1.0", only: [:dev, :test], runtime: false}
    ]
  end
end
