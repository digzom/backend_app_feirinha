defmodule BackendAppFeirinha.ProductsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BackendAppFeirinha.Products` context.
  """

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{

      })
      |> BackendAppFeirinha.Products.create_product()

    product
  end
end
