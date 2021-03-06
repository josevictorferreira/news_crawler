defmodule Jobs.InfomoneyCrawler do
  require Logger
  use GenServer

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    schedule_work()
    {:ok, state}
  end

  def handle_info(:work, state) do
    Logger.info("Starting InfoMoney Crawler Job")
    Services.ArticleFetcher.perform(Scraper.Infomoney)
    schedule_work()
    {:noreply, state}
  end

  defp schedule_work() do
    Logger.info("Scheduling Work for InfoMoney Crawler Job, in " <> Integer.to_string(frequency_minutes()) <> " minutes.")
    Process.send_after(self(), :work, job_frequency())
  end

  defp job_frequency do
    frequency_minutes() * 60 * 1000
  end

  defp frequency_minutes do
    Utils.env("INFOMONEY_FREQUENCY_MINUTES") |> String.to_integer
  end
end
