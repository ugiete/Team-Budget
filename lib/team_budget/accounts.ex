defmodule TeamBudget.Accounts do
  @moduledoc """
  Account endpoint
  """
  alias TeamBudget.Accounts.User
  alias TeamBudget.Repo

  def list_users() do
    Repo.all(User)
  end
end
