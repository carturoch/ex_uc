defmodule UnitsTest do
  use ExUnit.Case
  doctest ExUc.Units

  import ExUc.Units

  test "Key alias are found as symbols" do
    assert get_key_alias("pounds", :mass) == :lb
    assert get_key_alias(:pounds, :mass) == :lb
  end
end
