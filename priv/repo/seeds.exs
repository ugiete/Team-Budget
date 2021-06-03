alias TeamBudget.{Accounts.User, Repo}

%{
  first_name: "Name",
  last_name: "Surname",
  email: "example@email.com",
  password_hash: "pswd@123"
}
|> User.changeset()
|> Repo.insert()
|> IO.inspect()
