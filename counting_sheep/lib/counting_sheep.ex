defmodule CountingSheep do
  def main(args) do
    args |> File.stream! |> Enum.with_index |> process_list |> Enum.count(fn(x) -> x == true end) |> IO.puts
  end

  def process_list(list) do
    list
    |> Enum.map(&process_one/1)
  end

  def process_one({_,0}), do: nil
  def process_one({"0\n",i}), do: write("INSOMNIA", i)
  def process_one({o,i}) do
    o
    |> format
    |> calculate
    |> write(i)
  end

  def format(num) do
    num
    |> String.strip
    |> String.to_integer
  end

  def calculate(n), do: calculate([1,2,3,4,5,6,7,8,9,0], n)

  def calculate([], n, times) do
    n * (times - 1)
  end

  def calculate(rem, n, times \\ 1) do
    IO.puts inspect(n)
    IO.puts inspect(times)
    IO.puts inspect(rem)
    n * times
    |> Integer.digits
    |> Enum.reduce(rem, fn(x,acc) -> List.delete(acc, x) end)
    |> calculate(n, times + 1)
  end


  def write(answer,i) do
    {:ok, file} = File.open("output.txt", [:append])
    IO.write(file, "Case ##{i}: #{answer}\n")
    File.close(file)
  end
end

# CountingSheep.calculate(1)
