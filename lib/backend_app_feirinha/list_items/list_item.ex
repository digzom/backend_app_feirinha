defmodule BackendAppFeirinha.ListItems.ListItem do
  use Ecto.Schema
  # use BackendAppFeirinha.Lists.List
  import Ecto.Changeset

  @fields [:qtd, :integer]
  schema "list_item" do
    timestamps()
  end

  @doc false
  def changeset(list_item, attrs) do
    list_item
    |> cast(attrs, [])
    |> validate_required([])
  end
end
