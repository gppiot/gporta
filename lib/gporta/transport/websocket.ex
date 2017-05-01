defmodule Gporta.Transport.Websocket do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init([]) do
    children = [
      worker(Gporta.Transport.Websocket.Socket, [])
    ]
    supervise(children, strategy: :one_for_one)
  end
end
