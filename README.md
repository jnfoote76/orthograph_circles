# WordChunkCircles

Given a list of digraphs or trigraphs (or really, character sequences of any length), this solver returns the elements in an order such that each adjacent pair of chunks forms a valid word and the last chunk circles back to the first element (if such an order exists). If it exists, it will return all valid circles, each starting with the chunk that appears first alphabetically (otherwise, it returns an empty list). 

## Dependencies

If you haven't already, [install Erlang and Elixir](https://elixir-lang.org/install.html).

Additionally, you'll need a text file containing a list of valid words (each word separated by a newline character). In my examples, I'm use "words_alpha.txt" found at https://github.com/dwyl/english-words

## Usage

Build the project and initialize a GenServer that constructs and stores a valid word map
```
$ iex -S mix
iex> {:ok, pid} = SolveServer.start_link("words_alpha.txt")
```

A few sample puzzle solutions, with solutions hidden in case you actually want to try solving them yourself:

```
iex> SolveServer.solve(pid, ["AL", "AT", "EL", "FA", "KE", "OP", "SE", "SO"])
```
<details><summary>Solution</summary><p>
[["AL", "SO", "FA", "KE", "EL", "SE", "AT", "OP"]]
</p></details>

```
iex> SolveServer.solve(pid, ["HER", "MIT", "NET", "PER", "PIN", "SON", "SUP", "TEN", "TOS"])
```
<details><summary>Solution</summary><p>
[["HER", "MIT", "TEN", "PIN", "TOS", "SUP", "PER", "SON", "NET"]]
</p></details>

```
iex> SolveServer.solve(pid, ["ANT", "ASH", "ASY", "BAL", "BAS", "CAL", "CAN", "DES", "HER", "INS", "LUM", "MAN", "MER", "PED", "POT", "QUE", "RAS", "SAM", "TOR", "TRA", "ULT"])
```
<details><summary>Solution</summary><p>
[["ANT", "HER", "BAL", "SAM", "BAS", "INS", "ULT", "RAS", "CAL", "MER", "MAN",
  "TRA", "DES", "POT", "ASH", "CAN", "TOR", "QUE", "ASY", "LUM", "PED"]]
</p></details>

