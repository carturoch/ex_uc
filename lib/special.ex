defmodule ExUc.Special do
  @moduledoc """
  # Special conversions.

  For conversions where simple formules are not enough the config file will
  reference using an atom a method of this module.

  """

  @precision Application.get_env(:ex_uc, :precision)

  @doc """
  Converts from kilograms to pounds and ounces

  Returns String.t

  ## Parameters

    - value: Numeric value for kilograms.

  ## Examples
  ```

  iex>ExUc.Special.kg_to_lb_oz(20.15)
  "44 lb 5.28 oz"

  ```
  """
  def kg_to_lb_oz(kgs) do
    as_lbs = kgs * 2.2
    lbs = trunc(as_lbs)
    partial_lbs = as_lbs - lbs
    ozs = Float.round(partial_lbs * 16, @precision)

    case ozs do
      0 -> "#{lbs} lb 0 oz"
      _ -> "#{lbs} lb #{ozs} oz"
    end
  end

  @doc """
  Converts from meters to feet and inches.

  Returns String.t

  ## Parameters

    - meters: Numeric meters value

  ## Examples
  ```

  iex> ExUc.Special.m_to_ft_in(10.35)
  "33 ft 11.5 in"

  ```
  """
  def m_to_ft_in(meters) do
    as_feet = meters * 3.281
    feet = trunc(as_feet)
    partial_feet = as_feet - feet
    inches = Float.round(partial_feet * 12, @precision)

    case inches do
      0 -> "#{feet} ft 0 in"
      _ -> "#{feet} ft #{inches} in"
    end
  end

  @doc """
  Checks if a string is a special pounds and ounces value

  Returns Boolean

  ## Parameters

    - str: String with values and units.

  ## Examples
  ```

  iex>ExUc.Special.is_pounds_and_ounces?("23 lb 4 oz")
  true

  iex>ExUc.Special.is_pounds_and_ounces?("12.566 lb")
  false

  ```
  """
  def is_pounds_and_ounces?(str) do
    String.match?(str, ~r/(\d+(\.\d+)?)\s*lb.(\d+(\.\d+)?)\s*oz/)
  end

  @doc """
  Checks if a string is a special feet and inches value.

  Returns Boolean

  ## Parameters

    - str: String with values and units.

  ## Examples
  ```

  iex>ExUc.Special.is_feet_and_inches?("6 ft 2.2 in")
  true

  iex>ExUc.Special.is_feet_and_inches?("6 ft")
  false

  ```
  """
  def is_feet_and_inches?(str) do
    String.match?(str, ~r/(\d+(\.\d+)?)\s*ft.(\d+(\.\d+)?)\s*in/)
  end

  @doc """
  Converts from pounds and ounces, to pounds.

  Returns {VALUE_IN_POUNDS, "lb"}

  ## Parameters

    - str: String with pounds and ounces value

  ## Examples
  ```

  iex>ExUc.Special.lb_oz_to_lb("4 lb 5 oz")
  {4.315, "lb"}

  ```
  """
  def lb_oz_to_lb(str) do
    [pounds_str, _lb, ounces_str, _oz] = String.split(str, " ")
    {pounds, _} = Float.parse(pounds_str)
    {ounces, _} = Float.parse(ounces_str)
    all_pounds = pounds + (ounces * 0.063)
    {all_pounds, "lb"}
  end

  @doc """
  Converts from feet and inches, to feet.

  Returns {VALUE_IN_FEET, "ft"}

  ## Parameters

    - str: String with feet and inches value

  ## Examples
  ```

  iex>ExUc.Special.ft_in_to_ft("6 ft 2 in")
  {6.166, "ft"}

  ```
  """
  def ft_in_to_ft(str) do
    [feet_str, _lb, inches_str, _oz] = String.split(str, " ")
    {feet, _} = Float.parse(feet_str)
    {inches, _} = Float.parse(inches_str)
    all_feet = feet + (inches * 0.083)
    {all_feet, "ft"}
  end
end
