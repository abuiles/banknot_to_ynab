defmodule BanknotToYnab do
  @moduledoc """
  Defines the main functions to parse notifications.
  """

  @doc """
  Parse notifications from any of the supported banks to a YNAB
  transaction.
  """
  def parse(notification) do
    with {provider, notification} when provider != :unknown_provider <-
           identify_notification(notification) do
      %{
        date: date,
        amount: amount,
        payee_name: payee_name
      } = extract_data({provider, notification})

      {:ok,
       %{
         amount: -amount,
         approved: true,
         cleared: "cleared",
         date: date |> String.replace("/", "-"),
         import_id: :crypto.hash(:md5, notification) |> Base.encode16(),
         payee_name: payee_name
       }}
    else
      _ -> {:error, :unknown_provider}
    end
  end

  def extract_data({:unknown_provider, notification}) do
    {:unknown_provider, notification}
  end

  def extract_data({:davivienda_co, notification}) do
    date_regex = ~r/Fecha: (?<date>[\d|\/]+)/
    amount_regex = ~r/Valor Transacción: (?<amount>[\d|,]+)/
    payee_regex = ~r/Lugar de Transacción: (?<payee_name>.+)\n/

    %{"date" => date} = Regex.named_captures(date_regex, notification)
    %{"amount" => amount} = Regex.named_captures(amount_regex, notification)
    %{"payee_name" => payee_name} = Regex.named_captures(payee_regex, notification)

    {amount, _} = amount |> String.replace(",", "") |> Integer.parse()

    %{
      date: date,
      amount: amount,
      payee_name: payee_name
    }
  end

  def extract_data({:davivienda_pa, notification}) do
    amount_regex = ~r/por \$ (?<amount>[\d|\.]+)\./
    payee_regex = ~r/, en\n?(?<payee_name>.+)., por/s

    date = Timex.format!(Timex.now(), "%Y-%m-%d", :strftime)

    require IEx; IEx.pry
    %{"amount" => amount} = Regex.named_captures(amount_regex, notification)
    %{"payee_name" => payee_name} = Regex.named_captures(payee_regex, notification)

    payee_name = String.replace(payee_name, "\n", " ")

    {amount, _} = Float.parse(amount)

    %{
      date: date,
      amount: amount,
      payee_name: payee_name
    }
  end

  defp identify_notification(notification) do
    cond do
      Regex.match?(~r/BANCO DAVIVIENDA S\.A/, notification) ->
        {:davivienda_co, notification}

      Regex.match?(~r/Banco Davivienda Panamá S\.A\./, notification) ->
        {:davivienda_pa, notification}

      true ->
        {:unknown_provider, notification}
    end
  end

  defp format_date(date, strftime) do
    {:ok, timex} = Timex.parse(date, strftime, :strftime)
    Timex.format!(timex, "%Y-%m-%d", :strftime)
  end
end
