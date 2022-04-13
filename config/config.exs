# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :tec_solfacil_cep_api,
  ecto_repos: [TecSolfacilCepApi.Repo]

# Configures the endpoint
config :tec_solfacil_cep_api, TecSolfacilCepApiWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: TecSolfacilCepApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: TecSolfacilCepApi.PubSub,
  live_view: [signing_salt: "Mem0Zo44"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Config guardian
config :tec_solfacil_cep_api, TecSolfacilCepApi.Guardian,
  issuer: "tec_solfacil_cep_api",
  secret_key: "XWlEqJwR/sgyhuYPPkBGXnviKjz3KQ4gXBs+igUbM7NNDV9OgMqtja89xfoAnx5C"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
