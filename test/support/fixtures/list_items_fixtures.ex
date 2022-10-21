defmodule BackendAppFeirinha.ListItemsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BackendAppFeirinha.ListItems` context.
  """

  @doc """
  Generate a list_item.
  """
  alias BackendAppFeirinha.ListItems.ListItem
  import BackendAppFeirinha.ProductsFixtures

  def list_item_fixture(attrs \\ %{}) do
    %{id: product_id} = product_fixture()

    {:ok, list_item} =
      attrs
      |> Enum.into(%{
        item_qtd: 4,
        brand: "Limpol",
        product_id: product_id,
        list_id: "cafb3f17-ec0a-458a-8083-595ff0a22329"
      })
      |> BackendAppFeirinha.ListItems.create_list_item()

    list_item
  end
end
