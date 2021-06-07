defmodule TeamBudgetGraphql.Resolvers.InviteResolver do
  @moduledoc """
  API resolvers
  """
  alias TeamBudget.Invites

  def send_invite(_parent, %{invites: invites}, %{
        context: %{current_user: current_user, team: team}
      }) do
    IO.inspect(team)
    Invites.send_invite(invites, current_user, team)
  end
end
