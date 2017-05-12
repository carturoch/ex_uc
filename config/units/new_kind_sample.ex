# Sample for user defined kinds
use Mix.Config

config :ex_uc, :sample_units,
  xf: ~w(xufi xufis), # New unit aliases
  zb: ~w(zubi zubies) # New unit aliases

# Overriding conversions
config :ex_uc, :sample_conversions,
  xf_to_zb: 25 # New unit conversions
