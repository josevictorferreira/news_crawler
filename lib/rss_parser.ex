defmodule RssParser do
  def parse(rss_feed) do
    parse_rss_data(rss_data(rss_feed))
  end

  defp parse_rss_data({:ok, rss_feed}) do
    rss_feed
    |> Enum.reduce([], fn
      {"item", _, values}, collector ->
        parsed_article = values |> Enum.reduce(%{}, &parse_article/2)
        [parsed_article | collector]
      _, collector ->
        collector
    end)
  end
  
  defp parse_rss_data({:error, message}) do
    {:error, message}
  end
  
  defp parse_article({"title", _, [title]}, article_data) do
    article_data |> Map.put(:title, title)
  end
  
  defp parse_article({"description", _, [description]}, article_data) do
    article_data |> Map.put(:description, Utils.strip_html_tags(description))
  end
  
  defp parse_article({"category", _, [category]}, article_data) do
    if Map.has_key?(article_data, :categories) do
      article_data |> Map.replace!(:categories, [category | article_data[:categories]])
    else
      Map.put(article_data, :categories, [category])
    end
  end

  defp parse_article({"content:encoded", _, [content]}, article_data) do
    article_data |> Map.put(:content, Utils.strip_html_tags(content))
  end
  
  defp parse_article({"link", _, [link]}, article_data) do
    article_data |> Map.put(:link, link)
  end

  defp parse_article({"pubDate", _, [pub_date]}, article_data) do
    article_data |> Map.put(:published_at, pub_date)
  end

  defp parse_article(_, article_data) do
    article_data
  end

  defp rss_data(%HTTPoison.Response{body: {:ok, {"rss", _, [{"channel", [], data}]}}}) do
    {:ok, data}
  end

  defp rss_data(_) do
    {:error, "Unable to parse RSS feed."}
  end
end
