defmodule ExUc.Value do
  defstruct value: 0, unit: :none, kind: :any
end

defimpl String.Chars, for: ExUc.Value do
  def to_string(val), do: "#{format_value(val.value)} #{val.unit}"

  defp format_value(int) when is_integer(int), do: "#{int}.00"
  defp format_value(float) when is_float(float) do
    precision = Application.get_env(:ex_uc, :precision)
    float
    |> Float.round(precision)
    |> Float.to_string(decimals: precision)
  end
end
