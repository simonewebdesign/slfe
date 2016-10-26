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

  test "can evaluate values" do
    assert 42 == LispEvaluator.evaluate("(42)")
  end

  test "can evaluate nested values" do
    assert 7 == LispEvaluator.evaluate("(7)")
    assert 14 == LispEvaluator.evaluate("((14))")
    assert 21 == LispEvaluator.evaluate("(+ (7) ((14)) )")
    assert 28 == LispEvaluator.evaluate("(+ (7) (((21))) )")
  end

  test "no code returns false" do
    assert false == LispEvaluator.evaluate("")
  end
end
