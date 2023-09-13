# RSMP
An Elixir app to investigate the possibility of building RSMP 4 on top of MQTT.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `rsmp4` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:rsmp4, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/rsmp4>.


## Broker
Run the EMQX MQTT broker in a docker container, from https://www.emqx.io:

docker run -d --name emqx -p 1883:1883 -p 8083:8083 -p 8084:8084 -p 8883:8883 -p 18083:18083 emqx/emqx

## MQTT library
EXMQTT is an Elixir wrapper around the emqtt Erlang MQTT library:
https://github.com/ryanwinchester/exmqtt



