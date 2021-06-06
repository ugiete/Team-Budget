defmodule TeamBudgetGraphql.Middlewares.SetTeam do
  @moduledoc """
  Authorization middleware
  """
  @behaviour Absinthe.Middleware

  def call(resolution, _role) do
    if Map.get(resolution.context, :team) |> is_nil() do
      Absinthe.Resolution.put_result(resolution, {:error, "Please take a valid team"})
    else
      resolution
    end
  end

  # defp current_role?(%{}, :any), do: true
  # defp current_role?(%{role: "admin"}, :admin), do: true
  # defp current_role?(%{role: "user"}, :user), do: true
  # defp current_role?(%{role: role}, role), do: true
  # defp current_role?(_, _), do: false
end
