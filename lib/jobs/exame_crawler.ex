defmodule Jobs.ExameCrawler do
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
    Logger.info("Starting Exame Crawler Job")
    Services.ArticleFetcher.perform(Scraper.Exame)
    schedule_work()
    {:noreply, state}
  end

  defp schedule_work() do
    Logger.info("Scheduling Work for Exame Crawler Job, in " <> Integer.to_string(frequency_minutes()) <> " minutes.")
    Process.send_after(self(), :work, job_frequency()) # In 5 minutes
  end

  defp job_frequency do
    frequency_minutes() * 60 * 1000 # 5 minutes interval
  end

  defp frequency_minutes do
    Utils.env("EXAME_FREQUENCY_MINUTES") |> String.to_integer
  end
end
