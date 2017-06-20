defmodule LispEvaluator do

  def evaluate(""),   do: false
  def evaluate(code), do: eval(LispParser.parse(code))

  defp eval([h, t]) when is_list(h) and is_list(t) do
    [eval(h)] ++ eval(t)
  end

  defp eval([elem]) when is_boolean(elem), do: elem

  defp eval([:if, condition, do_clause, else_clause]) do
    if condition, do: eval(do_clause), else: eval(else_clause)
  end

  defp eval([:"/=", left, right]) do
    apply(Kernel, :!=, [left, right])
  end

  defp eval([:concat, left, right]) when is_binary(left) and is_binary(right) do
    left <> right
  end

  defp eval([:concat, left, right]) when is_binary(left) do
    left <> eval(right)
  end

  defp eval([:concat, left, right]) when is_binary(right) do
    left <> eval(right)
  end

  defp eval([:to_string, arg]) do
    to_string(eval(arg))
  end

  defp eval([:puts, item]) when is_binary(item) do
    IO.puts item
  end

  defp eval([:puts, item]) do
    IO.puts eval(item)
  end

  defp eval([head|tail]) when is_atom(head) do
    apply(Kernel, head, Enum.map(tail, &eval(&1)))
  end

  defp eval([head|_]) do
    case head do
      [[[value]]] -> value
      [[value]] -> value
      [value] -> value
      _ -> head
    end
  end

  defp eval(elem), do: elem
end
