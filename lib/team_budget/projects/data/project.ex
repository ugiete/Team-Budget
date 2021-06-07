defmodule TeamBudget.Projects.Data.Project do
  use Ecto.Schema
  import Ecto.Changeset
  alias TeamBudget.Util.CreateSlug
  alias TeamBudget.Teams.Data.Team

  @fields ~w[name description budget team_id]a

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "projects" do
    field :budget, :decimal
    field :description, :string
    field :name, :string
    field :slug, :string
    belongs_to :team, Team

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, @fields)
    |> validate_required(@fields)
    |> unique_constraint(:name)
    |> CreateSlug.create(:name)
    |> unique_constraint(:slug)
  end
end
