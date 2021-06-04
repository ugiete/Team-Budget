defmodule TeamBudgetGraphql.Resolvers.SessionResolver do
  @moduledoc """
  API resolvers
  """
  alias TeamBudget.Session

  def login(_parent, %{user: user}, _resolutions) do
    Session.login(user)
  end
end
