defmodule Chatex.Mixfile do
  use Mix.Project

  def project do
    [ app: :chatex,
      version: "0.0.1",
      dynamos: [Chatex.Dynamo],
      compilers: [:elixir, :dynamo, :app],
      env: [prod: [compile_path: "ebin"]],
      compile_path: "tmp/#{Mix.env}/chatex/ebin",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [ applications: [:cowboy, :dynamo],
      mod: { Chatex, [] } ]
  end

  defp deps do
    [ { :cowboy, github: "extend/cowboy" },
      { :dynamo, "0.1.0-dev", github: "elixir-lang/dynamo" },
      { :erlsom, github: "willemdj/erlsom" } ]
  end
end
