defmodule LispEvaluatorTest do
  use ExUnit.Case
  doctest LispEvaluator

  test "can evaluate expressions" do
      assert 3 == LispEvaluator.evaluate("(+ 1 2)")
  end

  test "can evaluate nested expressions" do
      assert 2 == LispEvaluator.evaluate("(+ 1 (- 3 2))")
      assert 9 == LispEvaluator.evaluate("(* (/ 9 3) (* 1 3))")
  end

  test "no code returns false" do
      assert false == LispEvaluator.evaluate("")
  end
end
