defmodule SolveServer do
    use GenServer

    # Initializes a SolveServer containing all words contained at the path of the 
    # filename param
    def start_link(filename) do
        GenServer.start_link(__MODULE__, {filename}, [])
    end

    # Initializes a SolveServer containing all words contained at the path of the 
    # filename param, with the given word length
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

    # Wrapper function for below :solve call handler
    # Gives the puzzle solution for the given set of word chunks, additionally 
    # using the word map contained in the server's state as a parameter to the 
    # function
    def solve(pid, word_chunks) do
        GenServer.call(pid, {:solve, word_chunks})
    end

    def handle_call({:solve, word_chunks}, _, state) do
        {:reply, WordChunkCircles.solve(word_chunks, state), state}
    end
end