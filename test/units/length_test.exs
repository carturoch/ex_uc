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

end
