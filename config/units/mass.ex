# Sample for how to override existent default mass conversions.

use Mix.Config

config :ex_uc, :mass_units,
  g: ~w(grams gram gramo gramos), # Overriding aliases
  st: ~w(stone stones) # New unit aliases

# Overriding conversions
config :ex_uc, :mass_conversions,
  kg_to_lb: 2.20462, # Way more precision required
  st_to_lb: 14 # New unit conversions
