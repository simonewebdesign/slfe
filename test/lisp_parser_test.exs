defmodule LispParserTest do
  use ExUnit.Case
  doctest LispParser

  test "it works" do
    assert LispParser.parse("[1, 2, [:foo, [:bar]]]") == [1, 2, [:foo, [:bar]]]
  end
end
