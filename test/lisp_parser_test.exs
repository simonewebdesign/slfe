defmodule LispParserTest do
  use ExUnit.Case
  doctest LispParser

  test "single expression" do
    assert LispParser.parse("(:foo 1 2)") == [:foo, 1, 2]
    assert LispParser.parse("(+ 1 2)") == [:+, 1, 2]
  end

  test "nested expression" do
    assert LispParser.parse("(+ 1 (* 3 3))") == [:+, 1, [:*, 3, 3]]
  end

  test "nested expression (3 levels)" do
    assert LispParser.parse("(+ 1 (* (- 4 1) 3))") == [:+, 1, [:*, [:-, 4, 1], 3]]
  end

  test "function with list as argument" do
    assert LispParser.parse("(:reverse [1 2 3])") == [:reverse, {[1, 2, 3]}]
  end
end
