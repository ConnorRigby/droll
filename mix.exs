defmodule Droll.MixProject do
  use Mix.Project

  @version "1.0.0"
  @source_url "https://github.com/connorrigy/droll"

  def project do
    [
      app: :droll,
      version: @version,
      elixir: "~> 1.0",
      description: description(),
      package: package(),
      source_url: @source_url,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs(),
      preferred_cli_env: %{
        docs: :docs,
        "hex.publish": :docs,
        "hex.build": :docs
      }
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp description do
    "Simple implementation of standard dice notation"
  end

  defp package do
    %{
      files: [
        "lib",
        "src/*.xrl",
        "src/*.yrl",
        "test",
        "mix.exs",
        "README.md",
        "LICENSE"
      ],
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => @source_url}
    }
  end

  defp deps do
    [
      {:ex_doc, "~> 0.25.0", only: :docs},
      {:dialyxir, "~> 1.1.0", only: [:dev, :test], runtime: false}
    ]
  end

  defp docs do
    [
      extras: ["README.md"],
      main: "readme",
      source_ref: "v#{@version}",
      source_url: @source_url
    ]
  end
end
