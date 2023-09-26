import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :stream_reset, StreamResetWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "CIR2OU9Ddlj4yoYchyRXTWn/W27A3cC+qpNLWBpmUKIT+WW/a8wJ/JyqzcP9+hHM",
  server: false

# In test we don't send emails.
config :stream_reset, StreamReset.Mailer,
  adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
