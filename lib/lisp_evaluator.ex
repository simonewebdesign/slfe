defmodule LispEvaluator do

  def evaluate(""), do: false

  def evaluate(code) do
    LispParser.parse(code)
    |> do_evaluate
  end

  def do_evaluate([]), do: false

  def do_evaluate([head|tail]) do
    apply(Kernel, head, tail)
  end

end
