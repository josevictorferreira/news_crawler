defmodule InfomoneyScraper do
  def run do
    InfoMoney.start
    InfoMoney.get!("").body
  end
end

InfomoneyScraper.run
