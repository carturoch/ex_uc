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

  defp format_value(int) when is_integer(int), do: "#{int}.00"
  defp format_value(float) when is_float(float) do
    precision = Application.get_env(:ex_uc, :precision)
    float
    |> Float.round(precision)
    |> Float.to_string(decimals: precision)
  end
end
