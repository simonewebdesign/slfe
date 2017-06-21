# SLFE

**SLFE** stands for **S**hitty [**LFE**](http://lfe.io/) ([LISP](https://www.common-lisp.net/)-flavoured [Erlang](http://www.erlang.org/)).

It's a new programming language based on [Elixir](https://github.com/elixir-lang/elixir) which aims to support all of the [`Enum`](http://elixir-lang.org/docs/stable/elixir/Enum.html) functionality.

## Overview

### The big picture

The `slfec` compiler is a program that takes a `foo.sl` source file and produces a `foo` executable binary.

The `isl` REPL is an executable interactive program/environment (like Ruby's `irb` and Elixir's `iex`) for `.sl` programs.

These tools do not exist yet, but that's how you would ideally use SLFE.

#### To-do list

- [x] Booleans
- [x] UTF-8 Strings
- [x] Integers
- [ ] Floats
- [x] Multiple statements
- [x] `if` expressions
- [x] Equality checks with `==` and `/=`
- [x] Functions
- [x] Math operators (`+`, `-`, `*`, `/`)
- [x] Linked lists

### Code walk-through

This project is currently composed of 4 files:

#### Erlang

- src/lisp_lexer.xrl - Lexical analyzer generator
- src/lisp_parser.yrl - LALR-1 Parser Generator

#### Elixir

- lib/lisp_parser.ex - Layer on top of `:lisp_lexer` and `:lisp_parser`
- lib/lisp_evaluator.ex - Evaluates s-expressions and writes to stdio. Ideally the two things should be decoupled.

### Running the test suite

You can do so by running `mix test` from the command line.

    $ mix test
    ............................

    Finished in 0.07 seconds
    28 tests, 0 failures


## FAQ

<details>
  <summary>Should I use this?</summary>

Probably not. This is actually just an experiment, so I wouldn't recommend people using it to build actual programs. But feel free to use it anyway if you want.
</details>

<details>
  <summary>Why Erlang/Elixir?</summary>

[`leex`](http://erlang.org/doc/man/leex.html) and [`yecc`](http://erlang.org/doc/man/yecc.html) are the powerful Erlang alternatives to [`lex`](http://en.wikipedia.org/wiki/Lex_(software)) and [`yacc`](https://en.wikipedia.org/wiki/Yacc). I like Erlang, and Elixir is pretty rad too. So why not?
</details>

<details>
  <summary>Is SLFE a Turing-complete language?</summary>

Yeah, I guess.
</details>

---

**SLFE** was inspired by [this blog post](http://andrealeopardi.com/posts/tokenizing-and-parsing-in-elixir-using-leex-and-yecc/) (thanks Andrea!).

Kudos to [lpil](https://github.com/lpil) for the name suggestion and for being awesome.
