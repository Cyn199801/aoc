defmodule ElixirDay23 do
  @moduledoc """
  Documentation for ElixirDay23.
  """
  alias ElixirDay23.{Breakout, Coordinator}

  def parse(filename) do
    File.stream!(filename)
    |> Stream.map(&String.trim/1)
    |> Enum.at(0)
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end

  @doc """
  First 255 packet: 30757, 22134
  """
  def main do
    program = parse("../../23/input.txt")
    how_many = 50

    {ok, pid} = Coordinator.start(program, how_many)

    pid
    |> IO.inspect(label: "coordinator pid")
  end

  # This might need to be moved to test
  def old_main do
    parse("../../13/input.txt")
    |> Breakout.part1()
    |> IO.inspect(label: "Day 13, Part 1: ")

    parse("../../13/input.txt")
    |> Breakout.part2()
    |> IO.inspect(label: "Day 13, Part 2: ")
  end
end