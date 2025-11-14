defmodule Phonex.MixProject do
  use Mix.Project

  def project do
    [
      app: :phonex,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      description: description(),
      source_url: "https://github.com/retgoat/phonex",
      name: "Phonex",
      homepage_url: "https://github.com/retgoat/phonex"
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    []
  end

  defp description() do
    "Generates a phonetically pronounced token with given mask or default mask \"CVCCV-CVCVV-DDDDD\""
  end

  defp package() do
    [
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/retgoat/phonex"}
    ]
  end
end
