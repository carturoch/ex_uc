defmodule ExUc.Units.Pressure do
  @moduledoc """
  Defines units and conversions for the Pressure kind.
  """
  @behaviour ExUc.Kind

  def units do
    [
      Pa: ~w(Pascal),
      hPa: ~w(Hectopascal),
      kPa: ~w(Kilopascal kilopascal kilopascals),
      bar: ~w(Bar bar bars),
      at: "Technical atmosphere",
      atm: "Standard atmosphere",
      mmHg: ~w(Torr torr Torrs torrs),
      psi: "Pounds per square inch"
    ]
  end

  def conversions do
    [
      kPa_to_Pa: 1000,
      hPa_to_Pa: 100,
      bar_to_kPa: 100,
      bar_to_at: 1.0197,
      bar_to_atm: 0.9869,
      bar_to_mmHg: 750.06,
      bar_to_psi: 14.5037
    ]
  end
end
