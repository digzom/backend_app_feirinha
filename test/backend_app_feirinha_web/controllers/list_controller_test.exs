defmodule BackendAppFeirinhaWeb.ListControllerTest do
  use BackendAppFeirinhaWeb.ConnCase

  import BackendAppFeirinha.ListsFixtures
  alias BackendAppFeirinha.Lists.List

  @create_attrs %{
    name: "some name"
  }
  @update_attrs %{
    id: "7488a646-e31f-11e4-aace-600308960668",
    name: "some updated name"
  }

  @invalid_attrs %{id: nil, name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  @tag :authenticated
  describe "index" do
    test "lists all lists", %{conn: conn} do
      conn = get(conn, Routes.list_path(conn, :index))
      assert json_response(conn, 200)[:data] == []
    end
  end

  @tag :authenticated
  describe "create list" do
    test "renders list when data is valid", %{conn: conn} do
      %{"sub" => id} = Guardian.Plug.current_claims(conn)

      create_attrs = Map.put(@create_attrs, :users_id, id)

      conn = post(conn, Routes.list_path(conn, :create), name: "lista", users_id: id)
    end

    @tag :authenticated
    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.list_path(conn, :create), list: @invalid_attrs)
      assert json_response(conn, 400)["errors"] != %{}
    end
  end

  @tag :authenticated
  describe "update list" do
    setup [:create_list]

    test "renders list when data is valid", %{conn: conn, list: %List{id: id} = list} do
      conn = put(conn, Routes.list_path(conn, :update, list), list: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)[:data]

      conn = get(conn, Routes.list_path(conn, :show, id))

      assert %{
               "id" => "7488a646-e31f-11e4-aace-600308960668",
               "name" => "some updated name"
             } = json_response(conn, 200)[:data]
    end

    test "renders errors when data is invalid", %{conn: conn, list: list} do
      conn = put(conn, Routes.list_path(conn, :update, list), list: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  @tag :authenticated
  describe "delete list" do
    setup [:create_list]

    test "deletes chosen list", %{conn: conn, list: list} do
      conn = delete(conn, Routes.list_path(conn, :delete, list))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.list_path(conn, :show, list))
      end
    end
  end

  defp create_list(_) do
    list = list_fixture()
    %{list: list}
  end
end
