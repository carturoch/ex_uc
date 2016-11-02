use Mix.Config

# Precision when serializing the converted value to string
config :ex_uc, precision: 2

# Trim zeros from exact results
config :ex_uc, allow_exact_results: false

import_config "units/*.ex"
