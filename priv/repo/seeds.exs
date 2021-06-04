alias TeamBudget.{Accounts.User, Repo}

%{
  first_name: "Name",
  last_name: "Surname",
  email: "example@email.com",
  password: "pswd@123",
  password_confirmation: "pswd@123"
}
|> User.changeset()
|> Repo.insert()
|> IO.inspect()
