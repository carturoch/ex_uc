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
    conversion = from("100 g") |> to(:lb) |> as_string
    assert conversion == "0.22 lb"
  end

end
