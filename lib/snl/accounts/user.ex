defmodule Snl.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Snl.Accounts.User


  schema "users" do
    field :email, :string
    field :lastname, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :lastname, :email])
    |> validate_required([:name, :lastname, :email])
    |> validate_format(:email, ~r/.+@.+\..+/)
    |> unique_constraint(:email)
  end
end
