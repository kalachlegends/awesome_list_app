defmodule AwesomeListApp.Model.CategoryRepo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "category" do
    field(:title, :string)

    has_many(:list_repo, AwesomeListApp.Model.Repository,
      foreign_key: :category_id,
      preload_order: [desc: :stars]
    )

    timestamps()
  end

  use AwesomeListApp.Use.RepoBase, repo: AwesomeListApp.Repo
  @doc false
  def changeset(category_repo, attrs) do
    category_repo
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
