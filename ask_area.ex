defmodule AskArea do
  import Geom
  @moduledoc """
  Command line utility for finding the area of various shapes.
  """

  @doc """
  Asks for shape, dimenion x, and dimension y then prints the result

  iex> AskArea.area()
  R)ectangle, T)riangle, or E)llipse: r
  Enter width > 4
  Enter height > 3
  12
  """

  def area() do
    shape = get_shape()
    inputs = get_dimensions("height", "width")
    calculate(shape, inputs) |> IO.puts
  end

  defp get_shape() do
    shape = get_input "R)ectangle, T)riangle, or E)llipse: "
    shape
    |> String.first
    |> String.downcase
    |> char_to_shape
  end

  defp char_to_shape(shape_char) do
    case shape_char do
      "r" -> :rectangle
      "t" -> :triangle
      "e" -> :ellipse
      _ -> cancel "Unknown shape #{shape_char}"
    end
  end

  defp get_dimensions(dimen1, dimen2) do
    n1 = dimen1 |> get_number
    n2 = dimen2 |> get_number
    {n1, n2}
  end

  defp get_number(property_name) do
    number = get_input "Enter #{property_name} >"
    String.to_integer(number)
  end

  defp calculate(shape, inputs) do
    x = elem(inputs, 0)
    y = elem(inputs, 1)
    cond do
      x < 0 or y < 0 -> cancel "Both numbers must be greater than or equal to zero."
      true -> Geom.area shape, x, y
    end
  end

  defp get_input(prompt) do
    input = IO.gets "#{prompt} "
    input |> String.strip
  end

  defp cancel(message), do: message |> IO.puts
end