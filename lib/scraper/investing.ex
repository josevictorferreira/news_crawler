defmodule Scraper.Investing do
  use HTTPoison.Base

  @base_url "https://www.investing.com/rss/news.rss"

  def process_request_url(url) do
    @base_url <> url
  end

  def process_response_body(body) do
    body
    |> String.trim()
    |> String.replace(["\n", "\t"], " ")
    |> Saxy.SimpleForm.parse_string
  end
end
