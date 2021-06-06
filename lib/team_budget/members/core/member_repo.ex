defmodule TeamBudget.Members.Core.MemberRepo do
  @moduledoc """
  Connection to Database core api
  """
  alias TeamBudget.{Members.Data.Member, Repo}
  import Ecto.Query

  def is_member_of(user_id, team_id) do
    (member in Member)
    |> from(where: member.user_id == ^user_id and member.team_id == ^team_id)
    |> Repo.exists?()
  end
end
