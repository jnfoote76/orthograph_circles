defmodule OrthographCircles do
  @moduledoc """
  Documentation for OrthographCircles.
  """

  def solve(orthographs, word_map) do
    [first | others] = orthographs
    |> Enum.map(fn elem -> String.upcase(elem) end)
    |> Enum.sort()

    solve_help([first], others, word_map, [])
  end

  defp solve_help(curr_sol_reversed, [], word_map, already_found_sols) do 
    [curr_word_start | _] = curr_sol_reversed
    [sol_beginning | rest_of_solution] = Enum.reverse(curr_sol_reversed)

    cond do
      Map.has_key?(word_map, curr_word_start <> sol_beginning) ->
        [[sol_beginning | rest_of_solution] | already_found_sols]
      true ->
        already_found_sols
    end
  end

  defp solve_help(curr_sol_reversed, remaining_orthographs, word_map, already_found_sols) do
    [curr_word_start | _] = curr_sol_reversed
    
    case valid_pairs(curr_word_start, remaining_orthographs, word_map) do
      [] -> already_found_sols
      curr_valid_pairs ->
        List.foldr(curr_valid_pairs, already_found_sols, fn (elem, acc) ->
          without_elem = List.delete(remaining_orthographs, elem)
          solve_help([elem | curr_sol_reversed], without_elem, word_map, acc) 
        end)
    end
  end

  defp valid_pairs(start, remaining_orthographs, word_map) do
    List.foldr(remaining_orthographs, [], fn (elem, acc) ->
      cond do
        Map.has_key?(word_map, start <> elem) -> [elem | acc]
        true -> acc
      end
    end)
  end
end
