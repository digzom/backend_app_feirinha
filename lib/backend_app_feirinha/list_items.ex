defmodule BackendAppFeirinha.ListItems do
  import Ecto.Query, warn: false
  alias BackendAppFeirinha.Repo

  alias BackendAppFeirinha.ListItems.ListItem

  def list_list_item do
    Repo.all(ListItem) |> Repo.preload([:list, :product])
  end

  def get_list_item!(id), do: Repo.get!(ListItem, id) |> Repo.preload([:product])

  def create_list_item(attrs \\ %{}) do
    %ListItem{}
    |> ListItem.changeset(attrs)
    |> Repo.insert()
  end

  def update_list_item(%ListItem{} = list_item, attrs) do
    list_item
    |> ListItem.changeset(attrs)
    |> Repo.update()
  end

  def delete_list_item(%ListItem{} = list_item) do
    Repo.delete(list_item)
  end

  def change_list_item(%ListItem{} = list_item, attrs \\ %{}) do
    ListItem.changeset(list_item, attrs)
  end
end
