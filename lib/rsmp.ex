defmodule RSMP do
  @moduledoc false

  use GenServer

  require Logger

  def start_link([]) do
    GenServer.start_link(__MODULE__, [])
  end

  def init([]) do
    interval = Application.get_env(:rsmp, :interval)
    emqtt_opts = Application.get_env(:rsmp, :emqtt)
    id = emqtt_opts[:clientid]
    component = "main"
    module = "system"
    status = "temperature"
    status_topic = "status/#{id}/#{component}/#{module}/#{status}"

    options =
      emqtt_opts ++
        [
          will_topic: "state/#{id}",
          will_payload: :erlang.term_to_binary(0),
          will_retain: true
        ]

    {:ok, pid} = :emqtt.start_link(options)

    state = %{
      interval: interval,
      timer: nil,
      status_topic: status_topic,
      plan: 1,
      pid: pid
    }

    {:ok, set_timer(state), {:continue, :start_emqtt}}
  end

  def handle_continue(:start_emqtt, %{pid: pid} = state) do
    {:ok, _} = :emqtt.connect(pid)
    emqtt_opts = Application.get_env(:rsmp, :emqtt)
    clientid = emqtt_opts[:clientid]

    # subscribe to commands
    {:ok, _, _} = :emqtt.subscribe(pid, {"command/#{clientid}/plan", 1})

    # say hello
    :emqtt.publish(
      pid,
      "state/#{clientid}",
      :erlang.term_to_binary(1),
      retain: true
    )

    {:noreply, state}
  end

  def handle_info(:tick, %{status_topic: _topic, pid: _pid} = state) do
    # status_temperature(pid, topic)
    # {:noreply, set_timer(state)}
    {:noreply, state}
  end

  def handle_info({:publish, publish}, state) do
    # IO.inspect(publish)
    handle_publish(parse_topic(publish), publish, state)
  end

  defp handle_publish(
         ["command", _, "plan" = command],
         %{payload: payload, properties: properties},
         state
       ) do
    new_state = %{state | plan: String.to_integer(payload)}

    pid = state[:pid]
    response_topic = properties[:"Response-Topic"]
    command_id = properties[:"Correlation-Data"]

    Logger.info(
      "Received '#{command}' command #{command_id}: Switching to plan: #{new_state[:plan]}"
    )

    if response_topic && command_id do
      response_message = :ok
      response_payload = :erlang.term_to_binary(response_message)

      properties = %{
        "Correlation-Data": command_id
      }

      {:ok, _pkt_id} =
        :emqtt.publish(
          # Client
          pid,
          # Topic
          response_topic,
          # Properties
          properties,
          # Payload
          response_payload,
          # Opts
          retain: false,
          qos: 1
        )
    end

    # {:noreply, set_timer(new_state)}
    {:noreply, new_state}
  end

  defp handle_publish(_, _, state) do
    {:noreply, state}
  end

  defp parse_topic(%{topic: topic}) do
    String.split(topic, "/", trim: true)
  end

  defp set_timer(state) do
    if state.timer do
      Process.cancel_timer(state.timer)
    end

    timer = Process.send_after(self(), :tick, state.interval)
    %{state | timer: timer}
  end
end
