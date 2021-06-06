defmodule TeamBudgetGraphql.Types do
  @moduledoc """
  Manager Graphql types
  """
  use Absinthe.Schema.Notation
  alias TeamBudgetGraphql.Types

  import_types(Types.Session)
  import_types(Types.Team)
  import_types(Types.User)
  import_types(Types.Invite)
end
