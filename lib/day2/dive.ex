defmodule Dive do
  @spec process(any) :: non_neg_integer
  def process(data) do
    data
    |> Helper.parse()
    |> Enum.reduce({0, 0}, fn x, {a, b} ->
      [command, val] = String.split(x, " ")
      {val, _} = Integer.parse(val)
      case command do
        "forward" -> {a + val, b}
        "up" ->
          IO.puts("up #{b}")

          {a, b - val}
        "down" ->
          IO.puts("down #{b}")

          {a, b + val}
      end
    end)
    |> case do
      {a, b} ->

        IO.puts("final  #{a} * #{b}")
        a * b
    end
  end
end
