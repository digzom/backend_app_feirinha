defmodule BackendAppFeirinha.Lists.List do
  use Ecto.Schema
  import Ecto.Changeset
  alias BackendAppFeirinha.Users.User
  alias BackendAppFeirinha.ListItems.ListItem

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  schema "list" do
    field :name, :string
    has_many :list_item, ListItem
    belongs_to :users, User, type: Ecto.UUID

    timestamps()
  end

  def changeset(list, attrs) do
    list
    |> cast(attrs, [:name, :users_id])
    |> validate_required([:name, :users_id])
  end
end
