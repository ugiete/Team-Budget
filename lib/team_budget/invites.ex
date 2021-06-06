defmodule TeamBudget.Invites do
  alias TeamBudget.Invites.{Core.CreateInvite, Server.SendEmail}

  def send_invite(invites, current_user, team) do
    invites
    |> CreateInvite.create(current_user, team)
    |> SendEmail.send()
  end
end
