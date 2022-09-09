defmodule BackendAppFeirinha.ListsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BackendAppFeirinha.Lists` context.
  """

  @doc """
  Generate a list.
  """
  def list_fixture(attrs \\ %{}) do
    BackendAppFeirinha.Users.create_user(%{
      id: "2ac319c8-2a14-486b-882d-ce9074f6a25d",
      name: "Dickson",
      password_hash: "123",
      email: "dickson@email.com"
    })

    {:ok, list} =
      attrs
      |> Enum.into(%{
        name: "Compras",
        users_id: "2ac319c8-2a14-486b-882d-ce9074f6a25d"
      })
      |> BackendAppFeirinha.Lists.create_list()

    list
  end
end
