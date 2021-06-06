defmodule TeamBudget.Teams.Core.TeamRepo do
  import Ecto.Query
  alias TeamBudget.Teams.Data.Team
  alias TeamBudget.Repo

  def list_teams(user_id) do
    (team in Team)
    |> from(where: team.user_id == ^user_id, select: team)
    |> Repo.all()
  end

  def get_by_user_slug(user_id, slug) do
    Repo.get_by(Team, slug: slug, user_id: user_id)
  end
end
