defmodule Misc.Random.Mixfile do
  use Mix.Project

  def project do
    [app: :misc_random,
     version: "0.2.6",
     elixir: "> 1.0.0",
     description: description,
     package: package,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    []
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    []
  end

  defp description do
    """
    This is a very thin wrapper around erlang's random:uniform method. It allows
    you to create random strings or numbers.
    """
  end
  
  defp package do
    [# These are the default files included in the package
     files: ["lib", "mix.exs", "README*", "LICENSE*"],
     maintainers: ["Martin Gutsch"],
     licenses: ["MIT"],
     links: %{
        "GitHub" => "https://github.com/gutschilla/elixir-helper-random"
        # "Docs" => "http://ericmj.github.io/postgrex/"
      }
     ]
  end

end
