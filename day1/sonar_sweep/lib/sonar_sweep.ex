defmodule SonarSweep do
  def parse(source) do
    source
    |> File.open!()
    |> IO.stream(:line)
    |> Enum.into([])
  end

  def process(data) do
    data
    |> Enum.reverse()
    |> Enum.map(&(String.replace(&1, "\n", "")))
    |> Enum.map(fn x ->
      {a, _} = Integer.parse(x)
      a
    end)
    |> helper()
    |> Enum.count(fn x -> x == true end)
  end

  defp helper([t]), do: []
  defp helper([h|t]) do
    case t do
      [] -> []
      [h1|_] ->
        [h>h1|helper(t)]
    end
  end
end
