defmodule BackendAppFeirinhaWeb.UserControllerTest do
  use BackendAppFeirinhaWeb.ConnCase

  import BackendAppFeirinha.UsersFixtures

  alias BackendAppFeirinha.Users.User

  @create_attrs %{
    email: "some email",
    name: "some name",
    password: "some password_hash"
  }
  @update_attrs %{
    email: "some updated email",
    id: "7488a646-e31f-11e4-aace-600308960668",
    name: "some updated name",
    password_hash: "some updated password_hash"
  }
  @invalid_attrs %{email: nil, id: nil, name: nil, password_hash: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "register user" do
    test "renders a created user when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["user"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    @tag :authenticated
    test "renders a updated user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["user"]

      # conn = get(conn, Routes.user_path(conn, :show, id))

      # assert %{
      #          "id" => ^id,
      #          "email" => "some updated email",
      #          "name" => "some updated name",
      #          "password_hash" => "some updated password_hash"
      #        } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, Routes.user_path(conn, :delete, user))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.user_path(conn, :show, user))
      end
    end
  end

  defp create_user(_) do
    user = user_fixture()
    %{user: user}
  end
end
