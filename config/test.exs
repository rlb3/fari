use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :fari, FariWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :argon2_elixir,
  t_cost: 1,
  m_cost: 8

# Configure your database
config :fari, Fari.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "fari_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
