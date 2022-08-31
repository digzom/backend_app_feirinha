defmodule BackendAppFeirinhaWeb.ListController do
  use BackendAppFeirinhaWeb, :controller

  alias BackendAppFeirinha.Lists
  alias BackendAppFeirinha.Lists.List
  alias BackendAppFeirinha.Repo

  action_fallback BackendAppFeirinhaWeb.FallbackController

  def index(conn, _params) do
    lists = Lists.list_list()
    render(conn, "index.json", lists: lists)
  end

  def create(conn, list_params) do
    IO.inspect(list_params, label: "List")

    with {:ok, %List{} = list} <- Lists.create_list(list_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.list_path(conn, :show, list))
      |> render("show.json", list: list)
    end
  end

  def show(conn, %{"id" => id}) do
    list = Lists.get_list!(id)
    render(conn, "show.json", list: list)
  end

  def update(conn, %{"id" => id} = list_params) do
    list = Lists.get_list!(id)

    with {:ok, %List{} = list} <- Lists.update_list(list, list_params) do
      render(conn, "show.json", list: list)
    end
  end

  def delete(conn, %{"id" => id}) do
    list = Lists.get_list!(id)

    with {:ok, %List{}} <- Lists.delete_list(list) do
      send_resp(conn, :no_content, "")
    end
  end

  def add_item(conn, %{"list_id" => list_id} = list_item_params) do
    list =
      list_id
      |> Lists.get_list!()
      |> Repo.preload([:list_item])
  end
end
