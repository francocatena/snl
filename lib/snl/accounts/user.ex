defmodule Snl.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Snl.Accounts.User


  schema "users" do
    field :email, :string
    field :lastname, :string
    field :name, :string
    field :password_hash, :string
    field :password, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :lastname, :email, :password])
    |> validate_required([:name, :lastname, :email])
    |> validate_format(:email, ~r/.+@.+\..+/)
    |> validate_length(:password, min: 6, max: 100)
    |> unique_constraint(:email)
    |> put_password_hash()
  end

  @doc false
  def create_changeset(%User{} = user, attrs) do
    user
    |> changeset(attrs)
    |> validate_required([:password])
  end

  defp put_password_hash(%{valid?: true, changes: %{password: password}} = changeset) do
    put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(password))
  end

  defp put_password_hash(changeset), do: changeset
end
