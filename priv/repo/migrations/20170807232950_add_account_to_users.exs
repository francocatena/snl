defmodule Snl.Repo.Migrations.AddAccountToUsers do
  use Snl, :migration

  def change do
    unless prefix() do
      alter table(:users) do
        add :account_id, references(:accounts, on_delete: :delete_all), null: false
      end

      create index(:users, [:account_id])
    end
  end
end
