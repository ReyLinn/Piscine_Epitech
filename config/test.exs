use Mix.Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :timemanager, TimeManager.Repo,
username: "postgres",
password: "postgres",
database: "timemanager_dev",
hostname: "localhost",
show_sensitive_data_on_connection_error: true,
pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :timemanager, TimeManagerWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
