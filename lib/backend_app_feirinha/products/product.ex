defmodule BackendAppFeirinha.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  @fields [:name, :category, :description]

  schema "products" do
    field :name, :string
    field :category, {:array, :string}
    field :description, :string

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, @fields)
    |> validate_required(@fields)
    |> unique_constraint(:name)
  end
end
