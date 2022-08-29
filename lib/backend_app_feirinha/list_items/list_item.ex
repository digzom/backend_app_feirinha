defmodule BackendAppFeirinha.ListItems.ListItem do
  use Ecto.Schema
  import Ecto.Changeset
  alias BackendAppFeirinha.Lists.List
  alias BackendAppFeirinha.Products.Product

  schema "list_item" do
    field :item_qtd, :integer
    field :brand, :string
    belongs_to :list, List
    belongs_to :product, Product

    timestamps()
  end

  #

  @doc false
  def changeset(list_item, attrs) do
    list_item
    |> cast(attrs, [:item_qtd, :brand])
    |> validate_required([:item_qtd])
  end
end
