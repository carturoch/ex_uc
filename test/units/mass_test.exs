defmodule Units.MassTest do
  use ExUnit.Case

  import ExUc

  test "Conversions within metric system" do
    conversion = from("0.25 kg")
    |> to(:g)
    |> to(:mg)
    |> as_string

    assert conversion == "250000.00mg"
  end

end
