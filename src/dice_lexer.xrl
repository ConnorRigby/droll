Definitions.

INT        = [0-9]+
WHITESPACE = [\s\t\n\r]

Rules.

{INT}         : {token, {int,  TokenLine, list_to_integer(TokenChars)}}.
d             : {token, {'d',  TokenLine}}.
[-+/x]        : {token, {math, TokenLine, TokenChars}}.
{WHITESPACE}+ : skip_token.
Erlang code.
