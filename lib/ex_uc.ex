defmodule ExUc do
  @moduledoc """
  # Elixir Unit Converter

  Converts values with units within the same magnitude.

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

  ## Examples

    iex> ExUc.from("5' \"")
    %ExUc.Value{value: 62, unit: :in, magnitude: :length}

    iex> ExUc.from("5 alien")
    nil
  """
  def from(str) do
    
  end

  @doc """
  Takes an structured value and using its magnitude converts it to the given unit.

  Returns %ExUc.Value{}

  ## Examples

    iex> ExUc.to(%{value: 62, unit: :in, magnitude: :length}, :cm)
    %ExUc.Value{value: 152.0, unit: :cm, magnitude: :length}

    iex> ExUc.to(%{value: 100, unit: :kg, magnitude: :mass}, :lbs)
    %ExUc.Value{value: 220.46, unit: :lbs, magnitude: :mass}

    _Note: Magnitude is optional. _
    iex> ExUc.to(%{value: 100, unit: :m}, :km)
    %ExUc.Value{value: 0.1, unit: :km, magnitude: :mass}
  """
  def to(val, unit) do
    
  end

  @doc """
  Converts an structured value into a string.

  ## Examples

    iex> ExUc.as_string(%ExUc.Value{value: 10, unit: :m})
    "10m"
  """
  def as_string(val) do
    "#{val}"
  end
end
