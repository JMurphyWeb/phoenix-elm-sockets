# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :sockets,
  ecto_repos: [Sockets.Repo]

# Configures the endpoint
config :sockets, Sockets.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "BuS1DEBtGqMvxtDfSfkwESWUS0hQL358R5aeqg+x+L/8vBH9ieN1rNEaSZKtimTl",
  render_errors: [view: Sockets.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Sockets.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
