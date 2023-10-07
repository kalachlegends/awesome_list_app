defmodule AwesomeListApp.Aggregate.GithubHelper do
  require Logger

  defp host(),
    do:
      Application.get_env(:awesome_list_app, :github_url, "") ||
        throw("NO SET github_url in app ")

  def get(url, params \\ %{}, url_full \\ nil) do
    with {:ok, %{status_code: 200} = item} <-
           HTTPoison.get(
             "#{url_full || host()}#{url}",
             [],
             params: params
           ) do
      {:ok, item}
    else
      {:ok, %{status_code: 404}} ->
        {:error, :not_found}

      {:ok, %{status_code: 301, headers: headers}} ->
        {_, location} = Enum.find(headers, fn head -> head |> elem(0) == "Location" end)

        get(url, params, location)

      any ->
        IO.inspect(any)
        Logger.error("ERROR FROM GITHUPHELPER url: #{url}")
        any
    end
  end
end
