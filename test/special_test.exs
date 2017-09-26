defmodule SpecialTest do
  use ExUnit.Case
  doctest ExUc.Special

  import ExUc

  describe "composed unit conversions" do
    test "converts from ft_in" do
      assert convert("7 ft 6 in", "ft") == "7.50 ft"
      assert convert("6 ft 1 in", "m") == "1.85 m"
    end

    test "recognizes ft_in with quote notation" do
      assert convert(~s(7 ' 6 "), "ft") == "7.50 ft"
      assert convert(~s(7' 6"), "ft") == "7.50 ft"
    end

  end
end
