# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :your_url_ex,
  ecto_repos: [YourUrlEx.Repo]

# Configures the endpoint
config :your_url_ex, YourUrlEx.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "nXHQMEc3s5kq7ip+Jnpxc/ZbW6TM5H7vGof4miXVvBvf0e+vj1AfNx7SeQ5nfVIn",
  render_errors: [view: YourUrlEx.ErrorView, accepts: ~w(html json)],
  pubsub: [name: YourUrlEx.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
