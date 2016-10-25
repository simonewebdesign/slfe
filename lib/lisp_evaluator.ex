defmodule LispEvaluator do

  def evaluate(""), do: false

  def evaluate(code) do
    LispParser.parse(code)
    |> do_evaluate
  end


  def do_evaluate([]), do: false

  def do_evaluate([head|tail]) when is_atom(head) do
    apply(Kernel, head, Enum.map(tail, &do_evaluate(&1)))
  end

  def do_evaluate([head|_]) do
    case head do
      [[[value]]] -> value
      [[value]] -> value
      [value] -> value
      _ -> head
    end
  end

  def do_evaluate(elem), do: elem
end
