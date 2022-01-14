defmodule SonarSweep do
  @spec process(any) :: non_neg_integer
  def process(data) do
    data
    |> Helper.parse()
    |> Enum.reverse()
    |> Enum.map(&String.replace(&1, "\n", ""))
    |> Enum.map(fn x ->
      {a, _} = Integer.parse(x)
      a
    end)
    |> helper()
    |> Enum.count(fn x -> x == true end)
  end

  defp helper([_t]), do: []

  defp helper([h | t]) do
    case t do
      [] ->
        []

      [h1 | _] ->
        [h > h1 | helper(t)]
    end
  end
end
