defmodule Droll.Formula do
  @moduledoc "Represents a parsed formula"

  defstruct [
    :num_dice,
    :num_sides,
    :modifier,
    :operation
  ]

  @type t() :: %Droll.Formula{
          num_dice: pos_integer(),
          num_sides: pos_integer(),
          modifier: integer(),
          operation: :+ | :- | :/ | :x
        }
end

defimpl Inspect, for: Droll.Formula do
  @moduledoc "Inspect protocol implementation for Droll.Formula"
  def inspect(%{modifier: 0} = formula, _opts) do
    "#Droll<#{formula.num_dice}d#{formula.num_sides}>"
  end

  def inspect(formula, _opts) do
    "#Droll<#{formula.num_dice}d#{formula.num_sides}#{formula.operation}#{formula.modifier}>"
  end
end
