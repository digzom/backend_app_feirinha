defmodule BackendAppFeirinha.Lists.List do
  use Ecto.Schema
  import Ecto.Changeset

  schema "list" do
    timestamps()
  end

  @doc false
  def changeset(list, attrs) do
    list
    |> cast(attrs, [])
    |> validate_required([])
  end
end
