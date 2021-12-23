defmodule InfomoneyScraper do
  alias Scraper.InfoMoney
  alias Parser.Rss

  def run do
    InfoMoney.start
    "" |> InfoMoney.get! |> Rss.parse
  end
end

InfomoneyScraper.run |> IO.inspect
