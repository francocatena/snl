use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :snl, SnlWeb.Endpoint,
  http: [port: 4001],
  server: false

# Gettext config
config :snl, SnlWeb.Gettext, default_locale: "en"

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :snl, Snl.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "snl_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :bcrypt_elixir, log_rounds: 4
