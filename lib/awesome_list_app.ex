defmodule AwesomeListApp do
  @moduledoc """
  AwesomeListApp keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  def update_and_create_category do
    with {:ok, body} <- AwesomeListApp.Aggregate.get_readme(),
         {:ok, parser} <- AwesomeListApp.Aggregate.parse_readme(body) do
      body
      |> Enum.map(fn x ->
        nil
      end)
    end
  end
end
