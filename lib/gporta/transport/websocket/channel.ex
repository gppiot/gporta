defmodule Gporta.Transport.Websocket.Channel do
  use PhoenixChannelClient
  require Logger

  def handle_in(event, message, state) do
    req_id = message["req_id"]
    message_back = %{nonce: Base.encode16(:crypto.strong_rand_bytes(16)), req_id: req_id}
    Logger.warn "event: #{inspect event}, message: #{inspect message}"
    Logger.warn "send pong back with #{inspect message_back}"
    spawn(fn ->
      Gporta.Channel.push("pong", message_back)
    end)
    {:noreply, state}
  end


  #def handle_in("proxy", %{"request" => "subscribe", "params" => "backend"}, state) do
  #  BtStackProxy.subscribe(:backend)
  #  {:noreply, state}
  #end

  #def handle_in("proxy", %{"request" => ["handle_backend_event", "receive_data"], "params" => params}, state) do
  #  BtStackProxy.handle_backend_event({:receive_data, params})
  #  {:noreply, state}
  #end

  def handle_close(reason, state) do
    Logger.error "recieved handle_close with reason #{inspect reason}"
    {:noreply, state}
  end
end
