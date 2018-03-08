defmodule SolveServer do
    use GenServer

    def start_link(filename) do
        GenServer.start_link(__MODULE__, {filename}, [])
    end

    def start_link(filename, word_length) do
        GenServer.start_link(__MODULE__, {filename, word_length}, [])
    end

    def init({filename}) do
        word_map = filename
        |> File.read!()
        |> String.split()
        |> List.foldr(%{}, fn (elem, acc) -> Map.put(acc, String.upcase(elem), true) end)

        {:ok, word_map}
    end

    def init({filename, word_length}) do
        word_map = filename
        |> File.read!()
        |> String.split()
        |> List.foldr(%{}, fn (elem, acc) -> 
            cond do
                Kernel.length(elem) == word_length -> Map.put(acc, String.upcase(elem), true)
                true -> acc
            end
        end)

        {:ok, word_map}
    end

    def solve(pid, orthographs) do
        GenServer.call(pid, {:solve, orthographs})
    end

    def handle_call({:solve, orthographs}, _, state) do
        {:reply, OrthographCircles.solve(orthographs, state), state}
    end
end