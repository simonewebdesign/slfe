defmodule LispParser do
  @spec parse(binary) :: list
  def parse(str) do
    {:ok, tokens, _} = str |> to_char_list |> :lisp_lexer.string
    {:ok, list}      = :lisp_parser.parse(tokens)
    list
  end
end
