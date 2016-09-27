defmodule ExUc.Kind do
  use Behaviour

  @moduledoc """
  Behaviour for a set of units of the same type with conversion
  among them.
  """

  @doc """
  Gets a keyword where every item is conformed by the unit identifier
  and a list of aliases
  """
  defcallback units() :: Keyword.t

  @doc """
  Gets a map  where each conversion is a composed by the pair `key:conversion`,
  where **key** is an atom with the pattern `<UNIT_FROM>_to_<UNIT_TO>`,
  and **conversion** could be a _number_, or a _closure_, or an _atom_.

  Numeric conversions describe multiplication factors,
  and can be also used as `<B>_to_<A>: 1 / conversion` for a `<A>_to_<B>: factor`
  without explicit definition.

  When a factor is not enough, a _closure_ can be used as a simple formula.

  For special cases use an _atom_ to describe a function in module `Special`.
  """
  defcallback conversions() :: Keyword.t
end