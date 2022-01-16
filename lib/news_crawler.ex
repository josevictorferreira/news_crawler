defmodule NewsCrawler do
  require Logger

  def start(_type, _args) do
    children = [
      Jobs.InfomoneyCrawler,
      Jobs.ExameCrawler
    ]
    Logger.info("Initializing News Crawler Application...")
    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
