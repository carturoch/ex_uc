defmodule ExUc do
  @moduledoc """
  # Elixir Unit Converter

  Converts values between units.

  ## Usage

  The quickest way is the function `convert`:
  ```elixir
  ExUc.convert("5 pounds", "oz") # "80.00 oz"
  ```
  This is just a shortcut for the 3-steps pipeline:
  ```elixir
  import ExUc

  new_val = from("5 pounds")  # %ExUc.Value{unit: :lb, value: 5, kind: :mass}
  |> to(:oz)                  # %ExUc.Value{unit: :oz, value: 80, kind: :mass}
  |> as_string                # "80.00 oz"
  ```

  ### Errors

  Only two errors are returned when found, both as self descriptive **strings**:

    - `"undefined origin"`: Unit for the original value can't be parsed or found in the configuration.
    - `"undetermined conversion"`: Conversion between the given units can't be determined.

  """

  alias ExUc.{Value, Special, Units}

  @doc """
  Parses a string into a structured value. When is not possible to get
  a value from the given string, `nil` will be returned. This makes the
  process to fail by not being able to match a valid struct.

  Returns %ExUc.Value{}

  ## Parameters

    - str: String containing the value and unit to convert.

  ## Examples
  ```

  iex>ExUc.from("500 mg")
  %ExUc.Value{value: 500.0, unit: :mg, kind: :mass}

  iex>ExUc.from("5 alien")
  nil

  iex>ExUc.from("two miles")
  nil

  ```
  """
  def from(str) do
    {val, unit_str} =
      cond do
        Special.is_pounds_and_ounces?(str) -> Special.lb_oz_to_lb(str)
        Special.is_feet_and_inches?(str) -> Special.ft_in_to_ft(str)
        String.match?(str, ~r/^\d/) -> Float.parse(str)
        true -> {nil, ""}
      end

    with unit <- unit_str |> String.trim() |> String.to_atom(),
         kind_str <- Units.get_kind(unit),
         _next when not is_nil(kind_str) <- kind_str,
         kind <- String.to_atom(kind_str),
         do: %Value{value: val, unit: unit, kind: kind}
  end

  @doc """
  Takes an structured value and using its kind converts it to the given unit.

  Returns %ExUc.Value{}

  ## Parameters

    - val: ExUc.Value to convert.
    - unit: Atom representing the unit to convert the `val` to.

  ## Examples
  ```
  iex> ExUc.to(%{value: 20, unit: :g, kind: :mass}, :mg)
  %ExUc.Value{value: 20000, unit: :mg, kind: :mass}

  iex> ExUc.to("15C", :K)
  %ExUc.Value{value: 288.15, unit: :K, kind: :temperature}

  # Errors:
  iex> ExUc.to(nil, :g)
  {:error, "undefined origin"}

  iex> ExUc.to("10kg", :xl)
  {:error, "undetermined conversion"}

  ```
  """
  def to(val, _unit_to) when is_nil(val), do: {:error, "undefined origin"}
  def to(val, unit_to) when is_binary(val), do: to(from(val), unit_to)

  def to(val, unit_to) when is_map(val) do
    with %{unit: unit_from, value: value_from, kind: _} <- val,
         {:ok, factor} <- Units.get_conversion(unit_from, unit_to),
         new_value <- apply_conversion(value_from, factor),
         do: %Value{value: new_value, unit: unit_to, kind: val.kind}
  end

  @doc """
  Converts values between units of the same kind.

  This function is a shortcut to get the string version of the converted value.

  ## Parameters

    - from_str: String with the value to convert.
    - to: String or Atom with the unit to convert to.

  ## Examples
  ```

  iex>ExUc.convert("5 pounds", "oz")
  "80.00 oz"

  ```
  """
  def convert(from_str, to) do
    to(from_str, to) |> as_string
  end

  @doc """
  Converts an structured value into a string.

  ## Parameters

    - val: ExUc.Value to convert to string.

  ## Examples
  ```

  iex> ExUc.as_string(%ExUc.Value{value: 10, unit: :m})
  "10.00 m"

  iex> ExUc.as_string({:error, "some error"})
  "some error"

  ```
  """
  def as_string({:error, msg}) when is_binary(msg), do: msg

  def as_string(val) do
    "#{val}"
  end

  defp apply_conversion(val, factor) when is_number(factor), do: val * factor
  defp apply_conversion(val, formule) when is_function(formule), do: formule.(val)
  defp apply_conversion(val, method) when is_atom(method), do: apply(Special, method, [val])

  defp apply_conversion(val, path) when is_list(path) do
    [from | steps] = path
    value = %Value{unit: from, value: val}

    Enum.reduce(steps, value, fn unit, acc ->
      to(acc, unit)
    end).value
  end
end
