# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Snl.Repo.insert!(%Snl.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

{:ok, _} = Snl.Accounts.create_user(%{
  name:     "Admin",
  lastname: "Admin",
  email:    "admin@snl.com",
  password: "123456"
})
