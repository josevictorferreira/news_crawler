defmodule InfomoneyScraper do
  def run do
    InfoMoney.start
    "" |> InfoMoney.get! |> RssParser.parse
  end
end

InfomoneyScraper.run |> IO.inspect
