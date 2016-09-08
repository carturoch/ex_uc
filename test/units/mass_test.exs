defmodule Units.MassTest do
  use ExUnit.Case

  import ExUc

  test "Conversions within metric system" do
    conversion = from("0.25 kg")
    |> to(:g)
    |> to(:mg)
    |> as_string

    assert conversion == "250000.00 mg"
  end

  test "Convert grams to pounds" do
    conversion = from("100 g") |> to(:lb) |> as_string
    assert conversion == "0.22 lb"
  end

  test "Convert kilograms to pounds" do
    conversion = from("1kg") |> to(:lb) |> as_string
    assert conversion == "2.20 lb"
  end

  test "Convert grams to ounces" do
    conversion = from("100g") |> to(:oz) |> as_string
    assert conversion == "3.50 oz"

    conversion = from("2 oz") |> to(:g) |> as_string
    assert conversion == "56.70 g"
  end

  test "Convert kilograms to ounces" do
    conversion = from("1kg") |> to(:oz) |> as_string
    assert conversion == "35.27 oz"

    conversion = from("100oz") |> to(:kg) |> as_string
    assert conversion == "2.80 kg"
  end

  @tag :current
  test "Convert kilograms to pounds and ounces" do
    conversion = from("1.56 kg") |> to(:lb_oz) |> as_string
    assert conversion == "3 lb 6.91 oz"
  end
end
