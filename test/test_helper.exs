Dynamo.under_test(Chatex.Dynamo)
Dynamo.Loader.enable
ExUnit.start

defmodule Chatex.TestCase do
  use ExUnit.CaseTemplate

  # Enable code reloading on test cases
  setup do
    Dynamo.Loader.enable
    :ok
  end
end
