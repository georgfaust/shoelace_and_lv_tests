import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :shoelive, ShoeliveWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "WYQOxMO8CQkpdnXV8sCj7G691JoytIM3J5/8x2eXqG8H8XFpME4FzKQ/CNCo3xlm",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
