import Config

config :rsmp, :emqtt,
  host: '127.0.0.1',
  port: 1883,
  clientid: "rsmp",
  clean_start: false,
  name: :emqtt,
  proto_ver: :v5

config :rsmp, :interval, 1000