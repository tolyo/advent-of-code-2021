defmodule SonarSweepTest do
  use ExUnit.Case
  doctest SonarSweep

  test "greets the world" do
    res = "./lib/test.txt"
      |> SonarSweep.parse()
      |> SonarSweep.proccess()
    assert res == 7
  end
end
