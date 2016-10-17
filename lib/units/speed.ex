defmodule ExUc.Units.Speed do
  @moduledoc """
  Defines units and conversions for the Speed kind.

  The speed of an object is the magnitude of its velocity (the rate of change of its position).

  ## Included Units and Aliases

    - **mps**, m/s, meters per second
    - **kmph**, km/h, kilometers per hour
    - **miph**, mi/h, mph, miles per hour
    - **kn**, knot, knots, kt

  """
  @behaviour ExUc.Kind

  def units do
    [
      mps: ["m/s", "meters per second"],
      kmph: ["km/h", "kilometers per hour"],
      miph: ["mi/h", "mph", "miles per hour"],
      kn: ~w(knot knots kt)
    ]
  end

  def conversions do
    [
      kmph_to_mps: 0.28,
      kmph_to_miph: 0.62,
      kn_to_mps: 0.51
    ]
  end
end
