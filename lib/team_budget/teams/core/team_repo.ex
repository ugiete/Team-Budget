defmodule TeamBudget.Teams.Core.TeamRepo do
  import Ecto.Query
  alias TeamBudget.Teams.Data.Team
  alias TeamBudget.Projects.Data.Project
  alias TeamBudget.Repo

  def list_teams(user_id) do
    (team in Team)
    |> from(
      left_join: proj in Project,
      on: proj.team_id == team.id,
      group_by: [team.id],
      where: team.user_id == ^user_id,
      select: %Team{team | total_budget: proj.budget |> sum() |> coalesce("0")}
    )
    |> Repo.all()
  end

  def get_by_user_slug(user_id, slug) do
    Repo.get_by(Team, slug: slug, user_id: user_id)
  end
end
