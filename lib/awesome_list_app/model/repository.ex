defmodule AwesomeListApp.Model.Repository do
  use Ecto.Schema
  import Ecto.Changeset

  schema "repository" do
    field(:description, :string)
    field(:link, :string)
    field(:link_without_host, :string)
    field(:name, :string)
    field(:stars, :integer)
    field(:timestamp_last_commit, :utc_datetime_usec)
    field(:type, :string)
    field(:category_id, :id)

    timestamps()
  end

  use AwesomeListApp.Use.RepoBase, repo: AwesomeListApp.Repo
  @doc false
  def changeset(repository, attrs) do
    repository
    |> cast(attrs, [
      :name,
      :description,
      :type,
      :stars,
      :timestamp_last_commit,
      :link_without_host,
      :link
    ])
    |> validate_required([
      :name,
      :description,
      :type,
      :stars,
      :timestamp_last_commit,
      :link_without_host,
      :link
    ])
  end
end
