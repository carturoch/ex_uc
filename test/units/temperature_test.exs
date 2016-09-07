defmodule TemperatureTest do
  use ExUnit.Case

  import ExUc

  test "Celcius to Fahrenheit" do
    conversion = ExUc.from("20 C") |> ExUc.to(:F) |> ExUc.to_string
    assert conversion == "68 F"
  end
end
