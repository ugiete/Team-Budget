defmodule TeamBudget.Util.CreateSlug do
  @moduledoc """
  Create slug util module
  """

  def create(%Ecto.Changeset{changes: changes} = changeset, field) do
    slug = changes |> Map.get(field) |> Slug.slugify()
    changes = Map.put(changes, :slug, slug)
    %Ecto.Changeset{changeset | changes: changes}
  end
end
