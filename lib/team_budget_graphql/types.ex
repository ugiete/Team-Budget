defmodule TeamBudgetGraphql.Types do
  @moduledoc """
  Manager Graphql types
  """
  use Absinthe.Schema.Notation
  alias TeamBudgetGraphql.Types

  import_types(Types.User)
end
