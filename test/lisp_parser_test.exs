defmodule LispParserTest do
  use ExUnit.Case
  doctest LispParser

  test "it works" do
    # assert LispParser.parse("(1 2 (:foo (:bar)))") == [1, 2, [:foo, [:bar]]]
    assert LispParser.parse("(:foo 1 2)") == [:foo, 1, 2]
    # assert LispParser.parse("(+ 1 2)") == [:+, 1, 2]
  end
end
