defmodule BackendAppFeirinha.Repo.Migrations.CreateListItem do
  use Ecto.Migration

  def change do
    create table(:list_item) do

      timestamps()
    end
  end
end
