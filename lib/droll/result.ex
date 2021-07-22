defmodule Droll.Result do
  @moduledoc "Contains the total and other calculations for a roll"
  defstruct total: 0, rolls: [], min: 0, max: 0, avg: 0

  @type t() :: %Droll.Result{
          total: number(),
          rolls: [pos_integer()],
          min: number(),
          max: number(),
          avg: number()
        }
end

defimpl String.Chars, for: Droll.Result do
  @moduledoc "String implementation for a Droll Result"
  def to_string(result) do
    cond do
      Enum.count(result.rolls) == 1 && result.modifier == 0 ->
        [Kernel.to_string(Enum.at(result.rolls, 0)), ""]

      Enum.count(result.rolls) > 1 && result.modifier == 0 ->
        [Enum.join(result.rolls, " + ") | [" = ", Kernel.to_string(result.total)]]

      Enum.count(result.rolls) == 1 && result.modifier > 0 ->
        [
          Kernel.to_string(Enum.at(result.rolls, 0))
          | [" + ", Kernel.to_string(result.modifier), " = ", Kernel.to_string(result.total)]
        ]

      Enum.count(result.rolls) > 1 && result.modifier > 0 ->
        [
          Enum.join(result.rolls, " + ")
          | [" + ", Kernel.to_string(result.modifier), " = ", Kernel.to_string(result.total)]
        ]

      Enum.count(result.rolls) == 1 && result.modifier < 0 ->
        [
          Kernel.to_string(Enum.at(result.rolls, 0))
          | [
              " - ",
              Kernel.to_string(:erlang.abs(result.modifier)),
              " = ",
              Kernel.to_string(result.total)
            ]
        ]

      Enum.count(result.rolls) > 1 && result.modifier < 0 ->
        [
          Enum.join(result.rolls, " + ")
          | [
              " - ",
              Kernel.to_string(:erlang.abs(result.modifier)),
              " = ",
              Kernel.to_string(result.total)
            ]
        ]

      true ->
        "oops! something went wrong"
    end
    |> Kernel.to_string()
  end
end
