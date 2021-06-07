defmodule TeamBudgetGraphql.Resolvers.PermissionResolver do
  alias TeamBudget.Permissions

  def create_permission(_parent, %{permission: permission}, _resolution) do
    Permissions.create_permission(permission)
  end

  def list_permissions(_parent, _params, _resolution) do
    {:ok, Permissions.list_permission()}
  end
end
