defmodule BackendAppFeirinhaWeb.UserController do
  use BackendAppFeirinhaWeb, :controller

  alias BackendAppFeirinha.Users
  alias BackendAppFeirinha.Users.User
  alias BackendAppFeirinhaWeb.Auth.Guardian

  action_fallback BackendAppFeirinhaWeb.FallbackController

  def index(conn, _params) do
    users = Users.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, user_params) do
    with {:ok, user} <- Users.create_user(user_params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", %{user: user, token: token})
    end
  end

  def sign_in(conn, %{"email" => email} = params) do
    user = Users.get_user_by_email(email)

    with {:ok, token} <-
           Guardian.authenticate(params) do
      conn
      |> put_status(:ok)
      |> render("sign_in.json", %{token: token, user: user})
    end
  end

  def show(conn, %{"id" => id} = params) do
    IO.inspect(params)
    user = Users.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id} = user_params) do
    user = Users.get_user!(id)

    with {:ok, %User{} = user} <- Users.update_user(user, user_params) do
      render(conn, "show_updated_user.json", %{user: user})
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Users.get_user!(id)

    with {:ok, %User{}} <- Users.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
