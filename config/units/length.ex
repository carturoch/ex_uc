use Mix.Config

config :ex_uc, :length_units,
  m: ~w(meter meters)a,
  km: ~w(kilometer kilometer kms)a,
  cm: ~w(centimeter centimeters)a,
  mm: ~w(millimeter millimeters)a,
  ft: ~w(feet foot)a,
  in: ~w(inches)a,
  yd: ~w(yard yards yds)a,
  mi: ~w(mile miles)a,
  ft_in: "feet and inches"

config :ex_uc, :length_conversions,
  m_to_km: 0.001,
  m_to_cm: 100,
  m_to_mm: 1000,
  m_to_in: 39.37,
  m_to_ft: 3.281,
  m_to_ft_in: :m_to_ft_in,
  ft_to_in: 12
