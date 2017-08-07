defmodule Snl.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    if prefix() in [nil, "public"] do
      create table(:accounts) do
        add :name, :string, null: false
        add :db_prefix, :string, null: false

        timestamps()
      end

      create unique_index(:accounts, [:db_prefix])
    end
  end
end
