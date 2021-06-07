defmodule TeamBudgetGraphql.Resolvers.ProjectResolver do
  alias TeamBudget.Projects

  def create_project(_parent, %{project: project}, %{context: %{team: %{id: team_id}}}) do
    project
    |> Map.put(:team_id, team_id)
    |> Projects.create_project()
  end

  def list_projects(_parent, _params, %{context: %{team: %{id: team_id}}}) do
    {:ok, Projects.list_projects(team_id)}
  end
end
