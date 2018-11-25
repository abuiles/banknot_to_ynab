# Bank Notifications to YNAB.
[![CircleCI](https://circleci.com/gh/abuiles/banknot_to_ynab.svg?style=svg)](https://circleci.com/gh/abuiles/banknot_to_ynab)

Parse notifications from banks outside of America to [YNAB](https://www.youneedabudget.com/) transactions.

Supported banks:

| Bank        | Supported |
|-------------|-----------|
| Davivienda Colombia  | ✅|
| Bancolombia |❌ |

## Installation

The package can be installed by adding `banknot_to_ynab` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:banknot_to_ynab, "~> 0.1.0"}
  ]
end
```
