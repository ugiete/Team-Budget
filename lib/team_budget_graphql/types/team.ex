defmodule TeamBudgetGraphql.Types.Team do
  @moduledoc """
  Team type
  """
  use Absinthe.Schema.Notation

  object :team do
    field :id, :string
    field :name, :string
    field :description, :string
    field :slug, :string
  end

  input_object :team_input do
    field :name, :string
    field :description, :string
  end
end
