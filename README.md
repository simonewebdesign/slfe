# SLFE

**SLFE** stands for **S**hitty [**LFE**](http://lfe.io/) ([LISP](https://www.common-lisp.net/)-flavoured [Erlang](http://www.erlang.org/)).

It's a new programming language based on [Elixir](https://github.com/elixir-lang/elixir) which aims to support all of the [`Enum`](http://elixir-lang.org/docs/stable/elixir/Enum.html) functionality.

## Installation

If [available in Hex](https://hex.pm/docs/publish) (not yet), the package can be installed as:

  1. Add `slfe` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:slfe, "~> 0.1.0"}]
    end
    ```

  2. Ensure `slfe` is started before your application:

    ```elixir
    def application do
      [applications: [:slfe]]
    end
    ```


## Running the test suite

You can do so by running `mix test` from the command line.


## FAQ

### Should I use this?

Probably not. This is actually just an experiment, so I wouldn't recommend people using it to build actual programs. But feel free to use it anyway if you want.

### Why Erlang/Elixir?

[`leex`](http://erlang.org/doc/man/leex.html) and [`yecc`](http://erlang.org/doc/man/yecc.html) are the powerful Erlang alternatives to [`lex`](http://en.wikipedia.org/wiki/Lex_(software)) and [`yacc`](https://en.wikipedia.org/wiki/Yacc). I like Erlang, and Elixir is pretty rad too. So why not.

### Is SLFE a Turing-complete language?

Yeah, I guess.

---

**SLFE** was inspired by [this blog post](http://andrealeopardi.com/posts/tokenizing-and-parsing-in-elixir-using-leex-and-yecc/) (thanks Andrea!).

Kudos to [lpil](https://github.com/lpil) for the name suggestion and for being awesome.
