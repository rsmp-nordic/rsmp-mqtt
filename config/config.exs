import Config

config :rsmp, :emqtt,
  host: ~c"127.0.0.1",
  port: 1883,
  clientid: "tlc_582a",
  clean_start: false,
  name: :emqtt,
  proto_ver: :v5

config :rsmp, :interval, 1000
