defmodule LightGrid do
  def solve do
    "../input" 
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.reduce(%{}, fn line, grid -> parse_instruction(line, grid) end)
    |> Map.size()
    |> IO.inspect()    
  end

  defp parse_instruction(line, grid) do
    regex = ~r/(turn on|turn off|toggle) (\d+),(\d+) through (\d+),(\d+)/
    [_, command, x1, y1, x2, y2] = Regex.run(regex, line)

    range_x = String.to_integer(x1)..String.to_integer(x2)
    range_y = String.to_integer(y1)..String.to_integer(y2)

    Enum.reduce(range_x, grid, fn x, acc_grid -> 
      Enum.reduce(range_y, acc_grid, fn y, acc ->
        handle_light(acc, command, {x, y})
      end)
    end)
  end

  defp handle_light(grid, "turn on", pos), do: Map.put(grid, pos, true)
  defp handle_light(grid, "turn off", pos), do: Map.delete(grid, pos)
  defp handle_light(grid, "toggle", pos) do
    if Map.has_key?(grid, pos) do 
      Map.delete(grid, pos)
    else
      Map.put(grid, pos, true)
    end
  end
end

LightGrid.solve()
