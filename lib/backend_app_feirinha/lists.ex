defmodule BackendAppFeirinha.Lists do
  import Ecto.Query, warn: false
  alias BackendAppFeirinha.Repo

  alias BackendAppFeirinha.Lists.List
  alias BackendAppFeirinha.ListItems

  def list_list, do: Repo.all(List) |> Repo.preload([:users, list_item: [:list, :product]])

  def get_list!(id), do: Repo.get!(List, id) |> Repo.preload([:users, :list_item])

  def create_list(attrs \\ %{}) do
    %List{}
    |> List.changeset(attrs)
    |> Repo.insert()
  end

  def update_list(%List{} = list, attrs) do
    list
    |> List.changeset(attrs)
    |> Repo.update()
  end

  def delete_list(%List{} = list) do
    Repo.delete(list)
  end

  def change_list(%List{} = list, attrs \\ %{}) do
    List.changeset(list, attrs)
  end

  def add_item(list_id, item_params) do
    item_params
    |> Map.put("list_id", list_id)
    |> ListItems.create_list_item()
  end
end
