defmodule Snl.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset
  alias Snl.Accounts.Account


  schema "accounts" do
    field :db_prefix, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Account{} = account, attrs) do
    account
    |> cast(attrs, [:name, :db_prefix])
    |> validate_required([:name, :db_prefix])
    |> validate_length(:name, max: 255)
    |> validate_length(:db_prefix, max: 61)
    |> validate_format(:db_prefix, ~r/^[a-z_][a-z0-9_]*$/)
    |> unique_constraint(:db_prefix)
  end
end
