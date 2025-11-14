defmodule PhonexTest do
  use ExUnit.Case

  describe "Phoenix.token" do
    test "generates a token with the default mask" do
      {:ok, token} = Phonex.token()
      assert is_binary(token)
      assert String.length(token) == String.length("CVCCV-CVCVV-DDDDD")
    end

    test "generates a token with a custom mask" do
      mask = "CVD-CV"
      {:ok, token} = Phonex.token(mask)
      assert is_binary(token)
      assert String.length(token) == String.length(mask)
    end

    test "returns an error for nil mask" do
      assert {:error, _} = Phonex.token(nil)
    end

    test "returns an error for non-ASCII mask" do
      assert {:error, _} = Phonex.token("CVC-😊")
    end
  end

  describe "Phoenix.token!" do
    test "generates a token with the default mask" do
      token = Phonex.token!()
      assert is_binary(token)
      assert String.length(token) == String.length("CVCCV-CVCVV-DDDDD")
    end

    test "generates a token with a custom mask" do
      mask = "CVD-CV"
      token = Phonex.token!(mask)
      assert is_binary(token)
      assert String.length(token) == String.length(mask)
    end

    test "raises ArgumentError for nil mask" do
      assert_raise ArgumentError, fn -> Phonex.token!(nil) end
    end

    test "raises ArgumentError for non-ASCII mask" do
      assert_raise ArgumentError, fn -> Phonex.token!("CVC-😊") end
    end
  end
end
