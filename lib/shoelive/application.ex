defmodule Shoelive.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {DNSCluster, query: Application.get_env(:shoelive, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Shoelive.PubSub},
      # Start a worker by calling: Shoelive.Worker.start_link(arg)
      # {Shoelive.Worker, arg},
      # Start to serve requests, typically the last entry
      ShoeliveWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Shoelive.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ShoeliveWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
