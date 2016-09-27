defmodule Units.PressureTest do
  use ExUnit.Case

  import ExUc

  test "Pascal to bars" do
    assert convert("100 hPa", "bars") == "0.10 bars"
  end

  test "Pascal to Torr" do
    assert convert("100 Pa", "Torrs") == "0.75 Torrs"
  end

  test "Atm to kPa" do
    assert convert("1 Standard atmosphere", "kilopascal") == "101.33 kilopascal"
  end
end
