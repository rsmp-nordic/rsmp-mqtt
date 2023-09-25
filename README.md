# About
An Elixir app to investigate the possibility of building RSMP 4 on top of MQTT.

Initial code from:
https://www.emqx.com/en/blog/mqtt-for-elixir



## Prerequisites
Elixir >= 1.15
Erlang 25 (not 26)

## Dependencies
emqtt is an Erlang MQTT library (Erlang can be used in Elixir).

NOTE: The emqtt libriary is currently incompatible with the latest Erlang 26, see:
https://github.com/emqx/emqtt/pull/196

Instead you must install Erlang 25, and a version of Elixir is compiled with that OTP version. The easiest way to do this is to install Erlang and Elixir with asdf, see e.g:
https://www.pluralsight.com/guides/installing-elixir-erlang-with-asdf

If you downgrade an existing Erlang 26, you might need to remove all project dependencies and reinstall.

To install dependencies (once elixir and erlang is installed):
```sh
% mix deps.get
```

## Run Broker
Run the EMQX mqtt broker in a docker container, see https://www.emqx.io:

```sh
docker run -d --name emqx -p 1883:1883 emqx/emqx
```

## Run app
```sh
% mix run --no-halt
```

## Troubleshooting
If you get the error `Application rsmp exited: shutdown`, then please check that the broker is running and reachable on port 1883 - see above.



