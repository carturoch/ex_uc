defmodule ExUcTest do
  use ExUnit.Case
  doctest ExUc

  import ExUc

  test "trims decimal zeros for exact values when enabled in config" do
  	assert convert("5.50 MB", :KB) == "5500.00 KB"

  	Application.put_env(:ex_uc, :allow_exact_results, true)
  	assert convert("5.50 MB", :KB) == "5500 KB"
  end
end
