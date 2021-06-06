defmodule TeamBudgetGraphql.Types.Invite do
  @moduledoc """
  Invite type
  """
  use Absinthe.Schema.Notation

  object :invite do
    field :id, :string
    field :team_id, :string
    field :user_id, :string
    field :email, :string
    field :email_has_account, :boolean
  end
end
