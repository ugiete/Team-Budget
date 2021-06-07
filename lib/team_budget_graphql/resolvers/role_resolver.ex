defmodule TeamBudgetGraphql.Resolvers.RoleResolver do
  alias TeamBudget.Roles

  def create_role(_parent, %{role: role}, _resolution) do
    Roles.create_role(role)
  end

  def list_roles(_parent, _params, _resolution) do
    {:ok, Roles.list_role()}
  end
end
