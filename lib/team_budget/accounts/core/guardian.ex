defmodule TeamBudget.Accounts.Core.Guardian do
  @moduledoc """
  Guardian token api
  """
  use Guardian, otp_app: :team_budget
  alias TeamBudget.Accounts.Core.UserRepo

  def subject_for_token(user, _claims) do
    sub = to_string(user.id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
    {:ok, UserRepo.get_by_id(id)}
  end

  def sign(user) do
    Guardian.encode_and_sign(__MODULE__, user)
  end

  def verify(token) do
    Guardian.decode_and_verify(__MODULE__, token)
  end
end
