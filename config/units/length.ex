use Mix.Config

config :ex_uc, :length_units,
  m: "meter",
  km: "kilometer",
  cm: "centimeter",
  mm: "millimeter",
  ft: "feet",
  in: "inches",
  yd: "yards",
  mi: "miles"

config :ex_uc, :length_conversions,
  m_to_km: 0.001,
  m_to_cm: 100,
  m_to_mm: 1000,
  m_to_in: 39.37,
  m_to_ft: 3.281
