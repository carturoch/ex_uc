defmodule UnitsTest do
  use ExUnit.Case
  doctest ExUc.Units

  import ExUc.Units

  test "Key alias are found as symbols" do
    assert get_key_alias("pounds", :mass) == :lb
    assert get_key_alias(:pounds, :mass) == :lb
  end

  test "all/0 includes module defined units and conversions" do
    assert Keyword.has_key? all(), :temperature_units
    assert Keyword.has_key? all(), :temperature_conversions
  end

  test "conversions/1 get all the conversions for the given kind" do
     assert Map.has_key? all_conversions(:temperature), :C_to_F
  end
end
