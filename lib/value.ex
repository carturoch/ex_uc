defmodule ExUc.Value do
  @moduledoc """
  Structured represtation of a value with unit.
  """

  defstruct value: 0, unit: :none, kind: :any
end

defimpl String.Chars, for: ExUc.Value do
  # Special cases
  def to_string(%{value: val, kind: :mass, unit: :lb_oz}), do: "#{val}" # Already comes as a formatted string
  def to_string(%{value: val, kind: :length, unit: :ft_in}), do: "#{val}" # Already comes as a formatted string
  def to_string(val), do: "#{format_value(val.value)} #{val.unit}"

  # Format regular values using precision
  defp format_value(int) when is_integer(int), do: "#{int}.00" |> maybe_exact
  defp format_value(float) when is_float(float) do
    precision = ExUc.Units.precision()
    float
    |> Float.round(precision)
    |> Float.to_string(decimals: precision)
    |> maybe_exact
  end

  # Check if exact results are allowed and if are trim zeros
  def maybe_exact(val), do: maybe_exact(val, ExUc.Units.allow_exact_results())
  def maybe_exact(val, false), do: val
  def maybe_exact(val, true) do
    cond do
      String.ends_with?(val, ".00") -> 
        String.replace_suffix(val, ".00", "")
      true -> 
        val  
    end
  end
end
