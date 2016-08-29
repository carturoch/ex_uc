defmodule ExUc.Value do
  defstruct value: 0, unit: :none, magnitude: :any 
end

defimpl String.Chars, for: ExUc.Value do
  def to_string(val) do
    "#{val.value}#{val.unit}"
  end
end