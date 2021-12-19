defmodule Storage do
  alias :mnesia, as: Mnesia

  def init do
    setup()
  end

  defp setup do
    Mnesia.create_schema([node()])
    Mnesia.start()
    create_table()
  end

  defp attributes do
    [:id, :title, :link, :published_at, :description, :content]
  end

  defp create_table do
    case Mnesia.create_table(Article, [attributes: attributes]) do
      {:atomic, :ok} ->
        Mnesia.add_table_index(Article, :ẗitle)
      {:aborted, {:already_exists, Article}} ->
        case Mnesia.table_info(Article, :attributes) do
          [:id, :title, :link, :published_at, :description, :content] ->
            :ok
          other ->
            {:error, other}
        end
    end
  end
end
