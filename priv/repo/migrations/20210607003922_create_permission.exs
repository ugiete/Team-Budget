defmodule TeamBudget.Repo.Migrations.CreatePermission do
  use Ecto.Migration

  def change do
    create table(:permission, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :description, :string, null: false
      add :slug, :string, null: false

      timestamps()
    end

    create unique_index(:permission, [:name])
    create unique_index(:permission, [:slug])
  end
end
