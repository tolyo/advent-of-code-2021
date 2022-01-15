defmodule BinaryDiagnostic do
  def process(data) do
    data
    |> Helper.parse()
    # turn each binary into a
    |> Enum.map(fn x ->
      x
      |> String.trim()
      |> String.graphemes()
    end)
    |> case do
      list ->
        {helper(list, []), length(list)}
    end
    |> case do
      {list, count} ->
        alpha =
          Enum.map(list, fn x ->
            case x > count / 2 do
              true -> 1
              false -> 0
            end
          end)

        gamma =
          Enum.map(list, fn x ->
            case x > count / 2 do
              true -> 0
              false -> 1
            end
          end)

        {alpha, gamma}
    end
    |> case do
      {alpha, gamma} ->
        helper = fn x ->
          x
          |> Enum.into("", fn x -> "#{x}" end)
          |> case do
            val ->
              :erlang.binary_to_integer(val, 2)
          end
        end

        helper.(alpha) * helper.(gamma)
    end
  end

  def helper([], acc) do
    acc
  end

  def helper([h | t], []) do
    acc_list =
      Enum.map(h, fn x ->
        {a, _} = Integer.parse(x)
        a
      end)

    helper(t, acc_list)
  end

  def helper([h | t], list) do
    acc_list =
      Enum.zip(h, list)
      |> Enum.map(fn {x, y} ->
        {a, _} = Integer.parse(x)
        y + a
      end)

    helper(t, acc_list)
  end
end
