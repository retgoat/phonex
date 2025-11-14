defmodule Phonex do
  @default_mask "CVCCV-CVCVV-DDDDD"
  @consts "bcdgklmnprstz"
  @vowels "aeiou"
  @blocklist ~w[]

  @moduledoc ~S"""
  Generates a phonetically pronounced token with givn mask (or default mask)

  Mask configuration:

  - `C` — consoinant character
  - `V` — vowel character
  - `D` — digit
  - `other` — any other symbol

  Mask should be ASCII symbols
  """

  @doc """
  Generates a token with default mask `"CVCCV-CVCVV-DDDDD"`

  ## Examples

      iex> Phonex.token()
      {:ok, "kobsa-mitau-52876"}

      iex(4)> Phonex.token(nil)
      {:error, "Mask cannot be nil. Possible format CVCCV-CVCVV-DDDDD"}

  """
  def token do
    String.graphemes(@default_mask)
    |> token_by_mask()
    |> check_token()
  end

  @doc ~S"""
  Generates a token with default mask `"CVCCV-CVCVV-DDDDD"`

  ## Examples

      iex> Phonex.token!()
      {:ok, "kobsa-mitau-52876"}

  """
  def token! do
    String.graphemes(@default_mask)
    |> token_by_mask()
    |> check_token!()
  end

  @doc """
  Generates a token with given mask

  ## Examples
      iex> Phonex.token("CVCCV-CVCVV-DDDDD")
      {:ok, "kobsa-mitau-52876"}

  """
  def token(mask) do
    check_mask(mask)
    |> graphemes()
    |> token_by_mask()
    |> check_token()
  end

  @doc ~S"""
  Generates a token with given mask

  ## Examples

      iex> Phonex.token!("CVCCV-CVCVV-DDDDD")
      {:ok, "kobsa-mitau-52876"}

      iex(4)> Phonex.token!(nil)
      ** (ArgumentError) Mask cannot be nil. Possible format CVCCV-CVCVV-DDDDD
          (phonex 0.1.0) lib/phonex.ex:92: Phonex.check_mask!/1
          (phonex 0.1.0) lib/phonex.ex:76: Phonex.token!/1
          iex:4: (file)

  """
  def token!(mask) do
    check_mask!(mask)
    |> graphemes()
    |> token_by_mask()
    |> check_token!()
  end

  defp check_mask(mask) do
    cond do
      is_nil(mask) == true -> {:error, "Mask cannot be nil. Possible format #{@default_mask}"}
      String.match?(mask, ~r/\A[\x00-\x7F]+\z/) == false -> {:error, "Mask must be an ASCII string. Possible format #{@default_mask}"}
      true -> mask
    end
  end

  defp check_mask!(mask) do
    cond do
      is_nil(mask) == true -> raise ArgumentError, "Mask cannot be nil. Possible format #{@default_mask}"
      String.match?(mask, ~r/\A[\x00-\x7F]+\z/) == false -> raise ArgumentError, "Mask must be an ASCII string. Possible format #{@default_mask}"
      true -> mask
    end
  end

  def graphemes({:error, _} = e), do: e
  def graphemes(mask), do: String.graphemes(mask)

  defp token_by_mask({:error, _} = e), do: e

  defp token_by_mask(mask_list) do
    mask_list
    |> Enum.map(fn
      "C" -> Enum.random(String.graphemes(@consts))
      "D" -> Enum.random(String.graphemes("0123456789"))
      "V" -> Enum.random(String.graphemes(@vowels))
      other -> other
    end)
    |> Enum.join()
  end

  defp check_token({:error, _} = e), do: e

  defp check_token(token) do
    String.split(token, "-")
    |> Enum.any?(fn part -> Enum.member?(@blocklist, String.downcase(part)) end)
    |> case do
      true -> {:error, :blocked}
      false -> {:ok, token}
    end
  end

  defp check_token!(token) do
    String.split(token, "-")
    |> Enum.any?(fn part -> Enum.member?(@blocklist, String.downcase(part)) end)
    |> case do
      true -> raise "Generated token is blocked"
      false -> token
    end
  end
end
