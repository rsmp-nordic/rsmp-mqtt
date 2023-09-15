# About
An Elixir app to investigate the possibility of building RSMP 4 on top of MQTT.

## Prerequisites
Elixir >= 1.15.

NOTE: The emqtt libriary is currently incompatible with the latest Erlang OTP 26. Instead you must install Erlang OPT 25, and a version of Elixir is compiled with that OTP version. The easiest way to do this is to install Erlang and Elixir with asdf. If you downgrade OTP, you might need to remove all project dependencies and reinstall.

To install dependencies:
```sh
% mix deps.get
```

## Runnning
```sh
% mix run
```

## Broker
Run the EMQX MQTT broker in a docker container, from https://www.emqx.io:

docker run -d --name emqx -p 1883:1883 emqx/emqx

## MQTT library
emqtt is an Erlang MQTT library (Erlang can be used in Elixir).




