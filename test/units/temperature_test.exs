defmodule TemperatureTest do
  use ExUnit.Case

  import ExUc

  test "Celcius to Fahrenheit" do
    conversion = from("20C") |> to(:F) |> as_string
    assert conversion == "68.0F"
  end

  test "Fahrenheit to Celcius" do
    conversion = from("68F") |> to(:C) |> as_string
    assert conversion == "20.0C"
  end

  test "Kelvin to Celcius" do
    conversion = from("0K") |> to(:C) |> as_string
    assert conversion == "-273.15C"
  end

  test "Celcius to Kelvin" do
    conversion = from("20C") |> to(:K) |> as_string
    assert conversion == "293.15K"
  end

  test "Kelvin to Fahrenheit" do
    conversion = from("0K") |> to(:F) |> as_string
    assert conversion == "-459.67F"
  end

  test "Fahrenheit to Kelvin" do
    conversion = from("68F") |> to(:K) |> as_string
    assert conversion == "293.15K"
  end
end
