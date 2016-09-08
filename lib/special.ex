defmodule Special do
  @moduledoc """
  # Special conversions.

  For conversions where simple formules are not enough the config file will
  reference using an atom a method of this module.

  """


  @doc """
  Converts from kilograms to pounds and ounces

  Returns String

  ## Parameters

    - value: Numeric value for kilograms.

  ## Examples
  ```

  iex>Special.kg_to_lb_oz(20.15)
  "44 lb 5.28 oz"

  ```
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

  @doc """
  Checks if a string is a special pounds and ounces value

  Returns Boolean

  ## Parameters

    - str: String with values and units.

  ## Examples
  ```

  iex>Special.is_pounds_and_ounces?("23 lb 4 oz")
  true

  iex>Special.is_pounds_and_ounces?("12.566 lb")
  false

  ```
  """
  def is_pounds_and_ounces?(str) do
    String.match?(str, ~r/(\d+(\.\d+)?)\s*lb.(\d+(\.\d+)?)\s*oz/)
  end

  @doc """
  Converts from pounds and ounces to pounds.
  """
  def lb_oz_to_lb(str) do
    [pounds_str, _lb, ounces_str, _oz] = String.split(str, " ")
    {pounds, _} = Float.parse(pounds_str)
    {ounces, _} = Float.parse(ounces_str)
    all_pounds = pounds + (ounces * 0.063)
    {all_pounds, "lb"}
  end
end
