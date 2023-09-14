# About
An Elixir app to investigate the possibility of building RSMP 4 on top of MQTT.

## Prerequisites
Elixir >= 1.15.

To install dependencies:
```shell
% mix deps.get
```

## Runnning
```shell
% mix run
```

## Broker
Run the EMQX MQTT broker in a docker container, from https://www.emqx.io:

docker run -d --name emqx -p 1883:1883 -p 8083:8083 -p 8084:8084 -p 8883:8883 -p 18083:18083 emqx/emqx

## MQTT library
EXMQTT is an Elixir wrapper around the emqtt Erlang MQTT library:
https://github.com/ryanwinchester/exmqtt



