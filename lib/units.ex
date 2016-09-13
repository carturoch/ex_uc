defmodule ExUc.Units do
  @moduledoc """
  # Units and conversion accessor

  Allow efficient access to units and conversions defined in config.
  """

  # ETS table to store map of aliases by unit.
  @units_table :ex_uc_units_map

  # ETS table to store a map per kind with the conversions graph.
  @graphs_table :ex_uc_units_graphs

  @doc """
  Gets a map with every kind of unit defined in config.

  The result has a very traversable structure as:
  ```
  %{
    kind_of_unit: [
      alias_0: :main,
      alias_N: :main,
    ],
    ...
  }
  ```

  Returns Map
  """
  def map do
    stored_map = cond do
      :ets.info(@units_table) == :undefined ->
        :ets.new(@units_table, [:named_table]) # Init units map table
        :"$end_of_table" # Empty table
      true -> :ets.first(@units_table)
    end
    get_map(stored_map)
  end

  defp get_map(:"$end_of_table") do
    parsed_map = Application.get_all_env(:ex_uc)
    |> Enum.filter(fn {kind, _opts} -> Atom.to_string(kind) |> String.ends_with?("_units") end)
    |> Enum.map(fn {kind, units} ->
      units_map = units
      |> Enum.flat_map(fn {main, aliases} ->
        cond do
          is_list(aliases) -> [{main, main} | for(alias <- aliases, do: {String.to_atom(alias), main})]
          is_binary(aliases) -> [{main, main}, {String.to_atom(aliases), main}]
          true -> [{main, main}, {aliases, main}]
        end
      end)
      {kind, units_map}
    end)
    |> Enum.into(%{})

    :ets.insert(@units_table, {parsed_map})
    parsed_map
  end
  defp get_map(parsed_map), do: parsed_map

  # Creates a ETS table to store a graph reference per kind
  def init_graphs do
    :ets.new(@graphs_table, [:named_table])

    graphs_map = Application.get_all_env(:ex_uc)
    |> Enum.filter(fn {kind, _opts} -> Atom.to_string(kind) |> String.ends_with?("_conversions") end)
    |> Enum.map(fn {kind_conversion, conversions} ->
      kind = kind_conversion |> Atom.to_string |> String.replace_suffix("_conversions", "") |> String.to_atom
      {^kind, g, _} = make_graph(kind, conversions)
      {kind, g}
    end)
    |> Enum.into(%{})

    :ets.insert(@graphs_table, {graphs_map})
    graphs_map
  end

  # Creates a graph representing all conversions in a kind
  # Returns a tuple as {<KIND atom>, <GRAPH tuple>, <NO_VERTICES integer>}
  defp make_graph(kind, conversions) do
    g = :digraph.new()
    conversions
    |> Enum.map(fn {edge, val} ->
      {v0, v1} = edge
      |> Atom.to_string
      |> String.split("_to_")
      |> Enum.map(&String.to_atom/1)
      |> List.to_tuple

      :digraph.add_vertex(g, v0)
      :digraph.add_vertex(g, v1)
      :digraph.add_edge(g, v0, v1)
      
      # Only when the conversion is a factor the reverse edge is added.
      if is_number(val), do: :digraph.add_edge(g, v1, v0)
    end)
    {kind, g, :digraph.no_vertices(g)}
  end

  @doc """
  Gets a list of units as path for conversion.

  Returns List of units.

  ## Parameters

    - kind: Atom as the kind of unit.
    - from: Atom as initial unit.
    - to: Atom as target unit.

  ## Examples
  ```

  iex>ExUc.Units.get_path_in(:length, :km, :ft)
  [:km, :m, :ft]

  iex>ExUc.Units.get_path_in(:length, :km, :zzx)
  false

  ```
  """
  def get_path_in(kind, from, to) do
    stored = cond do
      :ets.info(@graphs_table) == :undefined ->
        init_graphs()
      true -> :ets.first(@graphs_table)
    end
    g = stored |> Map.get(kind)
    :digraph.get_short_path(g, from, to)
  end

  @doc """
  Gets the kind of unit for ther given unit.

  ## Parameters

    - unit: Atom representing the unit to find the kind.

  ## Examples
  ```

  iex>ExUc.Units.get_kind(:kg)
  "mass"

  iex>ExUc.Units.get_kind(:meter)
  "length"

  ```
  """
  def get_kind(unit) do
    kind_kw = map()
    |> Enum.find(fn {_kind, units} -> units |> Keyword.has_key?(unit) end)

    case kind_kw do
      {kind_name, _units} -> kind_name
        |> Atom.to_string
        |> String.replace_suffix("_units", "")

      _ -> nil
    end
  end

  @doc """
  Gets the unit among its aliases that can be used as a key in conversions

  ## Parameters

    - alias: Atom with a unit aliases.
    - kind: Atom or String for the kind where the alias is.

  ## Examples
  ```

  iex>ExUc.Units.get_key_alias(:meter, "length")
  :m

  iex>ExUc.Units.get_key_alias(:pounds, :mass)
  :lb

  iex>ExUc.Units.get_key_alias(:r4R3, :mass)
  nil

  ```
  """
  def get_key_alias(alias, kind) do
    kind_token = "#{kind}_units" |> String.to_atom
    with aliases <- Map.get(map(), kind_token),
      main <- Keyword.get_values(aliases, alias) |> List.first,
    do: main
  end

  @doc """
  Gets the conversion factor for the units

  If can find inverse relation when the conversion is a factor.

  Returns Atom.t, Integer.t, Float.t

  ## Parameters

    - from: Atom representing the unit to convert from
    - to: Atom representing the unit to convert to

  ## Examples
  ```

  iex>ExUc.Units.get_conversion(:g, :mg)
  {:ok, 1000}

  iex>ExUc.Units.get_conversion(:g, :zz)
  {:error, "undetermined conversion"}

  # This relation has not been defined but
  # the inverse is based on a factor, so is valid.
  iex>ExUc.Units.get_conversion(:km, :m)
  {:ok, 1.0e3}

  ```
  """
  def get_conversion(from_alias, to_alias) do
    kind = get_kind(from_alias)
    conversion_key = "#{kind}_conversions" |> String.to_atom

    {from, to} = {get_key_alias(from_alias, kind), get_key_alias(to_alias, kind)}
    conversions = Application.get_env(:ex_uc, conversion_key) |> Enum.into(%{})
    regular_key = "#{from}_to_#{to}" |> String.to_atom
    inverted_key = "#{to}_to_#{from}" |> String.to_atom

    cond do
      Map.has_key?(conversions, regular_key) ->
        {:ok, Map.get(conversions, regular_key)}
      Map.has_key?(conversions, inverted_key) && is_number(Map.get(conversions, inverted_key)) ->
        {:ok, 1 / Map.get(conversions, inverted_key)}
      true -> {:error, "undetermined conversion"}
    end
  end
end
