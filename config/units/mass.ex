use Mix.Config

config :ex_uc, :mass_units,
  g: "grams",
  kg: "kilograms",
  mg: "milligrams",
  lb: "pounds"

config :ex_uc, :mass_conversions,
  g_to_kg: 0.001,
  g_to_mg: 1000,
  g_to_lb: 0.0022
  