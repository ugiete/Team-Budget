defmodule TeamBudget.Repo.Migrations.CreateRole do
  use Ecto.Migration

  def change do
    create table(:role, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :description, :string, null: false
      add :slug, :string, null: false

      timestamps()
    end

    create unique_index(:role, [:name])
    create unique_index(:role, [:slug])
  end
end
