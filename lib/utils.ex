defmodule Utils do
  def strip_html_tags(html_text) do
    text_without_tags = Regex.replace(~r/<(.|\n)*?>/, html_text, "")
    Regex.replace(~r/&#?[a-z0-9]{2,8};/, text_without_tags, "")
  end

  def db_options do
    load_dotenv!()
    [
      endpoints: env("ARANGO_URL"),
      username: env("ARANGO_ROOT_USERNAME"),
      password: env("ARANGO_ROOT_PASSWORD"),
      pool_size: env("ARANGO_POOL_SIZE") |> String.to_integer
    ]
  end

  def load_dotenv! do
    if [:dev, :test] |> Enum.member?(env("MIX_ENV")) do
      Dotenv.load!
    end
  end

  def hash_key(value) do
    :crypto.hash(:md5, value) |> Base.encode16
  end

  def scraper_name(module) do
    module |> to_string |> String.replace(~r/Scraper\./, "") |> String.replace(~r/Elixir\./, "")
  end

  def env(key) do
    System.get_env(key)
  end
end
