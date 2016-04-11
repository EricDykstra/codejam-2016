defmodule Pancakes do
  def main(args) do
    args |> File.stream! |> Enum.with_index |> process_list |> Enum.count(fn(x) -> x == true end) |> IO.puts
  end

  def process_list(list) do
    list
    |> Enum.map(&process_one/1)
  end

  def process_one({_,0}), do: nil
  def process_one({o,i}) do
    o
    |> format
    |> calculate
    |> write(i)
  end

  def format(str) do
    str
    |> String.strip
    |> String.codepoints
  end

  def calculate(list) do
    list
    |> Enum.chunk_by(fn(x) -> x == "+" end)
    |> Enum.count
    |> adjust(List.last(list))
  end

  def adjust(count, adjustment) do
    case adjustment do
      "+" -> count - 1
      _ -> count
    end
  end


  def write(answer,i) do
    {:ok, file} = File.open("output.txt", [:append])
    IO.write(file, "Case ##{i}: #{answer}\n")
    File.close(file)
  end

end
