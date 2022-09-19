defmodule BackendAppFeirinhaWeb.UserControllerTest do
  use BackendAppFeirinhaWeb.ConnCase

  import BackendAppFeirinha.UsersFixtures

  alias BackendAppFeirinha.Users.User
  alias BackendAppFeirinha.Repo

  @sign_in_attrs %{
    email: "dickson@email.com",
    password: "1234567"
  }
  @create_attrs %{
    email: "some email",
    name: "some name",
    password: "some password_hash"
  }
  @update_attrs %{
    email: "some updated email",
    name: "some updated name"
  }
  @invalid_attrs %{email: nil, id: nil, name: nil, password_hash: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "register user" do
    test "renders a created user when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["user"]

      assert %User{email: "some email", name: "some name"} = Repo.get(User, id)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    @tag :authenticated
    test "returns 200 when updates a user when data is valid", %{
      conn: conn,
      user: %User{id: id}
    } do
      conn = put(conn, Routes.user_path(conn, :update, id), %{user: @update_attrs})
      assert %{"id" => ^id} = json_response(conn, 200)["user"]

      assert %User{
               email: "some updated email",
               name: "some updated name"
             } = Repo.get(User, id)
    end
  end

  describe "delete user" do
    setup [:create_user]

    @tag :authenticated
    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, Routes.user_path(conn, :delete, user))
      assert response(conn, 204)
    end
  end

  defp create_user(_) do
    user = user_fixture()
    %{user: user}
  end

  describe "Sign in" do
    setup [:create_user]

    test "sign in a user with valid data", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :sign_in), @sign_in_attrs)
      assert %{"token" => token} = json_response(conn, 200)
    end
  end
end
