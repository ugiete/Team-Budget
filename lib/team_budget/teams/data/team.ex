defmodule TeamBudget.Teams.Data.Team do
  use Ecto.Schema
  import Ecto.Changeset
  alias TeamBudget.Accounts.Data.User
  alias TeamBudget.Members.Data.Member
  alias TeamBudget.Util.CreateSlug
  alias TeamBudget.Repo

  @fields ~w[name description user_id]a

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "teams" do
    field :description, :string
    field :name, :string
    field :slug, :string
    belongs_to :user, User
    many_to_many :members, User, join_through: Member, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(attrs \\ %{}) do
    changeset(%__MODULE__{}, attrs)
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, @fields)
    |> validate_required([:name, :description])
    |> CreateSlug.create(:name)
    |> unique_constraint(:name)
    |> unique_constraint(:slug)
  end

  def query(queryable, _params), do: queryable

  def data(), do: Dataloader.Ecto.new(Repo, query: &query/2)
end
