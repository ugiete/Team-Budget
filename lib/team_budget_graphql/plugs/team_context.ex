defmodule TeamBudgetGraphql.Plugs.TeamContext do
  @moduledoc """
  Context plug definition
  """
  @behaviour Plug
  import Plug.Conn
  alias TeamBudget.Teams.Core.TeamRepo

  def init(options) do
    options
  end

  def call(conn, _) do
    case context_has_user?(conn) do
      nil ->
        Absinthe.Plug.put_options(conn, context: %{})

      current_user ->
        context = conn |> get_req_header("team") |> get_slug() |> get_team(current_user)
        Absinthe.Plug.put_options(conn, context: context)
    end
  end

  defp context_has_user?(conn) do
    Map.get(conn.private.absinthe.context, :current_user)
  end

  defp get_slug([]), do: nil
  defp get_slug([slug | _]), do: slug

  defp get_team(nil, current_user), do: %{current_user: current_user}

  defp get_team(slug, current_user) do
    team = TeamRepo.get_by_user_slug(current_user.id, slug)
    %{current_user: current_user, team: team}
  end
end
