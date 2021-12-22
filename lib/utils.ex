defmodule Utils do
  def strip_html_tags(html_text) do
    text_without_tags = Regex.replace(~r/<(.|\n)*?>/, html_text, "")
    Regex.replace(~r/&#?[a-z0-9]{2,8};/, text_without_tags, "")
  end

  def db_options do
    load_dotenv!()
    [
      endpoints: System.get_env("ARANGO_URL"),
      username: System.get_env("ARANGO_ROOT_USERNAME"),
      password: System.get_env("ARANGO_ROOT_PASSWORD"),
      pool_size: System.get_env("ARANGO_POOL_SIZE") |> String.to_integer
    ]
  end

  def load_dotenv! do
    if [:dev, :test] |> Enum.member?(Mix.env) do
      Dotenv.load!
    end
  end

  def hash_key(value) do
    :crypto.hash(:md5, value) |> Base.encode16
  end
end
