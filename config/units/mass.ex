use Mix.Config

config :ex_uc, :mass_units,
  g: "grams",
  kg: "kilograms",
  mg: "milligrams",
  lb: "pounds",
  oz: "ounces",
  lb_oz: "pounds and ounces"

config :ex_uc, :mass_conversions,
  g_to_kg: 0.001,
  g_to_mg: 1000,
  g_to_lb: 0.0022,
  g_to_oz: 0.035,
  kg_to_g: 1000,
  kg_to_lb: 2.2,
  kg_to_oz: 35.27,
  lb_to_g: 453.59,
  lb_to_kg: 0.45,
  oz_to_g: 28.35,
  oz_to_kg: 0.028,
  kg_to_lb_oz: :kg_to_lb_oz # References a method in module Special.
