defmodule ExUc do
  @moduledoc """
  # Elixir Unit Converter

  Converts values with units within the same kind.

  It could be used as:
  ```elixir
  value = ExUc.from("5' 2\"") 
    |> ExUc.to(:m)
    |> ExUc.as_string
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

    iex> ExUc.from("5' \"")
    %ExUc.Value{value: 62, unit: :in, kind: :length}

    iex> ExUc.from("5 alien")
    nil
  """
  def from(str) do
    
  end

  @doc """
  Takes an structured value and using its kind converts it to the given unit.

  Returns %ExUc.Value{}

  ## Parameters

    - val: ExUc.Value to convert.
    - unit: Atom representing the unit to convert the `val` to.

  ## Examples

    iex> ExUc.to(%{value: 62, unit: :in, kind: :length}, :cm)
    %ExUc.Value{value: 152.0, unit: :cm, kind: :length}

    iex> ExUc.to(%{value: 100, unit: :kg, kind: :mass}, :lbs)
    %ExUc.Value{value: 220.46, unit: :lbs, kind: :mass}

  _Note: Kind is optional. _
  
    iex> ExUc.to(%{value: 100, unit: :m}, :km)
    %ExUc.Value{value: 0.1, unit: :km, kind: :mass}
  """
  def to(val, unit) do
    
  end

  @doc """
  Converts an structured value into a string.

  ## Parameters

    - val: ExUc.Value to stringify.

  ## Examples

    iex> ExUc.as_string(%ExUc.Value{value: 10, unit: :m})
    "10m"
  """
  def as_string(val) do
    "#{val}"
  end

  def units do
    Application.get_all_env(:ex_uc)
    |> Enum.filter(fn {kind, _opts} -> Atom.to_string(kind) |> String.ends_with?("_units") end)  
    |> Enum.flat_map(fn {_key, opts} -> opts end)
    |> Enum.map(fn {unit, name} -> unit end)
  end

  def kind_of_unit(unit) do
    kind = Application.get_all_env(:ex_uc)
    |> Enum.filter(fn {kind, _opts} -> Atom.to_string(kind) |> String.ends_with?("_units") end)  
    |> Enum.find(fn {kind, opts} -> opts |> Enum.into(%{}) |> Map.has_key?(unit) end) 
    
    {kind_name, _units} = kind
    kind_name 
    |> Atom.to_string 
    |> String.replace_suffix("_units", "")
  end
end
