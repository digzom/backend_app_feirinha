defmodule BackendAppFeirinha.Repo.Migrations.CreateList do
  use Ecto.Migration

  def change do
    create table(:list) do

      timestamps()
    end
  end
end
