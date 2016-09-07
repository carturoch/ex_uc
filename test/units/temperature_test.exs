defmodule TemperatureTest do
  use ExUnit.Case

  import ExUc

  test "Celcius to Fahrenheit" do
    conversion = ExUc.from("20C") |> ExUc.to(:F) |> ExUc.as_string
    assert conversion == "68.0F"
  end

  test "Fahrenheit to Celcius" do
    conversion = ExUc.from("68F") |> ExUc.to(:C) |> ExUc.as_string
    assert conversion == "20.0C"
  end

  test "Kelvin to Celcius" do
    conversion = ExUc.from("0K") |> ExUc.to(:C) |> ExUc.as_string
    assert conversion == "-273.15C"
  end

  test "Celcius to Kelvin" do
    conversion = ExUc.from("20C") |> ExUc.to(:K) |> ExUc.as_string
    assert conversion == "293.15K"
  end

  test "Kelvin to Fahrenheit" do
    conversion = ExUc.from("0K") |> ExUc.to(:F) |> ExUc.as_string
    assert conversion == "-459.67F"
  end

  test "Fahrenheit to Kelvin" do
    conversion = ExUc.from("68F") |> ExUc.to(:K) |> ExUc.as_string
    assert conversion == "293.15K"
  end
end
