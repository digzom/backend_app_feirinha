defmodule BackendAppFeirinhaWeb.ListView do
  use BackendAppFeirinhaWeb, :view
  alias BackendAppFeirinhaWeb.ListView

  def render("index.json", %{lists: lists}) do
    %{data: render_many(lists, ListView, "list.json")}
  end

  def render("show.json", %{list: list}) do
    %{data: render_one(list, ListView, "list.json")}
  end

  def render("list.json", %{list: list}) do
    %{
      id: list.id,
      name: list.name,
      insertedAt: list.inserted_at,
      listItems: build_list_item(list)
    }
  end

  def render("add_item.json", %{list: list}) do
    IO.inspect(list)
  end

  def render("show_list_item.json", %{list: list}) do
    render_one(list, ListView, "list.json")
  end

  def build_list_item(list) when not is_list(list.list_item), do: []

  def build_list_item(list) do
    Enum.map(
      list.list_item,
      fn item ->
        %{
          id: item.id,
          brand: item.brand,
          itemQtd: item.item_qtd,
          name: item.product.name,
          productId: item.product_id,
          category: Enum.map(item.product.category, & &1),
          description: item.product.description
        }
      end
    )
  end
end
