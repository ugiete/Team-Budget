defmodule TeamBudget.Accounts.User do
  @moduledoc """
  Users accounts context
  """
  use Ecto.Schema
  import Ecto.Changeset

  @fields ~w[email first_name last_name password password_confirmation]a

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :role, :string, default: "user"

    timestamps()
  end

  @doc false
  def changeset(attrs \\ %{}) do
    changeset(%__MODULE__{}, attrs)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @fields)
    |> validate_required(@fields)
    |> unique_constraint(:email)
    |> validate_format(:email, ~r{@}, message: "Invalid email")
    |> update_change(:email, &String.downcase/1)
    |> validate_length(:password, min: 8, max: 32)
    |> validate_confirmation(:password, message: "Passwords not match")
    |> hash_password()
  end

  def hash_password(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    changeset(changeset, Argon2.add_hash(password))
  end
end
