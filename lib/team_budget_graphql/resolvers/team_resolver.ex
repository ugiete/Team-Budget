defmodule TeamBudgetGraphql.Resolvers.TeamResolver do
  @moduledoc """
  API resolvers
  """
  alias TeamBudget.Teams.Core.TeamRepo

  def list_teams(_, _, %{context: %{current_user: %{id: user_id}}}) do
    {:ok, TeamRepo.list_teams(user_id)}
  end
end
