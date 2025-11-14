# Phonex

Generates a phonetically pronounced token with givn mask (or default mask)

Mask configuration:

- `C` — consoinant character
- `V` — vowel character
- `D` — digit
- `other` — any other symbol

Mask should be ASCII symbols

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `phonex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:phonex, "~> 0.1.0"}
  ]
end
```

### Configuration

Check [config](config/config.exs) for possible options.

### Example

```elixir

iex> Phonex.token
{:ok, "kobsa-mitau-52876"}

iex> Phonex.token!
"kobsa-mitau-52876"

# errors

iex> Phonex.token("CVC-😊")
{:error, "Mask must be an ASCII string. Possible format CVCCV-CVCVV-DDDDD"}

iex(108)> Phonex.token!("CVC-😊")
** (ArgumentError) Mask must be an ASCII string. Possible format CVCCV-CVCVV-DDDDD
    (phonex 0.1.0) lib/phonex.ex:90: Phonex.check_mask!/1
    (phonex 0.1.0) lib/phonex.ex:73: Phonex.token!/1
    iex:108: (file)

```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/phonex](https://hexdocs.pm/phonex).
