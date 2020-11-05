# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :timemanager,
  namespace: TimeManager,
  ecto_repos: [TimeManager.Repo]

# Configures the endpoint
config :timemanager, TimeManagerWeb.Endpoint,
  url: [host: "0.0.0.0"],
  secret_key_base: "UtC8tU9/LZQRlx8qpPWpRJxAAuaxc7bB246uY2Yz75n1kF+frWQYI/gjO7OiHo2f",
  render_errors: [view: TimeManagerWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: TimeManager.PubSub,
  live_view: [signing_salt: "txkBWsai"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :mime, :types, %{
  "application/vnd.api+json" => ["json-api"]
}

config :phoenix, :format_encoders,
  "json-api": Poison

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
