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
      name: list.name
    }
  end

  def render("add_item.json", %{list: list}) do
    IO.inspect(list)
  end
end
