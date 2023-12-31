defmodule AwesomeListApp.Repo.Migrations.CreateRepository do
  use Ecto.Migration

  def change do
    create table(:repository) do
      add(:name, :string)
      add(:description, :string)
      add(:type, :string)
      add(:stars, :integer)
      add(:last_time_commit, :utc_datetime_usec)
      add(:link_without_host, :string)
      add(:link, :string)
      add(:category_id, references(:category, on_delete: :nothing))
      add(:link_last_commit, :string)
      timestamps()
    end

    create(index(:repository, [:category_id]))
    create(unique_index(:repository, [:link]))
  end
end
