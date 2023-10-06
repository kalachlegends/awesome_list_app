defmodule AwesomeListApp.Aggregate.GithubHelper do
  require Logger

  defp host(),
    do:
      Application.get_env(:awesome_list_app, :github_url, "") ||
        throw("NO SET github_url in app ")

  def get(url, params \\ %{}) do
    with {:ok, %{status_code: 200} = item} <-
           HTTPoison.get(
             "#{host()}#{url}",
             [],
             params: params
           ) do
      {:ok, item}
    else
      {:ok, %{status_code: 404}} ->
        {:error, :not_found}

      any ->
        Logger.error("ERROR FROM GITHUPHELPER url: #{url}")
        any
    end
  end
end
