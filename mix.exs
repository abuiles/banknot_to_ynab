defmodule BanknotToYnab.MixProject do
  use Mix.Project

  @project_url "https://github.com/abuiles/banknot_to_ynab"
  @version "0.1.0"

  def project do
    [
      app: :banknot_to_ynab,
      version: @version,
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:crypto, :logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    []
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
