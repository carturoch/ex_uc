use Mix.Config

config :ex_uc, :temperature_units,
  C: "Celsius",
  F: "Fahrenheit",
  K: "Kelvin"

config :ex_uc, :temperature_conversions,
  C_to_F: &(&1 * 1.8 + 32),
  C_to_K: &(&1 + 273.15),
  F_to_C: &((&1 - 32) / 1.8),
  F_to_K: &((&1 + 459.67) / 1.8),
  K_to_F: &(&1 * 1.8 - 459.67),
  K_to_C: &(273.15 - &1)
