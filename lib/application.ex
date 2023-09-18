defmodule RSMP.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      RSMP
    ]

    opts = [strategy: :one_for_one, name: RSMP.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
