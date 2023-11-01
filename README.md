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

Instead you must install Erlang 25, and a version of Elixir is compiled with that OTP version. The easiest way to do this is to install Erlang and Elixir with rtx, see e.g:
https://github.com/jdx/rtx

After installing rtx, you can install the correct version of Elixir and Erlang (which is specified in .tool-versions) with:

```sh
rtx install`
```

If you're on macOS 14 Sonoma, Erlang 25 does work unless you build if without JIT. You can do this with:

```sh
KERL_CONFIGURE_OPTIONS="--disable-jit" rtx install
```

If you downgrade an existing Erlang 26, you might need to remove all project dependencies and reinstall.

Once Elixir and Erlang are installed, you can install project dependencies with:

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



## Interacting
You can interact with the RMSP client using `iex`, the interactive Elixir shell.

```sh
code/rsmp_mqtt (main) % iex -S mix
Erlang/OTP 25 [erts-13.2.2.3] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1] [jit:ns]

10:34:54.354 [info] Starting RSMP with pid #PID<0.190.0>
Interactive Elixir (1.15.5) - press Ctrl+C to exit (type h() ENTER for help)

iex(2)> rsmp = Process.whereis(RSMP)
#PID<0.190.0>

iex(3)> :sys.get_state(RSMP)        
%{
  interval: 1000,
  pid: #PID<0.191.0>,
  plan: 1,
  status: %{1 => 0},
  timer: #Reference<0.1086325504.2114453507.137317>
}
iex(4)> RSMP.set_status(rsmp,1,3)   
:ok
```
