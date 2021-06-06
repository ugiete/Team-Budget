defmodule TeamBudget.Accounts.Core.UserRepo do
  @moduledoc """
  Connection to Database core api
  """
  alias TeamBudget.Accounts.Data.User
  alias TeamBudget.Repo

  def list_users() do
    Repo.all(User)
  end

  def create_user(user) do
    user |> User.changeset() |> Repo.insert()
  end

  def get_by_email(email) do
    Repo.get_by(User, email: email)
  end

  def get_by_id(id) do
    Repo.get(User, id)
  end
end
