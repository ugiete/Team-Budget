defmodule TeamBudgetGraphql.Resolvers.UserResolver do
  @moduledoc """
  API resolvers
  """
  def list_users(_parent, _params, _resolutions) do
    {:ok, %{}}
  end
end
