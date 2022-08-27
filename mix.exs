defmodule PrimerLive.MixProject do
  use Mix.Project

  def project do
    [
      app: :primer_live,
      name: "PrimerLive",
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:phoenix_live_view, "~> 0.17.11"},
      {:phoenix_html, "~> 3.0"},
      {:typed_ecto_schema, "~> 0.4.1"},
      {:ecto_sql, "~> 3.6"},
      {:jason, "~> 1.0"},
      {:ex_doc, "~> 0.28.5", only: :dev},
      {:earmark, "~> 1.4", only: :dev},
      {:dialyxir, "~> 1.2", only: :dev, runtime: false}
    ]
  end

  defp docs do
    [
      main: "PrimerLive",
      groups_for_modules: [
        Components: ~r/PrimerLive.Component/
      ],
      nest_modules_by_prefix: [
        PrimerLive.Components,
        PrimerLive.Components.Pagination
      ],
      extras: [
        "LICENSE.md"
      ]
    ]
  end
end