defmodule Storage.Database do
  use GenServer

  @name :db_connection

  def init(init_arg) do
    {:ok, init_arg}
  end

  def start_link do
    conn = awaits_db_connection(60 * 10_000)
    GenServer.start_link(__MODULE__, conn, name: @name)
  end

  def awaits_db_connection(iterations) do
    connection = Enum.reduce_while(1..iterations, 0, fn _, _acc ->
      case Utils.db_options |> Arangox.start_link do
        {:ok, conn} ->
          {:halt, conn}
        _ ->
          IO.puts("Waiting database connection...")
          Process.sleep(1000)
          {:cont, "Unable to connect with database."}
      end
    end)
    IO.inspect(connection)
  end

  def conn, do: GenServer.call(@name, :read)

  def handle_call(:read, _from, value), do: {:reply, value, value}
end
