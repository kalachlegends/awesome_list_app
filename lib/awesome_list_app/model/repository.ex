defmodule AwesomeListApp.Model.Repository do
  use Ecto.Schema
  import Ecto.Changeset

  schema "repository" do
    field(:description, :string)
    field(:link, :string)
    field(:link_without_host, :string)
    field(:name, :string)
    field(:stars, :integer)
    field(:last_time_commit, :utc_datetime_usec)
    field(:type, :string)
    field(:category_id, :id)
    field(:link_last_commit, :string)
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
      :last_time_commit,
      :link_without_host,
      :link,
      :category_id,
      :link_last_commit
    ])
    |> validate_required([
      :name,
      :description,
      :type,
      :stars,
      :link_without_host,
      :link
    ])
  end
end
