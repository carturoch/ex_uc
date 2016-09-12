defmodule ExUc do
  @moduledoc """
  # Elixir Unit Converter

  Converts values with units within the same kind.

  It could be used as:
  ```elixir
  value = ExUc.from("5' 2\\"")
    |> ExUc.to(:m)
    |> ExUc.as_string
  ```
  Or:
  ```elixir
  import ExUc

  from("25C") |> to(:F) |> as_string # "77 F"
  ```

  Or simply:
  ```elixir
  "\#{ExUc.to("72F", :K)}" # "295.37 K"
  ```
  """

  alias ExUc.Value
  alias ExUc.Special
  alias ExUc.Units

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

  ```
  """
  def from(str) do
    {val, unit_str} = cond do
      Special.is_pounds_and_ounces?(str) -> Special.lb_oz_to_lb(str)
      Special.is_feet_and_inches?(str) -> Special.ft_in_to_ft(str)
      true -> Float.parse(str)
    end

    with unit <- unit_str |> String.trim |> String.to_atom,
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
  {:error, "undefined conversion"}

  ```
  """
  def to(val, _unit_to) when is_nil(val), do: {:error, "undefined origin"}
  def to(val, unit_to) when is_binary(unit_to), do: to(val, String.to_atom(unit_to))
  def to(val, unit_to) when is_binary(val), do: to(from(val), unit_to)
  def to(val, unit_to) when is_map(val) do
    with %{unit: unit_from, value: value_from, kind: _} <- val,
      {:ok, factor} <- Units.get_conversion(unit_from, unit_to),
      new_value <- apply_conversion(value_from, factor),
    do: %Value{value: new_value, unit: unit_to, kind: val.kind}
  end

  @doc """
  Converts an structured value into a string.

  ## Parameters

    - val: ExUc.Value to stringify.

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
end
