defmodule AwesomeListApp.Aggregate.HelperRegex do
  def get_stars_from_html(body) do
    Regex.run(~r/repo-stars-counter-star"\s+aria-label=".+"/iu, body)
    |> get_from_run_first_item
    |> String.replace(~r/(repo-stars-counter-star"\s+aria-label="|\suser.+)/iu, "")
    |> to_interger_or_zero
  end

  def get_time_from_body_link_last_commit(body) do
    Regex.run(~r/datetime=".+/, body)
    |> get_from_run_first_item
    |> String.replace(~r/datetime="/, "")
    |> String.replace(~r/".+/, "")
    |> to_date_or_result
  end

  defp to_date_or_result(str) do
    try do
      str |> NaiveDateTime.from_iso8601!()
    rescue
      any -> str
    end
  end

  def to_interger_or_zero(""), do: 0

  def to_interger_or_zero(str), do: String.to_integer(str)

  def get_description_from_library_item(item) do
    Regex.run(~r/\)\s+-\s+.+/, item)
    |> get_from_run_first_item
    |> String.replace(~r/\)\s+-\s+/, "")
  end

  def get_last_commit(body) do
    Regex.run(~r/\/commit\/.+/iu, body)
    |> get_from_run_first_item
    |> String.replace(~r/\">.+/, "")
  end

  def get_from_run_first_item(nil), do: ""

  def get_from_run_first_item([item]), do: item
  def get_from_run_first_item([]), do: ""

  def get_name_str(str) do
    str
    |> String.replace(~r/.+\[/, "")
    |> String.replace(~r/\].+/, "")
  end

  def get_url_library(str) do
    str
    |> String.replace(~r/.+\(/, "")
    |> String.replace(~r/\).+/, "")
  end

  def get_host(str) do
    str
    |> get_url_library()
    |> String.replace(~r/https?:\/\/(?:[^\/ ]*\/)/, "")
  end

  def get_type_repository(body) do
    cond do
      String.match?(body, ~r/github.com/) -> "github"
      String.match?(body, ~r/hexdocs.pm/) -> "hexdocs"
      String.match?(body, ~r/gitlab.com/) -> "gitlab"
      true -> "unkown"
    end
  end
end
