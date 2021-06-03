defmodule TeamBudget.Accounts do
  @moduledoc """
  Account endpoint
  """
  alias TeamBudget.Accounts.User
  alias TeamBudget.Repo

  def list_users() do
    Repo.all(User)
  end

  def create_user(user) do
    user |> User.changeset() |> Repo.insert()
  end
end
