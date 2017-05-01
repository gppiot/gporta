defmodule Gporta.Transport.Websocket.Socket do
  use PhoenixChannelClient.Socket, otp_app: :gporta

  @device_id "ec48e4cf-4ba3-4b75-9114-62920fc802b8"

  def now do
    {:ok, channel} = PhoenixChannelClient.channel(Gporta.Channel, socket: Gporta.Socket , topic: "broker:gpp_device:#{@device_id}")
    Gporta.Channel.join()
  end
end
