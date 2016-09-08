defmodule Special do
  @moduledoc """
  # Special conversions.

  For conversions where simple formules are not enough the config file will
  reference using an atom a method of this module.

  _*Note:* Every method should expect a single value as argument._
  """


  @doc """
  Converts from kilograms to pounds and ounces

  Returns String

  ## Parameters

    - value: Numeric value for kilograms.

  ## Examples

    iex>Special.kg_to_lb_oz(20.15)
    "44 lb 5.28 oz"

  """
  def kg_to_lb_oz(kgs) do
    as_lbs = kgs * 2.2
    lbs = trunc(as_lbs)
    partial_lbs = as_lbs - lbs
    ozs = Float.round(partial_lbs * 16, 2)

    case ozs do
      0 -> "#{lbs} lb 0 oz"
      _ -> "#{lbs} lb #{ozs} oz"
    end
  end
end
