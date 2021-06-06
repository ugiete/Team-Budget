defmodule TeamBudgetGraphql.Resolvers.InviteResolver do
  @moduledoc """
  API resolvers
  """

  def send_invite(_parent, params, _resolutions) do
    IO.inspect(params)
    {:ok, %{}}
  end
end
