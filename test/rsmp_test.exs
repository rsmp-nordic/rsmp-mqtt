defmodule RSMPTest do
  use ExUnit.Case
  doctest RSMP

  test "greets the world" do
    assert RSMP.hello() == :world
  end
end
