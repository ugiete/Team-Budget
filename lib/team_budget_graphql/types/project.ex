defmodule TeamBudgetGraphql.Types.Project do
  @moduledoc """
  Team type
  """
  use Absinthe.Schema.Notation

  object :project do
    field :id, :string
    field :name, :string
    field :description, :string
    field :slug, :string
    field :budget, :string
  end

  input_object :project_input do
    field :budget, non_null(:string)
    field :description, non_null(:string)
    field :name, non_null(:string)
  end
end
