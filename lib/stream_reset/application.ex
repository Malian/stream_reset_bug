defmodule StreamReset.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      StreamResetWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: StreamReset.PubSub},
      # Start Finch
      {Finch, name: StreamReset.Finch},
      # Start the Endpoint (http/https)
      StreamResetWeb.Endpoint
      # Start a worker by calling: StreamReset.Worker.start_link(arg)
      # {StreamReset.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: StreamReset.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    StreamResetWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
