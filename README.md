# Droll

[![Hex pm](http://img.shields.io/hexpm/v/droll.svg?style=flat)](https://hex.pm/packages/droll)

Standard Dice Notation in Elixir. See [the Wikipedia page](https://en.wikipedia.org/wiki/Dice_notation)
for a full description of the notation.

[Documentation for Droll is available online](http://hexdocs.pm/droll/).

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `droll` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:droll, "~> 1.0.0"}
  ]
end
```

## Usage

Example of rolling a 1 single 20 sided dice:

```elixir
iex(1)> Droll.roll("d20")
{:ok, %Droll.Result{avg: 3.0, max: 0, min: 3, rolls: [3], total: 3}}
iex(2)> Droll.roll("d20")
{:ok, %Droll.Result{avg: 20.0, max: 0, min: 20, rolls: [20], total: 20}}
iex(3)> Droll.roll("d20")
{:ok, %Droll.Result{avg: 19.0, max: 0, min: 19, rolls: [19], total: 19}}
iex(4)> Droll.roll("d20")
{:ok, %Droll.Result{avg: 17.0, max: 0, min: 17, rolls: [17], total: 17}}
```

Example of rolling 4 20 sided dice:

```elixir
iex(1)> Droll.roll("2d20")
{:ok, %Droll.Result{avg: 10.0, max: 0, min: 17, rolls: [3, 17], total: 20}}
iex(2)> Droll.roll("2d20")
{:ok, %Droll.Result{avg: 15.0, max: 0, min: 16, rolls: [14, 16], total: 30}}
iex(3)> Droll.roll("2d20")
{:ok, %Droll.Result{avg: 17.5, max: 0, min: 18, rolls: [18, 17], total: 35}}
iex(4)> Droll.roll("2d20")
{:ok, %Droll.Result{avg: 18.5, max: 0, min: 19, rolls: [19, 18], total: 37}}
```

Example of modifiers:

```elixir
iex(1)> Droll.roll("2d20+10")
{:ok, %Droll.Result{avg: 17.0, max: 0, min: 15, rolls: [9, 15], total: 34}}
iex(2)> Droll.roll("2d20/1") 
{:ok, %Droll.Result{avg: 12.5, max: 0, min: 18, rolls: [7, 18], total: 25.0}}
iex(3)> Droll.roll("2d20x8")
{:ok, %Droll.Result{avg: 5.5, max: 0, min: 10, rolls: [10, 1], total: 11}}
iex(4)> Droll.roll("2d20-3")
{:ok, %Droll.Result{avg: 9.5, max: 0, min: 12, rolls: [12, 10], total: 19}}
```

## Special Thanks

This project was inspired by a [Javascript library](https://github.com/thebinarypenguin/droll) of the same name.

## License

Copyright 2021 Connor Rigby

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
