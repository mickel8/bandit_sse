defmodule BanditSse do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # {Plug.Cowboy, plug: BanditSse.Router, scheme: :http, port: 5002}
      {Bandit, plug: BanditSse.Router, scheme: :http, port: 5002}
    ]

    Supervisor.start_link(children, strategy: :one_for_all, name: __MODULE__.Supervisor)
  end
end
