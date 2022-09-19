defmodule BackendAppFeirinha.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BackendAppFeirinha.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        name: "Dickson",
        password: "1234567",
        email: "dickson@email.com"
      })
      |> BackendAppFeirinha.Users.create_user()

    Map.put(user, :password, nil)
  end
end
