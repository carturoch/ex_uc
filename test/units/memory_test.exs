defmodule Units.MemoryTest do
  use ExUnit.Case

  import ExUc

  test "megabytes to terabytes" do
    assert convert("5432876 MB", :TB) == "5.43 TB"
  end

  test "megabytes to kilobits" do
    assert convert("4 MB", :kilobits) == "32000.00 kilobits"
  end

  test "SI to ISO/ISC" do
    assert convert("1 MB", :KiB) == "976.56 KiB"
  end
end
