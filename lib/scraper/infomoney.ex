defmodule Scraper.Infomoney do
  use HTTPoison.Base

  @base_url "https://www.infomoney.com.br/feed/"

  def process_request_url(url) do
    @base_url <> url
  end

  def process_response_body(body) do
    body
    |> String.trim()
    |> String.replace("\n", "")
    |> String.replace("\t", "")
    |> Saxy.SimpleForm.parse_string
  end
end
