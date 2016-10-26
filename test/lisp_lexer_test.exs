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
    assert {:ok, plus, _} = :lisp_lexer.string('+')
    assert {:ok, minus, _} = :lisp_lexer.string('-')
    assert {:ok, times, _} = :lisp_lexer.string('*')
    assert {:ok, divide, _} = :lisp_lexer.string('/')

    assert plus == [ {:"+", 1} ]
    assert minus == [ {:"-", 1} ]
    assert times == [ {:"*", 1} ]
    assert divide == [ {:"/", 1} ]
  end

  test "lists" do
    {:ok, tokens, _} = :lisp_lexer.string('[1 2 3]')
    assert tokens == [ {:"[", 1},
                       {:int, 1, 1},
                       {:int, 1, 2},
                       {:int, 1, 3},
                       {:"]", 1}
                     ]

    {:ok, tokens, _} = :lisp_lexer.string('(:reverse [1 2 3])')
    assert tokens == [ {:"(", 1},
                       {:atom, 1, :reverse},
                       {:"[", 1},
                       {:int, 1, 1},
                       {:int, 1, 2},
                       {:int, 1, 3},
                       {:"]", 1},
                       {:")", 1}
                     ]
  end

  test "boolean" do
    {:ok, tokens, _} = :lisp_lexer.string('(if true (+ 1 2) (:nope))')
    assert tokens == [ {:"(", 1},
                       {:if, 1},
                       {true, 1},
                         {:"(", 1},
                         {:+, 1},
                         {:int, 1, 1},
                         {:int, 1, 2},
                         {:")", 1},
                         {:"(", 1},
                         {:atom, 1, :nope},
                         {:")", 1},
                       {:")", 1}
                     ]
  end
end
