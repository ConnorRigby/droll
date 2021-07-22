Nonterminals exp elem.
Terminals int math 'd'.
Rootsymbol exp.

exp -> elem 'd' elem math elem: {'$1', 'd', '$3', extract_operation('$4'), '$5'}.
exp -> elem 'd' elem : {'$1', 'd', '$3', '+', 0}.
exp -> 'd' elem : {1, 'd', '$2', '+', 0}.
exp -> 'd' elem math elem: {1, 'd', '$2', extract_operation('$3'), '$4'}.

elem -> int  : extract_token('$1').

Erlang code.

extract_token({_Token, _Line, Value}) -> Value.
extract_operation({_Token, _Line, Op}) -> list_to_atom(Op).
