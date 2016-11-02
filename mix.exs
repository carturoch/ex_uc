defmodule ExUc.Mixfile do
  use Mix.Project

  @version "1.0.2"

  def project do
    [app: :ex_uc,
     version: "#{@version}",
     description: description(),
     source_url: "https://github.com/carturoch/ex_uc",
     package: package(),
     elixir: "~> 1.3",
     docs: [
       main: "ExUc", source_ref: "v#{@version}",
       source_url: "https://github.com/carturoch/ex_uc",
       readme: true
     ],
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:ex_doc, "~> 0.12", only: :dev}]
  end

  defp package do
    [
      name: :ex_uc,
      files: ["lib", "mix.exs", "README.md", "License.md"],
      maintainers: ["Carlos Cuellar"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/carturoch/ex_uc"}
    ]
  end

  def description do
    """
    Utility to convert values between different units of the same kind.
    Extremely easy to extend and to use.
    """
  end
end
