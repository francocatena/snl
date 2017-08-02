defmodule Snl.Accounts.UsersTest do
  use Snl.DataCase, async: true

  describe "user" do
    import Comeonin.Bcrypt, only: [checkpw: 2]

    alias Snl.Accounts.User

    @valid_attrs   %{email: "some@email.com", lastname: "some lastname", name: "some name", password: "123456"}
    @invalid_attrs %{email: "wrong@email", lastname: nil, name: nil, password: "123"}

    test "changeset with valid attributes" do
      changeset = User.changeset(%User{}, @valid_attrs)

      assert changeset.valid?
    end

    test "changeset with invalid attributes" do
      changeset = User.changeset(%User{}, @invalid_attrs)

      refute changeset.valid?
    end

    test "changeset does not accept long attributes" do
      attrs =
        @valid_attrs
        |> Map.put(:name, String.duplicate("a", 256))
        |> Map.put(:lastname, String.duplicate("a", 256))
        |> Map.put(:email, String.duplicate("a", 256))
        |> Map.put(:password, String.duplicate("a", 101))

      changeset = User.changeset(%User{}, attrs)

      assert "should be at most 255 character(s)" in errors_on(changeset).name
      assert "should be at most 255 character(s)" in errors_on(changeset).lastname
      assert "should be at most 255 character(s)" in errors_on(changeset).email
      assert "should be at most 100 character(s)" in errors_on(changeset).password
    end

    test "changeset check basic email format" do
      attrs     = Map.put(@valid_attrs, :email, "wrong@email")
      changeset = User.changeset(%User{}, attrs)

      assert "has invalid format" in errors_on(changeset).email
    end

    test "changeset hashes password when present" do
      password  = "supersecret"
      attrs     = Map.put(@valid_attrs, :password, password)
      changeset = User.changeset(%User{}, attrs)

      assert checkpw(password, changeset.changes.password_hash)
    end

    test "changeset ignores blank password" do
      changeset = User.changeset(%User{}, %{@valid_attrs | password: nil})

      assert changeset.valid?
      refute changeset.changes[:password_hash]
    end

    test "create changeset with valid attributes" do
      changeset = User.create_changeset(%User{}, @valid_attrs)

      assert changeset.valid?
    end

    test "create changeset with invalid attributes" do
      changeset = User.create_changeset(%User{}, %{@valid_attrs | password: nil})

      refute changeset.valid?
      assert "can't be blank" in errors_on(changeset).password
    end
  end
end
