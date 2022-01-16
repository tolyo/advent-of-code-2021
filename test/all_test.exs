defmodule SonarSweepTest do
  use ExUnit.Case

  test "GiantSquid" do
    res =
      "./lib/day4/test.txt"
      |> GiantSquid.process()

    assert res == 4512
  end

  test "BinaryDiagnostic" do
    res =
      "./lib/day3/test.txt"
      |> BinaryDiagnostic.process()

    assert res == 198
  end

  test "Dive" do
    res =
      "./lib/day2/test.txt"
      |> Dive.process()

    assert res == 150
  end

  test "SonarSweep" do
    res =
      "./lib/day1/test.txt"
      |> SonarSweep.process()

    assert res == 7
  end
end
