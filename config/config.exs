# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :backend_app_feirinha,
  ecto_repos: [BackendAppFeirinha.Repo]

# Configures the endpoint
config :backend_app_feirinha, BackendAppFeirinhaWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: BackendAppFeirinhaWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: BackendAppFeirinha.PubSub,
  live_view: [signing_salt: "Q+fqFadv"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :backend_app_feirinha, BackendAppFeirinha.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.29",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Guardian
config :backend_app_feirinha, BackendAppFeirinhaWeb.Auth.Guardian,
  issuer: "backend_app_feirinha",
  secret_key: System.get_env("GUARDIAN_SECRET_KEY")

config :backend_app_feirinha, BackendAppFeirinhaWeb.Auth.Pipeline,
  module: BackendAppFeirinhaWeb.Auth.Guardian,
  error_handler: BackendAppFeirinhaWeb.Auth.ErrorHandler

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
