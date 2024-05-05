defmodule BanditSse.MixProject do
  use Mix.Project

  def project do
    [
      app: :bandit_sse,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {BanditSse, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug, "~> 1.15.0"},
      {:plug_cowboy, "~> 2.0"},
      {:bandit, github: "mtrudel/bandit", branch: "no_trap_exit_experiment"},
      # {:bandit, "~> 1.4.0"},
      {:corsica, "~> 2.0.0"}
    ]
  end
end
