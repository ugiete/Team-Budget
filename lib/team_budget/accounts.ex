defmodule TeamBudget.Accounts do
  @moduledoc """
  Account endpoint
  """
  alias TeamBudget.Accounts.Core.UserRepo

  def list_users() do
    UserRepo.list_users()
  end

  def create_user(user) do
    UserRepo.create_user(user)
  end
end
