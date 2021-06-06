defmodule TeamBudget.Invites.Core.CreateInvite do
  alias TeamBudget.Accounts.Core.UserRepo
  alias TeamBudget.Members.{Core.MemberRepo, Data.Member}

  def create(invites, current_user, team) do
    invites
    |> Enum.map(fn email ->
      user_invited = UserRepo.get_by_email(email)

      email = %{
        email: email,
        user_id: current_user.id,
        team_id: team.id,
        email_has_account: user_invited != nil
      }

      {user_invited, email}
    end)
    |> Enum.reduce(Ecto.Multi.new(), fn {user, invite}, multi ->
      if user != nil do
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
      else
        Ecto.Multi.insert(multi, "invite:#{invite.email}", invite)
      end
    end)

    IO.inspect(current_user)
    IO.inspect(team)

    {:ok, %{}}
  end
end
