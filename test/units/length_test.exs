defmodule Units.LengthTest do
  use ExUnit.Case

  import ExUc

  test "Conversions within metric system" do
    conversion = from("2000 cm")
      |> to(:m)
      |> to(:km)
      |> as_string
    assert conversion == "0.02 km"
  end

  test "Meters to feet" do
    conversion = from("100 m") |> to(:ft) |> as_string
    assert conversion == "328.10 ft"
  end

  test "Meters to feet and inches" do
    conversion = from("123.5 m") |> to(:ft_in) |> as_string
    assert conversion == "405 ft 2.44 in"
  end
end
