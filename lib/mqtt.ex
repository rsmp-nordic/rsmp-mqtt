defmodule RSMP.MQTTMessageHandler do
  @behaviour ExMQTT.MessageHandler

  @impl true
  def handle_message(["foo", "bar"], message, _extra) do
    # Matches on "foo/bar"
  end

  def handle_message(["foo", "bar" | _rest], message, _extra) do
    # Matches on "foo/bar/#"
  end

  def handle_message(["baz", buzz], message, _extra) do
    # Matches on "baz/+"
  end

  def handle_message(topic, message, _extra) do
    # Catch-all
  end
end
