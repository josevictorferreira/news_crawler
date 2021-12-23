defmodule Services.ArticleFetcher do
  def perform(scraper) do
    {:ok, conn} = Utils.db_options |> Arangox.start_link
    scraper
    |> fetch_articles
    |> Enum.map(fn x ->
      doc = x |> Map.merge(%{source: Utils.scraper_name(scraper)})
      Storage.insert_article(conn, doc)
    end)
  end

  defp fetch_articles(scraper) do
    scraper.start
    "" |> scraper.get! |> Parser.Rss.parse
  end
end
