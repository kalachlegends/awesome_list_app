defmodule AwesomeListApp.Aggregate do
  alias AwesomeListApp.Aggregate.GithubHelper
  import AwesomeListApp.Aggregate.HelperRegex
  require Logger

  def get_readme do
    url = "#{url_github_raw()}/#{repository_awesome()}/master/README.md"

    with {:ok, %{status_code: 200, body: body}} <- HTTPoison.get(url) do
      {:ok, body}
    end
  end

  def parse_readme(body) do
    category_str =
      Regex.run(~r/- \[Awesome Elixir\]\(#awesome-elixir\)(-.+|\s{5})+/, body) |> hd()

    result =
      Regex.scan(~r/- .+\)/, category_str)
      |> Enum.reduce([], fn category, acc ->
        category_name =
          category
          |> hd()
          |> get_name_str

        list_libraries =
          Regex.scan(~r/## #{category_name}[^#]+/, body)
          |> Enum.map(fn category_body ->
            category_body =
              category_body
              |> hd()

            Regex.scan(~r/\*\s+\[.+/, category_body)
            |> Enum.map(fn library_item ->
              library_item =
                library_item
                |> hd()

              name = library_item |> get_name_str()
              description = library_item |> get_description_from_library_item()

              %{
                "name" => name,
                "description" => description,
                "type" => get_type_repository(library_item),
                "link" => get_url_library(library_item),
                "link_without_host" => get_host(library_item)
              }
              |> get_information_from_sites
            end)
          end)

        acc ++
          [%{"name_category" => category_name, "list_libraries" => List.first(list_libraries)}]
      end)

    {:ok, result}
  end

  def get_information_from_sites(
        %{"type" => "github", "link_without_host" => link_without_host, "name" => name} = item
      ) do
    try do
      with {:ok, %{body: body}} <- GithubHelper.get("/#{link_without_host}") do
        # body |> IO.inspect(label: "lib/awesome_list_app/aggregate/aggregate.ex:62")

        stars = get_stars_from_html(body)
        link_last_commit = get_last_commit(body)

        {:ok,
         Map.merge(item, %{
           "stars" => stars,
           "link_last_commit" => link_last_commit
         })
         |> put_last_commit_information()}
      end
    rescue
      any ->
        Logger.error("ERROR get_information_from_sites #{name}, detatils: #{inspect(any)}")
        {:error, any}
    end
  end

  def put_last_commit_information(
        %{
          "link_last_commit" => link_last_commit,
          "link_without_host" => link_without_host,
          "type" => "github",
          "name" => name
        } = item
      ) do
    try do
      with {:ok, %{body: body}} <- GithubHelper.get("#{link_without_host}/#{link_last_commit}") do
        last_time_commit = body |> get_time_from_body_link_last_commit
        Logger.error("successful PARSE #{name}")
        Map.put(item, "last_time_commit", last_time_commit)
      else
        any -> item
      end
    rescue
      any ->
        Logger.error("ERROR put_last_commit_information #{name}, detatils: #{inspect(any)}")
        item
    end
  end

  def get_information_from_sites({:error, error} = error_item) do
    Logger.error("ERROR with do  detatils: #{inspect(error)}")
    error_item
  end

  def get_information_from_sites(_) do
    Logger.error("ERROR with unkown type error")
    {:error, :unkown_type}
  end

  defp repository_awesome(),
    do:
      Application.get_env(:awesome_list_app, :github_awesome_list_rep, "") ||
        throw("NO SET github_awesome_list_rep in app ")

  defp url_github_raw(),
    do:
      Application.get_env(:awesome_list_app, :github_url_api_raw, "") ||
        throw("NO SET github_url_api_raw in app ")
end
