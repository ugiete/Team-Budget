alias TeamBudget.{Accounts.Data.User, Members.Data.Member, Repo}

{:ok, %{id: user_id, teams: [%{id: team_id} | _]}} =
  %{
    first_name: "Name",
    last_name: "Surname",
    email: "example@email.com",
    password: "pswd@123",
    password_confirmation: "pswd@123",
    teams: [
      %{
        name: "Team name",
        description: "Team description",
        projects: [
          %{
            name: "Project name",
            description: "Project description",
            budget: Decimal.new("100000.00")
          }
        ]
      }
    ]
  }
  |> User.changeset()
  |> Repo.insert()

%Member{user_id: user_id, team_id: team_id}
|> Repo.insert()
