defmodule Units.KindTest do
  use ExUnit.Case

  import ExUc

  @modules [
    ExUc.Units.Length,
    # ExUc.Units.Mass,
    # ExUc.Units.Memory,
    # ExUc.Units.Pressure,
    # ExUc.Units.Speed,
    # ExUc.Units.Temperature,
    # ExUc.Units.Time
  ]
  
  test "all unit conversions return no error" do
    @modules |> Enum.all?(&(conversions_are_correct(&1)))
  end

  def conversions_are_correct(module) do
    module.units
    |> Enum.filter(fn {k, _} -> k not in [:ft_in, :lb_oz] end)
    |> Enum.reduce(fn({k, _}, {k0, _}) -> 
      assert is_map to("1#{k}", k0)
      {k, [k0]} 
    end)
  end
end