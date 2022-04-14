defmodule TecSolfacilCepApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      TecSolfacilCepApi.Repo,
      # Start the Telemetry supervisor
      TecSolfacilCepApiWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: TecSolfacilCepApi.PubSub},
      # Start the Endpoint (http/https)
      TecSolfacilCepApiWeb.Endpoint,
      # Start a worker by calling: TecSolfacilCepApi.Worker.start_link(arg)
      {Finch, name: :tec_solfacil_cep_api},
      # Start the Oban system
      {Oban, oban_config()}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TecSolfacilCepApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Conditionally disable queues or plugins here.
  defp oban_config do
    Application.fetch_env!(:tec_solfacil_cep_api, Oban)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TecSolfacilCepApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
