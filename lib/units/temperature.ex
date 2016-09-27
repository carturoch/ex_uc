defmodule ExUc.Units.Temperature do
  @moduledoc """
  Defines units and conversions for the Temperature kind.
  """
  @behaviour ExUc.Kind

  def units do
    [
      C: "Celsius",
      F: "Fahrenheit",
      K: "Kelvin"
    ]
  end

  def conversions do
    [
      C_to_F: &(&1 * 1.8 + 32),
      C_to_K: &(&1 + 273.15),
      F_to_C: &((&1 - 32) / 1.8),
      F_to_K: &((&1 + 459.67) / 1.8),
      K_to_F: &(&1 * 1.8 - 459.67),
      K_to_C: &(&1 - 273.15)
    ]
  end
end
