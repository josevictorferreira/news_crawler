defmodule NewsCrawler do
  def run do
    children = [
      Jobs.InfomoneyCrawler
    ]
    Supervisor.start_link(children, strategy: :one_for_one)
  end
end

NewsCrawler.run
