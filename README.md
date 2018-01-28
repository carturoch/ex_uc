# ExUc - Elixir Unit Converter

[![Build Status](https://travis-ci.org/carturoch/ex_uc.svg?branch=master)](https://travis-ci.org/carturoch/ex_uc)

Converts values between units.

## Installation

From [Hex](https://hexdocs.pm/ex_uc), the package can be installed as:

  1. Add `ex_uc` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:ex_uc, "~> 1.1"}]
end
```

### Requirements

This package requires _Elixir **1.5+**_

## Usage

The quickest way is the function `convert`:
```elixir
iex>ExUc.convert("5 pounds", "oz")
"80.00 oz"
```
This is just a shortcut for the 3-steps pipeline:
```elixir
import ExUc

new_val = from("5 pounds")  # %ExUc.Value{unit: :lb, value: 5, kind: :mass}
|> to(:oz)                  # %ExUc.Value{unit: :oz, value: 80, kind: :mass}
|> as_string                # "80.00 oz"
```

The same unit can be identified by several aliases:
```elixir
convert("5 km", "miles") # "3.11 miles"
convert("5 kms", "mi") # "3.11 mi"
convert("5 kilometers", "mile") # "3.11 mile"
convert("5km", "mile") # "3.11 mile"
```

### Errors

Only two errors are returned when found, both as self descriptive **strings**:

  - `"undefined origin"`: Unit for the original value can't be parsed or found in any defined kind.
  - `"undetermined conversion"`: Conversion between the given units can't be determined.


## Configuration

Configurable variables are:

  - `precision` How many decimals will have the result when is converted into **string**
  - `allow_exact_results` When `true`, truncates decimal zeros in exact results.
  - `units_modules` Names of kinds of units used. Defaults to the included modules.

Could be set as:
```elixir
config :ex_uc, precision: 2
config :ex_uc, allow_exact_results: false
config :ex_uc, units_modules: ~w(length mass)
```

## Included Units

Included are some of the most frequent units grouped by kinds:

  - Length: (`m`, `km`, `cm`, `mm`, `ft`, `in`, `yd`, `mi`, `ft_in`).
  - Mass: (`g`, `kg`, `mg`, `lb`, `oz`, `lb_oz`).
  - Time: (`μs`, `ms`, `s`, `min`, `h`, `d`).
  - Temperature: (`C`, `F`, `K`).
  - Speed: (`km/h`, `mph`, `m/s`, `kn`).
  - Pressure: (`Pa`,  `hPa`,  `kPa`,  `bar`,  `at`,  `atm`,  `mmHg`,  `psi`).
  - Memory: (`B`, `KB`, `MB`, `GB`, `TB`, `PB`, `EB`, `ZB`, `YB`, `b`, `Kb`, `Mb`, `Gb`, `Tb`, `Pb`, `Eb`, `Zb`, `Yb`, `KiB`, `MiB`, `GiB`, `TiB`, `PiB`, `EiB`, `ZiB`, `YiB`).

## Extending ExUc

### Overriding Conversions

Default conversions may be overridden just by providing a new value to in a configuration file:

```elixir
config :ex_uc, :mass_conversions, # The kind suffixed with _conversions
  kg_to_lb: 2.20462 # More precise factor required
  # More units within this kind could go here
```

There are three types of conversion:

- **Factor**: A numeric value, like in the previous example, that is gonna be used to multiply the origin value. _Most conversions can use this type_.

- **Formula**: A function where one or more operation will performed to the origin value.
_Example_:
```elixir
config :ex_uc, :_temperature_conversions,
  C_to_F: &(&1 * 1.8 + 32),
```

- **Special**: An atom referencing a function in a module. This function takes the origin value and returns a string. _Right now this is only used for composed units and can not be overridden_.

### Updating Alias for Existent Units

An alias is just another term that can be used to reference an existent unit and therefore all its conversions.

```elixir
config :ex_uc, :length_units, # The kind suffixed with _units
  m: ["meter", "meters", "mètre", "mètres"]
```

The main unit (`m`, in the sample) should be used as the key for the list of aliases, and such list must include every desired alias.

Every _main unit_ and default aliases for included units, are in the [docs](https://hexdocs.pm/ex_uc) in the *Included Units and Aliases* sections.

### Adding New Units to Existent **Kinds**

New units can be added in configuration files by providing aliases for the new unit and a conversion to or from an existent unit of the same **kind**:

```elixir
config :ex_uc, :length_units,
  dm: ~w(decimeter decimeters), # Main unit and aliases

config :ex_uc, :length_conversions,
  m_to_dm: 10, # A conversion from an existent unit
```

### Adding New **Kinds**

New unit types (_kinds_) should be defined using configuration options for `:ex_uc` application. Each unit must have definitions for _units_ and _conversions_ (See some included examples at `config/units` in this repository).

A new kind should have this structure:

```elixir
use Mix.Config

config :ex_uc, :<KIND>_units,
  <UNIT>: ["alias 1", "alias 2", "alias N"], # List with every alias intended to relate to unit identified by UNIT

config :ex_uc, :<KIND>_conversions,
  <UNIT_A>_to_<UNIT_B>: 0.001,      # Multiplication factor
  <UNIT_C>_to_<UNIT_D>: &(&1 + 5)   # Conversion formula.
  <UNIT_X>_to_<UNIT_Y>: :special    # Atom referencing a special method.  
```

This new kind will be included automatically without the need to specify it in `:units_modules`.

### Better Unit Conversions

**PRs** or **Issues** with bugs, new units or more accurate default conversions are welcome.

## Documentation

Detailed documentation can be found at [hex docs](https://hexdocs.pm/ex_uc).

## Note

This project was inspired by the awesome [Ruby gem](https://github.com/olbrich/ruby-units) by _Kevin C. Olbrich, Ph.D._

## License

[MIT](https://github.com/carturoch/ex_uc/blob/master/License.md)
