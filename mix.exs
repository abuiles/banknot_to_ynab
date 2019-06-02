defmodule BanknotToYnab.MixProject do
  use Mix.Project

  @project_url "https://github.com/abuiles/banknot_to_ynab"
  @version "0.9.0"

  def project do
    [
      app: :banknot_to_ynab,
      version: @version,
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      docs: [
        main: "readme",
        extras: ["README.md"]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      applications: [:timex],
      extra_applications: [:crypto, :logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.19", only: :dev, runtime: false},
      {:timex, "~> 3.1"}
    ]
  end

  defp description() do
    "Parse notifications from banks outside of America to YNAB transactions."
  end

  defp package() do
    [
      maintainers: ["Adolfo Builes"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => @project_url
      }
    ]
  end
end
