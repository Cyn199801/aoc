defmodule Day17Test do
  alias Elixir2016.Day17
  use ExUnit.Case

  test "part 1 examples" do
    assert Day17.bfs_part1("ihgpwlah") == "DDRRRD"
    assert Day17.bfs_part1("kglvqrro") == "DDUDRLRRUDRD"
    assert Day17.bfs_part1("ulqzkmiv") == "DRURDRUDDLLDLUURRDULRLDUUDDDRR"
  end

  test "part1" do
    passcode = Day17.parse("../inputs/17/input.txt")
    assert Day17.bfs_part1(passcode) == "RLDRUDRDDR"
  end

  test "part 2 examples" do
    assert Day17.bfs_part2("ihgpwlah") == 370
    assert Day17.bfs_part2("kglvqrro") == 492
    assert Day17.bfs_part2("ulqzkmiv") == 830
  end
end
