defmodule BackendAppFeirinha.Repo.Migrations.AddUserIdInLists do
  use Ecto.Migration

  def change do
    alter table(:list, primary_key: false) do
      add(:users_id, references(:users, type: :uuid))
    end
  end
end
