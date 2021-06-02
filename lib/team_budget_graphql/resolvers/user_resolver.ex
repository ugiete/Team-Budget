defmodule TeamBudgetGraphql.Resolvers.UserResolver do
  @moduledoc """
  API resolvers
  """
  alias TeamBudget.Accounts

  def list_users(_parent, _params, _resolutions) do
    {:ok, Accounts.list_users()}
  end
end
