defmodule LispLexerTest do
  use ExUnit.Case

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


  test "equality" do
    {:ok, tokens, _} = :lisp_lexer.string('(== (- 4 1) 3)')
    assert tokens == [ {:"(", 1},
                       {:==, 1},
                         {:"(", 1},
                         {:-, 1},
                         {:int, 1, 4},
                         {:int, 1, 1},
                         {:")", 1},
                        {:int, 1, 3},
                       {:")", 1}
                     ]

    {:ok, tokens, _} = :lisp_lexer.string('(/= true false)')
    assert tokens == [ {:"(", 1},
                       {:"/=", 1},
                       {true, 1},
                       {false, 1},
                       {:")", 1}
                     ]
  end

  test "strings" do
    {:ok, tokens, _} = :lisp_lexer.string('("foo")')
    assert tokens == [ {:"(", 1},
                       {:string, 1, 'foo'},
                       {:")", 1}
                     ]

    {:ok, tokens, _} = :lisp_lexer.string('(:concat \"foo\" \"bar\")')
    assert tokens == [ {:"(", 1},
                       {:atom, 1, :concat},
                       {:string, 1, 'foo'},
                       {:string, 1, 'bar'},
                       {:")", 1}
                     ]
  end

  test "a simple program" do
    {:ok, tokens, _} = :lisp_lexer.string('((:puts \"Hello!\")\n (:puts (:concat \"1 + 1 = \" (+ 1 1))))\n')
    assert tokens == [ {:"(", 1},
                         {:"(", 1},
                           {:atom, 1, :puts},
                           {:string, 1, 'Hello!'},
                         {:")", 1},
                         {:"(", 2},
                           {:atom, 2, :puts},
                           {:"(", 2},
                             {:atom, 2, :concat},
                             {:string, 2, '1 + 1 = '},
                             {:"(", 2},
                               {:+, 2},
                               {:int, 2, 1},
                               {:int, 2, 1},
                             {:")", 2},
                           {:")", 2},
                         {:")", 2},
                       {:")", 2}
                     ]    
  end

end
