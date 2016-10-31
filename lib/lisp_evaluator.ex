defmodule LispEvaluator do

  def evaluate(""), do: false

  def evaluate(code) do
    LispParser.parse(code)
    |> do_evaluate
  end


  defp do_evaluate([h, t]) when is_list(h) and is_list(t) do
    [do_evaluate(h)] ++ do_evaluate(t)
  end

  defp do_evaluate([elem]) when is_boolean(elem), do: elem

  defp do_evaluate([:if, condition, do_clause, else_clause]) do
    if condition, do: do_evaluate(do_clause), else: do_evaluate(else_clause)
  end

  defp do_evaluate([:"/=", left, right]) do
    apply(Kernel, :!=, [left, right])
  end

  defp do_evaluate([:concat, left, right]) when is_binary(left) and is_binary(right) do
    left <> right
  end

  defp do_evaluate([:concat, left, right]) when is_binary(left) do
    left <> do_evaluate(right)
  end

  defp do_evaluate([:concat, left, right]) when is_binary(right) do
    left <> do_evaluate(right)
  end

  defp do_evaluate([:to_string, arg]) do
    to_string(do_evaluate(arg))
  end

  defp do_evaluate([:puts, item]) when is_binary(item) do
    IO.puts item
  end

  defp do_evaluate([:puts, item]) do
    IO.puts do_evaluate(item)
  end

  defp do_evaluate([head|tail]) when is_atom(head) do
    apply(Kernel, head, Enum.map(tail, &do_evaluate(&1)))
  end

  defp do_evaluate([head|_]) do
    case head do
      [[[value]]] -> value
      [[value]] -> value
      [value] -> value
      _ -> head
    end
  end

  defp do_evaluate(elem), do: elem
end
