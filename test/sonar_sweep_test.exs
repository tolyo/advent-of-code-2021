defmodule SonarSweepTest do
  use ExUnit.Case

  test "executes" do
    res =
      "./lib/day1/test.txt"
      |> SonarSweep.process()

    assert res == 7
  end
end
