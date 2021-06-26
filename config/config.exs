# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :too_short,
  ecto_repos: [TooShort.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :too_short, TooShortWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "T7gWjrn9InNSK36+4PJWtzlj8veYlmfDah0RLlPvMDucd4Ga2DUJedPXMuUITo/d",
  render_errors: [view: TooShortWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: TooShort.PubSub,
  live_view: [signing_salt: "+n70imlH"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
