# ExUc - Elixir Unit Converter

Converts values between units.

## Installation

From [Hex](https://hexdocs.pm/ex_uc), the package can be installed as:

  1. Add `ex_uc` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:ex_uc, "~> 0.3"}]
    end
    ```

  2. Ensure `ex_uc` is started before your application:

    ```elixir
    def application do
      [applications: [:ex_uc]]
    end
    ```

### Requirements

This package requires _Elixir **1.3+**_

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

### Errors

Only two errors are returned when found, both as self descriptive **strings**:

  - `"undefined origin"`: Unit for the original value can't be parsed or found in the configuration.
  - `"undetermined conversion"`: Conversion between the given units can't be determined.


## Configuration

The only configurable variable is `precision`, by default `2`. It determines how many decimals will have the result when is converted into **string**.

### Adding more units

Unit sets (_kinds_) are really easy to extend. You don't need to add a conversion to every other existent unit in the _kind_ (though, of course you can). **ExUc** will find the shortest path in a _kind_ of units as a graph, using defined conversions.

Every unit supported by **ExUc** is defined in a config file in _config/units/<KIND>.ex_, e.g. `config/units/temperature.ex`.

Each of these files requires to have the following structure:
```elixir
use Mix.Config

config :ex_uc, :<KIND>_units,
  <UNIT>: ["alias 1", "alias 2", "alias N"], # List with every alias intended to relate to unit identified by UNIT

config :ex_uc, :<KIND>_conversions,
  <UNIT_A>_to_<UNIT_B>: 0.001,      # Multiplication factor
  <UNIT_C>_to_<UNIT_D>: &(&1 + 5)   # Conversion formula.
  <UNIT_X>_to_<UNIT_Y>: :special    # Atom referencing a special method.  
```

Which have two sections:

  - **Aliases**
    - Key as `<KIND>_units` where kind identifies the type of measurement, e.g: _length_, _temperature_, _pressure_, etc.
    - Each unit to support in the `kind` as a pair `unit:aliases` where **unit** is the most used unit and **aliases** is a list of strings (or a single one), one for each supported representation of the unit.
  - **Conversions**
    - Key as `<KIND_conversions>` using the same **kind** from the **alias** section.
    - Each conversion as a pair `key:conversion`, where **key** is an atom with the pattern `<UNIT_FROM>_to_<UNIT_TO>`, and **conversion** could be a _number_, or a _closure_, or an _atom_. Numeric conversions describe multiplication factors, and can be also used as `<B>_to_<A>: 1 / conversion` for a `<A>_to_<B>: factor` without explicit definition. When a factor is not enough, a _closure_ can be used as a simple formula. For special cases use an _atom_ to describe a function in module `Special`.

### More Units

**PRs** or **Issues** with new units or more accurate conversions are welcome.

## Documentation

Detailed documentation can be found at [hex docs](https://hexdocs.pm/ex_uc).

## Note

This project was inspired by the awesome [Ruby gem](https://github.com/olbrich/ruby-units) by _Kevin C. Olbrich, Ph.D._

## License

[MIT](https://github.com/carturoch/ex_uc/blob/master/License.md)
