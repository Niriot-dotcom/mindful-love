defmodule Mindfullove.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MindfulloveWeb.Telemetry,
      Mindfullove.Repo,
      {DNSCluster, query: Application.get_env(:mindfullove, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Mindfullove.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Mindfullove.Finch},
      # Start a worker by calling: Mindfullove.Worker.start_link(arg)
      # {Mindfullove.Worker, arg},
      # Start to serve requests, typically the last entry
      MindfulloveWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Mindfullove.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MindfulloveWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
