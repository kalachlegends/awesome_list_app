defmodule AwesomeListApp.Repo.Migrations.CreateCategory do
  use Ecto.Migration

  def change do
    create table(:category) do
      add :title, :string

      timestamps()
    end
  end
end
