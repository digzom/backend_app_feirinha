defmodule BackendAppFeirinha.ListItemsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BackendAppFeirinha.ListItems` context.
  """

  @doc """
  Generate a list_item.
  """
  def list_item_fixture(attrs \\ %{}) do
    {:ok, list_item} =
      attrs
      |> Enum.into(%{
        item_qtd: 4,
        brand: "Limpol",
        product_id: "bf0d17de-d600-46a2-a02d-57d8bacd1191",
        list_id: 2
      })
      |> BackendAppFeirinha.ListItems.create_list_item()

    list_item
  end
end
