defmodule BackendAppFeirinhaWeb.FallbackController do
  use BackendAppFeirinhaWeb, :controller

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(BackendAppFeirinhaWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, %Ecto.Changeset{}} = result) do
    conn
    |> put_status(:bad_request)
    |> put_view(BackendAppFeirinhaWeb.ErrorView)
    |> render("400.json", result: result)
  end

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(:unauthorized)
    |> put_view(BackendAppFeirinhaWeb.ErrorView)
    |> render(:"401")
  end
end
