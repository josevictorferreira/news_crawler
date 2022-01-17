defmodule Scraper.Exame do
  use HTTPoison.Base

  @base_url "https://exame.com/feed/"

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
