defmodule BackendAppFeirinha.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add(:name, :string, null: false)
      add(:category, {:map, :string})
      add(:description, :text)

      timestamps()
    end

    create(index("products", [:name]))
  end
end
