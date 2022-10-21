defmodule BackendAppFeirinha.ListsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BackendAppFeirinha.Lists` context.
  """

  @doc """
  Generate a list.
  """
  import BackendAppFeirinha.ListItemsFixtures
  alias BackendAppFeirinha.Lists.List
  alias BackendAppFeirinha.Lists
  alias BackendAppFeirinha.Users.User
  import BackendAppFeirinha.UsersFixtures

  def list_fixture(attrs \\ %{}) do
    %User{id: id} = user_fixture()

    {:ok, list} =
      attrs
      |> Enum.into(%{
        id: "cafb3f17-ec0a-458a-8083-595ff0a22329",
        name: "Compras",
        users_id: id
      })
      |> Lists.create_list()

    # list_item = list_item_fixture()
    list
  end
end
