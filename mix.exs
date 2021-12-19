defmodule InfomoneyScraper.MixProject do
  use Mix.Project

  def project do
    [
      app: :infomoney_scraper,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :httpoison, :saxy]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:saxy, "~> 1.4"},
      {:httpoison, "~> 1.7"},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false}
    ]
  end
end
