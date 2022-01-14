defmodule Helper do
  def parse(source) do
    source
    |> File.open!()
    |> IO.stream(:line)
    |> Enum.into([])
  end
end
