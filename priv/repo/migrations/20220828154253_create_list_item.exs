defmodule BackendAppFeirinha.Repo.Migrations.CreateListItem do
  use Ecto.Migration

  def change do
    create table(:list_item) do
      add(:item_qtd, :integer)
      add(:brand, :string)
      add(:product_id, references(:products))
      add(:list_id, references(:list))

      timestamps()
    end
  end
end
