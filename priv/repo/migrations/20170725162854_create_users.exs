defmodule Snl.Repo.Migrations.CreateUsers do
  use Snl, :migration

  def change do
    unless prefix() do
      create table(:users) do
        add :name, :string, null: false
        add :lastname, :string, null: false
        add :email, :string, null: false
        add :password_hash, :string, null: false

        timestamps()
      end

      create unique_index(:users, [:email])
    end
  end
end
