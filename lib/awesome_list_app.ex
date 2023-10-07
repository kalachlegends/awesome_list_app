defmodule AwesomeListApp do
  require Logger
  import Ecto.Query
  use GenServer
  @time_to_sleep 1000 * 60 * 60 * 24
  defp reset() do
    GenServer.cast(__MODULE__, {:reset})
  end

  def start_link(attrs) do
    GenServer.start_link(__MODULE__, attrs, name: __MODULE__)
  end

  def init(attrs) do
    GenServer.cast(__MODULE__, {:reset})
    {:ok, attrs}
  end

  def handle_cast({:reset}, state) do

    start()
    Process.sleep(@time_to_sleep)
    reset()
    {:noreply, state}
  end

  def start(body_readme \\ nil) do
    Logger.info("STARTING PARSING")

    with {:ok, body} <- get_readme_from_repo_or_another(body_readme),
         {:ok, data} <- AwesomeListApp.Aggregate.parse_readme(body, false) do
      Logger.info("ENDEND PARSING")
      {:ok, data}
    end
  end

  defp get_readme_from_repo_or_another(nil), do: AwesomeListApp.Aggregate.get_readme()

  defp get_readme_from_repo_or_another(another) when is_binary(another), do: {:ok, another}
end
