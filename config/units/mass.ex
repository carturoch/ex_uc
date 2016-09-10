use Mix.Config

config :ex_uc, :mass_units,
  g: ~w(grams gram)a,
  kg: ~w(kilograms kilogram)a,
  mg: ~w(milligrams)a,
  lb: ~w(pounds pound lbs)a,
  oz: ~w(ounces ounce oz)a

config :ex_uc, :mass_conversions,
  g_to_kg: 0.001,
  g_to_mg: 1000,
  g_to_lb: 0.0022,
  g_to_oz: 0.035,
  kg_to_g: 1000,
  kg_to_lb: 2.2,
  kg_to_oz: 35.27,
  lb_to_g: 453.59,
  lb_to_oz: 16,
  lb_to_kg: 0.45,
  oz_to_g: 28.35,
  oz_to_kg: 0.028,
  kg_to_lb_oz: :kg_to_lb_oz # References a method in module Special.
