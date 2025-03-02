defmodule Namakemonosocial.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      NamakemonosocialWeb.Telemetry,
      Namakemonosocial.Repo,
      {DNSCluster, query: Application.get_env(:namakemonosocial, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Namakemonosocial.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Namakemonosocial.Finch},
      # Start a worker by calling: Namakemonosocial.Worker.start_link(arg)
      # {Namakemonosocial.Worker, arg},
      # Start to serve requests, typically the last entry
      NamakemonosocialWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Namakemonosocial.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    NamakemonosocialWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
