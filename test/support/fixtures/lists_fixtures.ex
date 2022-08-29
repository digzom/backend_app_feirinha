defmodule BackendAppFeirinha.ListsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BackendAppFeirinha.Lists` context.
  """

  @doc """
  Generate a list.
  """
  def list_fixture(attrs \\ %{}) do
    {:ok, list} =
      attrs
      |> Enum.into(%{

      })
      |> BackendAppFeirinha.Lists.create_list()

    list
  end
end
