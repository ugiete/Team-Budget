defmodule TeamBudget.Accounts.Core.Session do
  @moduledoc """
  Sessions core api
  """
  alias TeamBudget.Accounts.Core.{UserRepo, Guardian}

  def login(user) do
    with {:ok, user} <-
           user
           |> get_by_email()
           |> authenticate(user.password),
         do: tokenize(user)
  end

  defp get_by_email(user) do
    UserRepo.get_by_email(user.email)
  end

  defp authenticate(nil, _), do: {:error, "Incorrect login credentials"}

  defp authenticate(user, password) do
    if Argon2.verify_pass(password, user.password_hash) do
      {:ok, user}
    else
      {:error, :unauthorized}
    end
  end

  defp tokenize(user) do
    case Guardian.sign(user) do
      {:ok, token, _} -> {:ok, %{user: user, token: token}}
      {_, _, _} -> {:error, :unauthorized}
    end
  end
end
