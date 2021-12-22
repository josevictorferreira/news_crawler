defmodule Storage.Adapter do
  def insert(conn, collection_name, data) do
    Arangox.post(conn, "/_api/document/#{collection_name}", data)
  end

  def create_unique_index(conn, collection_name, fields) do
    Arangox.post(conn, "/_api/index?collection=" <> collection_name, %{
      type: "hash",
      unique: true,
      fields: fields
    })
  end

  def create_collection!(conn, collection_name) do
    if not collection_exists?(conn, collection_name) do
      Arangox.post!(conn, "/_api/collection", %{name: collection_name, type: 2})
    end
  end

  def collection_exists?(conn, collection_name) do
    Arangox.get(conn, "/_api/collection/#{collection_name}")
    |> case do
      {:ok, _any_request, _any_response} ->
        true

      {:ok, _any} ->
        true

      _any ->
        false
    end
  end
end
