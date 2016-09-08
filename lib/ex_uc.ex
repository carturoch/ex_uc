defmodule ExUc do
  @moduledoc """
  # Elixir Unit Converter

  Converts values with units within the same kind.

  It could be used as:
  ```elixir
  value = ExUc.from("5' 2\" ")
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

  @doc """
  Parses a string into a structured value. When is not possible to get
  a value from the given string, `nil` will be returned. This makes the
  process to fail by not being able to match a valid struct.

  Returns %ExUc.Value{}

  ## Parameters

    - str: String containing the value and unit to convert.

  ## Examples

    iex>ExUc.from("500 mg")
    %ExUc.Value{value: 500.0, unit: :mg, kind: :mass}

    iex>ExUc.from("5 alien")
    nil
  """
  def from(str) do
    with {val, unit_str} <- Float.parse(str),
      unit <- unit_str |> String.trim |> String.to_atom,
      kind_str <- kind_of_unit(unit),
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

    iex> ExUc.to(%{value: 20, unit: :g, kind: :mass}, :mg)
    %ExUc.Value{value: 20000, unit: :mg, kind: :mass}

    iex> ExUc.to("15C", :K)
    %ExUc.Value{value: 288.15, unit: :K, kind: :temperature}

    _Errors:_
    iex> ExUc.to(nil, :g)
    {:error, "undefined origin"}

    iex> ExUc.to("10kg", :xl)
    {:error, "undefined conversion"}

  """
  def to(val, _unit_to) when is_nil(val), do: {:error, "undefined origin"}
  def to(val, unit_to) when is_binary(val), do: to(from(val), unit_to)
  def to(val, unit_to) when is_map(val) do
    with %{unit: unit_from, value: value_from, kind: _} <- val,
      {:ok, factor} <- get_conversion(unit_from, unit_to),
      new_value <- apply_conversion(value_from, factor),
    do: %Value{value: new_value, unit: unit_to, kind: val.kind}
  end

  @doc """
  Converts an structured value into a string.

  ## Parameters

    - val: ExUc.Value to stringify.

  ## Examples

    iex> ExUc.as_string(%ExUc.Value{value: 10, unit: :m})
    "10.00 m"
  """
  def as_string(val) do
    "#{val}"
  end

  @doc """
  Gets a list of all the unit symbols defined in config.

  Returns List
  """
  def units do
    Application.get_all_env(:ex_uc)
    |> Enum.filter(fn {kind, _opts} -> Atom.to_string(kind) |> String.ends_with?("_units") end)
    |> Enum.flat_map(fn {_key, opts} -> opts end)
    |> Enum.map(fn {unit, _name} -> unit end)
  end

  @doc """
  Gets the kind of unit for the given unit.

  ## Parameters

    - unit: Atom representing the unit to find the kind.

  ## Examples

    iex>ExUc.kind_of_unit(:kg)
    "mass"

  Returns String
  """
  def kind_of_unit(unit) do
    kind = Application.get_all_env(:ex_uc)
    |> Enum.filter(fn {kind, _opts} -> Atom.to_string(kind) |> String.ends_with?("_units") end)
    |> Enum.find(fn {_kind, opts} -> opts |> Enum.into(%{}) |> Map.has_key?(unit) end)

    case kind do
      {kind_name, _units} -> kind_name
        |> Atom.to_string
        |> String.replace_suffix("_units", "")

      _ -> nil
    end
  end

  @doc """
  Gets the conversion factor for the units

  Returns Atom.t, Integer.t, Float.t

  ## Parameters

    - from: Atom representing the unit to convert from
    - to: Atom representing the unit to convert to

  ## Examples

    iex>ExUc.get_conversion(:g, :mg)
    {:ok, 1000}

    iex>ExUc.get_conversion(:g, :zz)
    {:error, "undefined conversion"}

  """
  def get_conversion(from, to) do
    conversion_key = "#{kind_of_unit(from)}_conversions" |> String.to_atom

    conversion = Application.get_env(:ex_uc, conversion_key)
    |> Enum.map(&parse_conversion/1)
    |> Enum.find(fn map -> {map[:from], map[:to]} == {from, to} end)

    case conversion do
      nil -> {:error, "undefined conversion"}
      _ -> {:ok, Map.get(conversion, :by)}
    end
  end

  defp parse_conversion({key, val}) do
    [from, to] = key
    |> Atom.to_string
    |> String.split("_to_")
    |> Enum.map(&String.to_atom/1)

    %{from: from, to: to, by: val}
  end

  defp apply_conversion(val, factor) when is_number(factor), do: val * factor
  defp apply_conversion(val, formule) when is_function(formule), do: formule.(val)
  defp apply_conversion(val, method) when is_atom(method), do: apply(Special, method, [val])
end
