defmodule Units.SpeedTest do
  use ExUnit.Case

  import ExUc, only: [convert: 2]

  test "Miles per hour to knots" do
    conversion =
      convert("20 km/h", "mps")
      |> convert("mph")
      |> convert("knots")

    assert conversion == "10.98 knots"
  end
end
