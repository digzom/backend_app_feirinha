defmodule BackendAppFeirinha.Repo.Migrations.CreateList do
  use Ecto.Migration

  def change do
    create table(:list, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:name, :string)

      timestamps()
    end

    create(unique_index(:list, [:name]))
  end
end
