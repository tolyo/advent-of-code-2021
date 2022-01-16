defmodule GiantSquid2 do
  def process(data) do
    parsed = data |> Helper.parse()
    # the first line is our input
    inputs =
      parsed
      |> List.first()
      |> String.replace("\n", "")
      |> String.split(",")

    # boards
    [_h | t] = parsed

    boards =
      t
      |> Enum.filter(fn x -> x !== "\n" end)
      |> Enum.map(&String.replace(&1, "\n", ""))
      |> Enum.map(&String.trim/1)
      |> Enum.map(&String.replace(&1, "  ", " "))
      |> Enum.map(&String.split(&1, " "))
      |> Enum.chunk_every(5)

    # feed the input into every board until on one column is completely filled
    match(inputs, boards)
  end

  def match([h | t], list) do
    list
    |> Enum.map(fn board ->
      board
      |> Enum.map(fn row ->
        row
        |> Enum.map(fn x ->
          case x == h do
            true -> {:ok, x}
            false -> x
          end
        end)
        |> case do
          [{:ok, _}, {:ok, _}, {:ok, _}, {:ok, _}, {:ok, _}] = row -> {:done, row}
          row -> row
        end
      end)
      |> case do
        board ->
          # if any one of the rows is a tuple, we are donw
          case Enum.any?(board, fn x -> is_tuple(x) end) do
            true ->
              {:done, get_sum(board)}

            false ->
              # board
              # check for columns
              Enum.to_list(0..4)
              |> Enum.map(fn index ->
                board
                |> Enum.map(fn row ->
                  {val, _} = List.pop_at(row, index)
                  val
                end)
                |> Enum.all?(fn x -> is_tuple(x) end)
              end)
              |> case do
                val ->
                  case Enum.any?(val, fn x -> x == true end) do
                    true -> {:done, get_sum(board)}
                    false -> board
                  end
              end
          end
      end
    end)
    |> case do
      boards ->
        case Enum.any?(boards, fn x -> is_tuple(x) end) do
          true ->
            {a, _} = Integer.parse(h)
            score = Enum.filter(boards, &is_tuple(&1))[:done] * a

            case Enum.filter(boards, &(!is_tuple(&1))) do
              [] -> score
              val -> match(t, val)
            end

          false ->
            match(t, boards)
        end
    end
  end

  def get_sum(board) do
    board
    # remove tuble
    |> Enum.map(fn x ->
      case is_tuple(x) do
        true ->
          {:done, b} = x
          b

        false ->
          x
      end
    end)
    # remove tuples from each row
    |> Enum.map(fn x ->
      Enum.filter(x, fn val -> is_tuple(val) == false end)
    end)
    # convert each string into int
    |> Enum.map(fn x ->
      Enum.map(x, fn val ->
        {a, _} = Integer.parse(val)
        a
      end)
    end)
    # sum each row
    |> Enum.map(fn x -> Enum.sum(x) end)
    # sum column
    |> Enum.sum()
  end
end
