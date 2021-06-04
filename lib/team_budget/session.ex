defmodule TeamBudget.Session do
  @moduledoc """
  Account endpoint
  """
  alias TeamBudget.Accounts.Core.Session
  # alias TeamBudget.Repo

  def login(user) do
    Session.login(user)
  end
end
