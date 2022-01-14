defmodule DiveTest do
  use ExUnit.Case

  test "executes" do
    res = "./lib/day2/test.txt"
      |> Dive.process()
    assert res == 150
  end
end
