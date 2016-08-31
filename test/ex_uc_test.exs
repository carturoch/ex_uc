defmodule ExUcTest do
  use ExUnit.Case
  doctest ExUc

  import ExUc

  test "it gets a list of all units" do
    all_units = [:g, :kg, :mg, :lb]
    assert units == all_units
  end

  test "it gets the kind of unit as a string" do
    assert kind_of_unit(:kg) == "mass"
  end
end
