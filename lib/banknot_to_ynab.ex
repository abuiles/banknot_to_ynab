defmodule BanknotToYnab do
  @moduledoc """
  Defines the main functions to parse notifications.
  """

  @doc """
  Parse notifications from any of the supported banks to a YNAB
  transaction.
  """
  def parse(notification) do
    try do
      date_regex = ~r/Fecha: (?<date>[\d|\/]+)/
      amount_regex = ~r/Valor Transacción: (?<amount>[\d|,]+)/
      payee_regex = ~r/Lugar de Transacción: (?<payee_name>.+)\n/
      import_id = :crypto.hash(:md5, notification) |> Base.encode16()

      %{"date" => date} = Regex.named_captures(date_regex, notification)
      %{"amount" => amount} = Regex.named_captures(amount_regex, notification)
      %{"payee_name" => payee_name} = Regex.named_captures(payee_regex, notification)

      {amount, _} = amount |> String.replace(",", "") |> Integer.parse()

      {:ok,
       %{
         amount: -amount,
         approved: true,
         cleared: "cleared",
         date: date |> String.replace("/", "-"),
         import_id: import_id,
         payee_name: payee_name
       }}
    rescue
      e in MatchError -> {:error, :unknown_provider}
    end
  end
end
