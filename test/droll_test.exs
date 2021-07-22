defmodule DrollTest do
  use ExUnit.Case
  doctest Droll

  describe "parse/1" do
    test "num dice" do
      assert Droll.parse("d6") ==
               {:ok, %Droll.Formula{num_dice: 1, num_sides: 6, modifier: 0, operation: :+}}

      assert Droll.parse("1d6") ==
               {:ok, %Droll.Formula{num_dice: 1, num_sides: 6, modifier: 0, operation: :+}}

      assert Droll.parse("10d6") ==
               {:ok, %Droll.Formula{num_dice: 10, num_sides: 6, modifier: 0, operation: :+}}

      assert Droll.parse("100d6") ==
               {:ok, %Droll.Formula{num_dice: 100, num_sides: 6, modifier: 0, operation: :+}}
    end

    test "num sides" do
      assert Droll.parse("d6") ==
               {:ok, %Droll.Formula{num_dice: 1, num_sides: 6, modifier: 0, operation: :+}}

      assert Droll.parse("d60") ==
               {:ok, %Droll.Formula{num_dice: 1, num_sides: 60, modifier: 0, operation: :+}}

      assert Droll.parse("d600") ==
               {:ok, %Droll.Formula{num_dice: 1, num_sides: 600, modifier: 0, operation: :+}}
    end

    test "no modifier" do
      assert Droll.parse("d20") ==
               {:ok, %Droll.Formula{num_dice: 1, num_sides: 20, modifier: 0, operation: :+}}

      assert Droll.parse("2d20") ==
               {:ok, %Droll.Formula{num_dice: 2, num_sides: 20, modifier: 0, operation: :+}}
    end

    test "addition modifier" do
      assert Droll.parse("d20") ==
               {:ok, %Droll.Formula{num_dice: 1, num_sides: 20, modifier: 0, operation: :+}}

      assert Droll.parse("d20+1") ==
               {:ok, %Droll.Formula{num_dice: 1, num_sides: 20, modifier: 1, operation: :+}}

      assert Droll.parse("d20+5") ==
               {:ok, %Droll.Formula{num_dice: 1, num_sides: 20, modifier: 5, operation: :+}}
    end

    test "subtraction modifier" do
      assert Droll.parse("d20-1") ==
               {:ok, %Droll.Formula{num_dice: 1, num_sides: 20, modifier: 1, operation: :-}}

      assert Droll.parse("d20-5") ==
               {:ok, %Droll.Formula{num_dice: 1, num_sides: 20, modifier: 5, operation: :-}}
    end

    test "multiplication modifier" do
      assert Droll.parse("d20x1") ==
               {:ok, %Droll.Formula{num_dice: 1, num_sides: 20, modifier: 1, operation: :x}}

      assert Droll.parse("d20x5") ==
               {:ok, %Droll.Formula{num_dice: 1, num_sides: 20, modifier: 5, operation: :x}}
    end

    test "division modifier" do
      assert Droll.parse("d20/1") ==
               {:ok, %Droll.Formula{num_dice: 1, num_sides: 20, modifier: 1, operation: :/}}

      assert Droll.parse("d20/5") ==
               {:ok, %Droll.Formula{num_dice: 1, num_sides: 20, modifier: 5, operation: :/}}
    end
  end

  describe "errors" do
    test "no input" do
      assert Droll.parse("") == {:error, "could not decode formula"}
    end

    test "invalid input" do
      assert Droll.parse("asdf") == {:error, "could not decode formula. unexpected input: 'a'"}
    end

    test "syntax error" do
      assert Droll.parse("1dd") == {:error, "could not decode formula"}
      assert Droll.parse("1d10++") == {:error, "could not decode formula"}
      assert Droll.parse("d") == {:error, "could not decode formula"}
    end
  end
end
