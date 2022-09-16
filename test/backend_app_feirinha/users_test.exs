defmodule BackendAppFeirinha.UsersTest do
  use BackendAppFeirinha.DataCase

  alias BackendAppFeirinha.Users

  describe "users" do
    alias BackendAppFeirinha.Users.User

    import BackendAppFeirinha.UsersFixtures

    @valid_attrs %{name: "Dickson", password: "1234567", email: "dicksonmelo@email.com"}
    @invalid_attrs %{}
    @invalid_password_length %{name: "Dickson", password: "12345", email: "dicksonmelo@email.com"}
    @update_attrs %{name: "Sérgio", password: "123456899", email: "dicksonmelo@email.com"}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Users.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Users.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{}} = Users.create_user(@valid_attrs)
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_user(@invalid_attrs)
    end

    test "create_user/1 with invalid password length returns error in password field" do
      {:error, %Ecto.Changeset{errors: [password: {password_message, configs}]}} =
        Users.create_user(@invalid_password_length)

      assert configs = [count: 6, validation: :length, kind: :min, type: :string]
      assert password_message = "should be at least %{count} character(s)"
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()

      assert {:ok, %User{}} = Users.update_user(user, @update_attrs)
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_user(user, @invalid_attrs)
      assert user == Users.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Users.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Users.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Users.change_user(user)
    end
  end
end
