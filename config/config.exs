# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :snl,
  ecto_repos: [Snl.Repo]

# Configures the endpoint
config :snl, SnlWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "2R9nsmMyve2e34MVV8yGOr76V+Xq5rVYXAMMKHcPZ6YMANm8iJQ0cxsRFPjhymJd",
  render_errors: [view: SnlWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Snl.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
