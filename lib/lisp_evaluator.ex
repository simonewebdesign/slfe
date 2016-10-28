defmodule LispEvaluator do

  def evaluate(""), do: false

  def evaluate(code) do
    LispParser.parse(code)
    |> do_evaluate
  end


  def do_evaluate([]), do: false

  def do_evaluate([elem]) when is_boolean(elem), do: elem

  def do_evaluate([:if, condition, do_clause, else_clause]) do
    if condition, do: do_evaluate(do_clause), else: do_evaluate(else_clause)
  end

  def do_evaluate([:"/=", left, right]) do
    apply(Kernel, :!=, [left, right])
  end

  def do_evaluate([:puts, item]) do
    IO.puts item
  end

  def do_evaluate([:concat, left, right]) do
    # left and right are char lists so we need to convert them to strings
    to_string(left) <> to_string(right)
  end

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
