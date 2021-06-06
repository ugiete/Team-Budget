defmodule TeamBudget.Invites.Server.SendEmail do
  import Bamboo.Email
  alias TeamBudget.Mailer

  def send({:ok, invites} = context) do
    Enum.each(invites, &create_email/1)

    context
  end

  defp create_email(%{
         email: email,
         email_has_account: has_account,
         team: %{slug: team_slug, name: team_name},
         user: %{email: user_email}
       }) do
    Task.async(fn ->
      new_email()
      |> from({"Elxpro TeamBudget", "admin@email.com"})
      |> to(email)
      |> subject("[ELXPRO TeamBudget] - You were invited to join to a team #{team_slug}")
      |> add_body(team_name, user_email, has_account)
      |> Mailer.deliver_now()
    end)
  end

  defp add_body(email, team_name, user_email, false) do
    html_body(email, """
    You were invited to join #{team_name} by #{user_email}
    <p>Create account with Graphql</p>
    """)
  end

  defp add_body(email, team_name, user_email, true) do
    html_body(email, """
    You were invited to join #{team_name} by #{user_email}
    """)
  end
end
