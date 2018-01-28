defmodule Units.LengthTest do
  use ExUnit.Case

  import ExUc

  test "Gets defitions from behaviour" do
    alias ExUc.Units.Length
    definition_keys = Length.definitions() |> Keyword.keys()
    assert definition_keys == [:length_units, :length_conversions]
  end

  test "Conversions within metric system" do
    conversion =
      from("2000 cm")
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

  test "Feet and inches to meters" do
    conversion = from("45 ft 2.5 in") |> to(:m) |> as_string
    assert conversion == "13.78 m"
  end

  test "Use and alias for feet" do
    conversion = from("50 meters") |> to(:km) |> as_string
    assert conversion == "0.05 km"
  end

  test "recognizes the quote notation for feet" do
    assert convert("5'", :m) == "1.52 m"
  end

  test "recognizes the quote notation for inches" do
    assert convert("19\"", :cm) == "48.26 cm"
  end
end
