defmodule BanknotToYnabTest do
  use ExUnit.Case
  doctest BanknotToYnab

  describe "unknown payload" do
    test "returns :error" do
      assert {:error, :unknown_provider} = BanknotToYnab.parse("break it")
    end
  end
end
