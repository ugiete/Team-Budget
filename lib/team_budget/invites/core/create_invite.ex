defmodule TeamBudget.Invites.Core.CreateInvite do
  alias TeamBudget.Repo
  alias TeamBudget.Accounts.Core.UserRepo
  alias TeamBudget.Members.{Core.MemberRepo, Data.Member}
  alias TeamBudget.Invites.Data.Invite

  def create(invites, current_user, team) do
    response =
      invites
      |> create_payload_for_each_invite(current_user.id, team.id)
      |> prepare_to_insert()
      |> store_invites()
      |> build_response()

    {:ok, response}
  end

  defp create_payload_for_each_invite(invites, user_id, team_id) do
    Enum.map(invites, fn email ->
      user_invited = UserRepo.get_by_email(email)

      invite = %Invite{
        email: email,
        user_id: user_id,
        team_id: team_id,
        email_has_account: user_invited != nil
      }

      {user_invited, invite}
    end)
  end

  defp prepare_to_insert(invites) do
    invites
    |> Enum.reduce(Ecto.Multi.new(), fn {user, invite}, multi ->
      prepare_transaction(user, invite, multi)
    end)
  end

  defp prepare_transaction(nil, invite, multi) do
    Ecto.Multi.insert(multi, "invite:#{invite.email}", invite)
  end

  defp prepare_transaction(user, invite, multi) do
    if MemberRepo.is_member_of(user.id, invite.team_id) do
      multi
    else
      multi
      |> Ecto.Multi.insert("associate:#{user.id}-#{invite.email}", %Member{
        user_id: user.id,
        team_id: invite.team_id
      })
      |> Ecto.Multi.insert("invite:#{invite.email}", invite)
    end
  end

  defp store_invites(transaction), do: Repo.transaction(transaction)

  defp build_response({:ok, result}) do
    result
    |> Map.to_list()
    |> Enum.filter(fn {operation, _} -> String.contains?(operation, "invite:") end)
    |> Enum.map(fn {_, invite} -> invite end)
  end
end
