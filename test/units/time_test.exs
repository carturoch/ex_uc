defmodule Units.TimeTest do
  use ExUnit.Case

  import ExUc

  test "Days to milliseconds" do
    result =
      convert("5 d", :h)
      |> convert(:min)
      |> convert(:s)
      |> convert(:ms)

    assert result == "432000000.00 ms"
    assert convert("5 days", :ms) == "432000000.00 ms"
  end

  test "Seconds to microseconds" do
    assert convert("5 secs", "μs") == "5000000.00 μs"
  end
end
