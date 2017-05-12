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

  test "configuration defined conversions override modules one" do
    conversions = all_conversions(:mass)
    assert conversions[:kg_to_lb] == 2.20462
    assert Enum.count(conversions) > 1
  end

  test "configuration defined aliases override modules ones" do
    gram_key = get_key_alias(:gramos, :mass)
    assert gram_key == :g
  end

  @tag :current
  test "units defined in config are loaded among defaults" do
    assert get_key_alias(:stone, :mass) == :st

    conversions = all_conversions(:mass)
    assert conversions[:st_to_lb] == 14
  end
end
