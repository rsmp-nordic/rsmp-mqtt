defmodule RSMP.MixProject do
  use Mix.Project

  def project do
    [
      app: :rsmp,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {RSMP.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:emqtt, github: "emqx/emqtt", system_env: [{"BUILD_WITHOUT_QUIC", "1"}]}
    ]
  end
end
