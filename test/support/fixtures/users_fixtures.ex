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

      })
      |> BackendAppFeirinha.Users.create_user()

    user
  end
end
