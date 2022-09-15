defmodule BackendAppFeirinha.Repo.Migrations.SetEmailAsUnique do
  use Ecto.Migration

  def change do
    create(unique_index(:users, [:email], unique: true))
  end
end
