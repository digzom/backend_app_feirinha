defmodule BackendAppFeirinhaWeb.FallbackController do
  use BackendAppFeirinhaWeb, :controller

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(BackendAppFeirinhaWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, %Ecto.Changeset{}} = error) do
    IO.inspect(error)

    conn
    |> put_status(:unprocessable_entity)
    |> put_view(BackendAppFeirinhaWeb.ErrorView)
    |> render(:"422")
  end

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(:unauthorized)
    |> put_view(BackendAppFeirinhaWeb.ErrorView)
    |> render(:"401")
  end

  # def call(conn, {:error, error})
  # IO.inspect(error)

  # conn
  # |> put_status(500)
  # |> put_view(BackendAppFeirinhaWeb.ErrorView)
end
