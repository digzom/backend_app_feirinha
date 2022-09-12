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
    list_item =
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

    %{
      id: list.id,
      name: list.name,
      insertedAt: list.inserted_at,
      listItems: list_item
    }
  end

  def render("add_item.json", %{list: list}) do
    IO.inspect(list)
  end

  defp build_list_item() do
  end
end
