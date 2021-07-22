defmodule Droll do
  @moduledoc """
  Simple implementation of standard dice notation

  See [The Wikipedia Page](https://en.wikipedia.org/wiki/Dice_notation) for
  more information.
  """

  alias Droll.{Result, Formula}

  @doc """
  Parse a standard dice notation formula

  Examples:

      iex> Droll.parse("d20")
      {:ok, %Droll.Formula{num_dice: 1, num_sides: 20, modifier: 0, operation: :+}}
      iex> Droll.parse("4d6")
      {:ok, %Droll.Formula{num_dice: 4, num_sides: 6, modifier: 0, operation: :+}}
      iex> Droll.parse("1d6+1")
      {:ok, %Droll.Formula{num_dice: 1, num_sides: 6, modifier: 1, operation: :+}}
      iex> Droll.parse("10d5-2")
      {:ok, %Droll.Formula{num_dice: 10, num_sides: 5, modifier: 2, operation: :-}}
      iex> Droll.parse("1d10/1")
      {:ok, %Droll.Formula{num_dice: 1, num_sides: 10, modifier: 1, operation: :/}}
      iex> Droll.parse("1d10x5")
      {:ok, %Droll.Formula{num_dice: 1, num_sides: 10, modifier: 5, operation: :x}}
  """
  @spec parse(iodata()) :: {:ok, Formula.t()} | {:error, String.t()}
  def parse(formula) do
    with {:ok, tokens, _} <- :dice_lexer.string(to_charlist(formula)),
         {:ok, {num_dice, :d, num_sides, operation, modifier}} <- :dice_parser.parse(tokens) do
      {:ok,
       %Formula{
         num_dice: num_dice,
         num_sides: num_sides,
         modifier: modifier,
         operation: operation
       }}
    else
      {:error, {_, :dice_lexer, {:illegal, chars}}, _} ->
        {:error, "could not decode formula. unexpected input: #{inspect(chars)}"}

      {:error, {_, :dice_parser, _}} ->
        {:error, "could not decode formula"}

      {:error, reason} ->
        {:error, reason}

      e when is_list(e) ->
        {:error, "could not decode formula"}
    end
  end

  @doc """
  Execute a roll based on a formula. See `Droll.parse/1` for more information
  """
  def roll(formula_str) do
    with {:ok, formula} <- parse(formula_str) do
      {:ok,
       %Result{}
       |> apply_roll(formula)
       |> apply_modifier(formula)
       |> total()
       |> min()
       |> max()
       |> avg()}
    end
  end

  @spec apply_roll(Result.t(), Formula.t()) :: Result.t()
  defp apply_roll(result, formula) do
    rolls =
      Enum.map(1..formula.num_dice, fn _ ->
        1 + :erlang.floor(:rand.uniform() * formula.num_sides)
      end)

    %{result | rolls: rolls}
  end

  @spec total(Result.t()) :: Result.t()
  defp total(result) do
    Enum.reduce(1..Enum.count(result.rolls), result, fn b, result ->
      %{result | total: result.total + Enum.at(result.rolls, b - 1)}
    end)
  end

  @spec min(Result.t()) :: Result.t()
  defp min(result), do: %{result | min: Enum.min(result.rolls)}

  @spec max(Result.t()) :: Result.t()
  defp max(result), do: %{result | min: Enum.max(result.rolls)}

  @spec avg(Result.t()) :: Result.t()
  defp avg(result), do: %{result | avg: result.total / Enum.count(result.rolls)}

  @spec apply_modifier(Result.t(), Formula.t()) :: Result.t()
  defp apply_modifier(result, %{modifier: modifier, operation: :+}),
    do: %{result | total: result.total + modifier}

  defp apply_modifier(result, %{modifier: modifier, operation: :-}),
    do: %{result | total: result.total - modifier}

  defp apply_modifier(result, %{modifier: modifier, operation: :/}),
    do: %{result | total: result.total / modifier}

  defp apply_modifier(result, %{modifier: modifier, operation: :x}),
    do: %{result | total: result.total * modifier}
end
