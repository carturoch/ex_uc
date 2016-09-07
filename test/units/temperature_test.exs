defmodule Units.TemperatureTest do
  use ExUnit.Case

  import ExUc

  test "Celcius to Fahrenheit" do
    conversion = from("20C") |> to(:F) |> as_string
    assert conversion == "68.00 F"
  end

  test "Fahrenheit to Celcius" do
    conversion = from("68F") |> to(:C) |> as_string
    assert conversion == "20.00 C"
  end

  test "Kelvin to Celcius" do
    conversion = from("0K") |> to(:C) |> as_string
    assert conversion == "-273.15 C"
  end

  test "Celcius to Kelvin" do
    conversion = from("20C") |> to(:K) |> as_string
    assert conversion == "293.15 K"
  end

  test "Kelvin to Fahrenheit" do
    conversion = from("0K") |> to(:F) |> as_string
    assert conversion == "-459.67 F"
  end

  test "Fahrenheit to Kelvin" do
    conversion = from("68F") |> to(:K) |> as_string
    assert conversion == "293.15 K"
  end
end
