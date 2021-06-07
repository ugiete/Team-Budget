defmodule TeamBudget.Roles.Data.Role do
  use Ecto.Schema
  import Ecto.Changeset
  alias TeamBudget.Util.CreateSlug

  @fields ~w[name description]a

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "role" do
    field :description, :string
    field :name, :string
    field :slug, :string

    timestamps()
  end

  @doc false
  def changeset(role, attrs) do
    role
    |> cast(attrs, @fields)
    |> validate_required(@fields)
    |> unique_constraint(:name)
    |> CreateSlug.create(:name)
    |> unique_constraint(:slug)
  end
end
