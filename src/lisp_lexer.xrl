Definitions.

INT        = [0-9]+
ATOM       = :[a-z_]+
WHITESPACE = [\s\t\n\r]
STRING     = "(\\"*|\\.|[^"\\])*"

Rules.

{INT}         : {token, {int,  TokenLine, list_to_integer(TokenChars)}}.
{ATOM}        : {token, {atom, TokenLine, to_atom(TokenChars)}}.
{STRING}      : S = string:substr(TokenChars, 2, TokenLen - 2),
                {token, {string, TokenLine, S}}.

\(            : {token, {'(',  TokenLine}}.
\)            : {token, {')',  TokenLine}}.
\[            : {token, {'[',  TokenLine}}.
\]            : {token, {']',  TokenLine}}.

% OPERATORS
\+            : {token, {'+',  TokenLine}}.
\-            : {token, {'-',  TokenLine}}.
\*            : {token, {'*',  TokenLine}}.
\/            : {token, {'/',  TokenLine}}.

% BOOLEAN
if            : {token, {'if', TokenLine}}.
true          : {token, {'true', TokenLine}}.
false         : {token, {'false', TokenLine}}.

% EQUALITY
==            : {token, {'==', TokenLine}}.
/=            : {token, {'/=', TokenLine}}.


{WHITESPACE}+ : skip_token.

Erlang code.

to_atom([$:|Chars]) ->
    list_to_atom(Chars).
