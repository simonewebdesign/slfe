defmodule LispEvaluatorTest do
  use ExUnit.Case
  doctest LispEvaluator

  test "can evaluate expressions" do
      assert 3 == LispEvaluator.evaluate("(+ 1 2)")
  end

  test "no code returns false" do
      assert false == LispEvaluator.evaluate("")
  end
end
