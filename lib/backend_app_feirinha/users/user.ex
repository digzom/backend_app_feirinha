defmodule BackendAppFeirinha.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @fields [:name, :password, :email]

  schema "users" do
    field :name, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    field :email, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @fields)
    |> validate_required(@fields)
    |> unique_constraint(:email)
    |> validate_length(:password, min: 6)
    |> encrypt_password()
  end

  def update_user_changeset(user, %{"id" => _id, "user" => user_att}) do
    user
    |> cast(user_att, [:name, :email])
    |> unique_constraint(:email)
  end

  defp encrypt_password(%{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Argon2.add_hash(password))
  end

  defp encrypt_password(changeset), do: changeset
end
