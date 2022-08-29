defmodule BackendAppFeirinha.Lists.List do
  use Ecto.Schema
  import Ecto.Changeset
  alias BackendAppFeirinha.Users.User

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  schema "list" do
    field :name, :string
    belongs_to :users, User

    timestamps()
  end

  @doc false
  def changeset(list, attrs) do
    list
    |> cast(attrs, [:name])
    |> validate_required([])
  end
end
