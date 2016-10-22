defmodule LispLexerTest do
  use ExUnit.Case
  # doctest LispLexer

  test "empty expression" do
    {:ok, tokens, _} = :lisp_lexer.string('()')
    assert tokens == [ "(": 1,
                       ")": 1
                     ]
  end

  test "full expression" do
    {:ok, tokens, _} = :lisp_lexer.string('(:foo 1 2)')
    assert tokens == [ {:"(", 1},
                       {:atom, 1, :foo},
                       {:int, 1, 1},
                       {:int, 1, 2},
                       {:")", 1}
                     ]
  end

  test "operators" do

  end

end
