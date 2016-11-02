defmodule ExUc.Units.Time do
  @moduledoc """
  Defines units and conversions for the Time kind.

  Time is the indefinite continued progress of existence and events
  that occur in apparently irreversible succession from the past
  through the present to the future.

  ## Included Units and Aliases

    - **Ms**, μs, microsecond, microseconds
    - **ms**, millisecond, milliseconds
    - **s**, sec, secs, second, seconds
    - **min**, mins, minute, minutes
    - **h**, hrs, hour, hours
    - **d**, day, days

  """
  use ExUc.Kind

  def units do
    [
      Ms: ~w(μs microsecond microseconds),
      ms: ~w(millisecond milliseconds),
      s: ~w(sec secs second seconds),
      min: ~w(mins minute minutes),
      h: ~w(hrs hour hours),
      d: ~w(day days)
    ]
  end

  def conversions do
    [
      s_to_Ms: 1.0e6,
      s_to_ms: 1000,
      min_to_s: 60,
      h_to_min: 60,
      d_to_h: 24
    ]
  end
end
