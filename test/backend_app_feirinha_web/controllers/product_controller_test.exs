defmodule BackendAppFeirinhaWeb.ProductControllerTest do
  use BackendAppFeirinhaWeb.ConnCase

  import BackendAppFeirinha.ProductsFixtures

  alias BackendAppFeirinha.Products.Product
  alias BackendAppFeirinha.Repo

  @create_attrs %{
    category: [],
    description: "some description",
    name: "some name"
  }
  @update_attrs %{
    category: [],
    description: "some updated description",
    name: "some updated name"
  }
  @invalid_attrs %{category: nil, description: nil, name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    @tag :authenticated
    test "lists all products", %{conn: conn} do
      conn = get(conn, Routes.product_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create product" do
    @tag :authenticated
    test "renders product when data is valid", %{conn: conn} do
      conn = post(conn, Routes.product_path(conn, :create), @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      assert %Product{
               id: ^id,
               category: [],
               description: "some description",
               name: "some name"
             } = Repo.get(Product, id)
    end

    test "renders 401 error when is unauthenticated", %{conn: conn} do
      conn = post(conn, Routes.product_path(conn, :create), @create_attrs)

      assert %{resp_body: body} = conn
      assert body =~ "unauthenticated"
    end

    @tag :authenticated
    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.product_path(conn, :create), @invalid_attrs)
      assert json_response(conn, 400)["message"] !== %{}
    end
  end

  describe "update product" do
    setup [:create_product]

    @tag :authenticated
    test "renders product when data is valid", %{conn: conn, product: %Product{id: id} = product} do
      conn = put(conn, Routes.product_path(conn, :update, product), @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      assert %Product{
               id: ^id,
               category: [],
               description: "some updated description",
               name: "some updated name"
             } = Repo.get(Product, id)
    end

    test "renders 401 error when is unauthenticated", %{conn: conn, product: product} do
      conn = put(conn, Routes.product_path(conn, :update, product), @update_attrs)

      assert %{resp_body: body} = conn
      assert body =~ "unauthenticated"
    end

    @tag :authenticated
    test "renders errors when data is invalid", %{conn: conn, product: product} do
      conn = put(conn, Routes.product_path(conn, :update, product), @invalid_attrs)
      assert json_response(conn, 400)["message"] !== %{}
      assert json_response(conn, 400)["message"] !== nil
      assert json_response(conn, 400)["errors"] === nil
    end
  end

  describe "delete product" do
    setup [:create_product]

    @tag :authenticated
    test "deletes chosen product", %{conn: conn, product: product} do
      conn = delete(conn, Routes.product_path(conn, :delete, product))
      assert response(conn, 204)

      assert Repo.get(Product, product.id) == nil
    end

    test "renders 401 error when is unauthenticated", %{conn: conn, product: product} do
      conn = delete(conn, Routes.product_path(conn, :update, product))

      assert %{resp_body: body} = conn
      assert body =~ "unauthenticated"
    end
  end

  defp create_product(_) do
    product = product_fixture()
    %{product: product}
  end
end
