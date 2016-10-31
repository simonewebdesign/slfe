defmodule LispEvaluatorTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

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

  test "the truth" do
    assert true == LispEvaluator.evaluate("(true)")
    assert false == LispEvaluator.evaluate("(false)")
  end

  test "if expressions" do
    assert 3 == LispEvaluator.evaluate("(if true (+ 1 2) (:nope))")
  end

  test "equality" do
    assert LispEvaluator.evaluate("(== (- 4 1) 3)")
    assert LispEvaluator.evaluate("(/= true false)")
  end

  test "string concatenation" do
    assert "foobar" == LispEvaluator.evaluate("(:concat \"foo\" \"bar\")")
  end

  test "can print to stdout" do
    fun = fn ->
      assert :ok == LispEvaluator.evaluate("(:puts \"Hello, World!\")")
    end
    stdout = capture_io(fun)
    assert stdout == "Hello, World!\n"
  end

  test "a program with two statements" do
    fun = fn ->
      assert [:ok | :ok] == LispEvaluator.evaluate("((:puts \"hello\") (:puts \"there\"))")
    end
    stdout = capture_io(fun)
    assert stdout == "hello\nthere\n"
  end

  test "can evaluate a simple program" do
    program = """
    ((:puts "Hello!")
     (:puts (:concat "1 + 1 = " (:to_string (+ 1 1)))))
    """
    fun = fn ->
      assert [:ok | :ok] == LispEvaluator.evaluate(program)
    end
    stdout = capture_io(fun)
    assert stdout == "Hello!\n1 + 1 = 2\n"
  end
end
