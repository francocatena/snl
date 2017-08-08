defmodule Snl.Repo.Migrations.AddAccountToUsers do
  use Ecto.Migration

  def change do
    if prefix() in [nil, "public"] do
      alter table(:users) do
        add :account_id, references(:accounts, on_delete: :delete_all), null: false
      end

      create index(:users, [:account_id])
    end
  end
end
