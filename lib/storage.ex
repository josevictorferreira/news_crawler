defmodule Storage do
  alias Storage.Adapter
  alias Storage.Database

  def init! do
    Database.start_link
    create_collection!(Database.conn, "articles")
    Database.conn
  end

  def insert_article(conn, data) do
    doc =
      data
      |> Map.merge(%{_key: Utils.hash_key(data[:source] <> data[:title])})
    insert(conn, "articles", doc)
  end

  def conn, do: Database.conn

  defdelegate insert(conn, collection_name, data), to: Adapter
  defdelegate create_collection!(conn, collection_name), to: Adapter
end
