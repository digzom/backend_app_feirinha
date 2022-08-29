defmodule BackendAppFeirinha.ListItemsTest do
  use BackendAppFeirinha.DataCase

  alias BackendAppFeirinha.ListItems

  describe "list_item" do
    alias BackendAppFeirinha.ListItems.ListItem

    import BackendAppFeirinha.ListItemsFixtures

    @invalid_attrs %{}

    test "list_list_item/0 returns all list_item" do
      list_item = list_item_fixture()
      assert ListItems.list_list_item() == [list_item]
    end

    test "get_list_item!/1 returns the list_item with given id" do
      list_item = list_item_fixture()
      assert ListItems.get_list_item!(list_item.id) == list_item
    end

    test "create_list_item/1 with valid data creates a list_item" do
      valid_attrs = %{}

      assert {:ok, %ListItem{} = list_item} = ListItems.create_list_item(valid_attrs)
    end

    test "create_list_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ListItems.create_list_item(@invalid_attrs)
    end

    test "update_list_item/2 with valid data updates the list_item" do
      list_item = list_item_fixture()
      update_attrs = %{}

      assert {:ok, %ListItem{} = list_item} = ListItems.update_list_item(list_item, update_attrs)
    end

    test "update_list_item/2 with invalid data returns error changeset" do
      list_item = list_item_fixture()
      assert {:error, %Ecto.Changeset{}} = ListItems.update_list_item(list_item, @invalid_attrs)
      assert list_item == ListItems.get_list_item!(list_item.id)
    end

    test "delete_list_item/1 deletes the list_item" do
      list_item = list_item_fixture()
      assert {:ok, %ListItem{}} = ListItems.delete_list_item(list_item)
      assert_raise Ecto.NoResultsError, fn -> ListItems.get_list_item!(list_item.id) end
    end

    test "change_list_item/1 returns a list_item changeset" do
      list_item = list_item_fixture()
      assert %Ecto.Changeset{} = ListItems.change_list_item(list_item)
    end
  end
end
