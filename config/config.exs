use Mix.Config

config :team_budget,
  ecto_repos: [TeamBudget.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :team_budget, TeamBudgetWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "MgfSt0fiWb+DKfXp34s++0n4PoYeMkKVkLJHcCMTWUIch6CGUWLocxeUqrDGwbgy",
  render_errors: [view: TeamBudgetWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: TeamBudget.PubSub,
  live_view: [signing_salt: "/efRAt8o"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
