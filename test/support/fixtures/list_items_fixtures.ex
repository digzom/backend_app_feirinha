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

      })
      |> BackendAppFeirinha.ListItems.create_list_item()

    list_item
  end
end
