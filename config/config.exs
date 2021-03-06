# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :fari,
  ecto_repos: [Fari.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :fari, FariWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "0/Hm+SmjWjDRjA+omt9IQr3DDfom+OM0zZqKpOY9oShqkwqUG2wsWKG5tPUK0wDm",
  render_errors: [view: FariWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Fari.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
