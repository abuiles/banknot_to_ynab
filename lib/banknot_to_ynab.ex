defmodule BanknotToYnab do
  @moduledoc """
  Defines the main functions to parse notifications.
  """

  @doc """
  Parse notifications from any of the supported banks to a YNAB
  transaction.

  ## Examples

      iex> notification = \"""
      ...>Apreciado(a) X:
      ...>
      ...>Le  informamos que se ha registrado el siguiente movimiento de su Tarjeta Crédito terminada en ****2020:
      ...>
      ...>Fecha: 2018/11/23
      ...>Hora: 15:33:30
      ...>Valor Transacción: 18,000
      ...>Clase de Movimiento: Compra
      ...>Respuesta: Aprobado(a)
      ...>Lugar de Transacción: CAFE SAN ALBERTO MUSEO
      ...>
      ...>BANCO DAVIVIENDA
      ...>AVISO LEGAL : Este mensaje es confidencial, puede contener
      ...>información privilegiada y no puede ser usado ni divulgado por
      ...>personas distintas de su destinatario. Si obtiene esta transmisión
      ...>por error, por favor destruya su contenido y avise a su remitente.
      ...>esta prohibida su retención, grabación, utilización, aprovechamiento
      ...>o divulgación con cualquier propósito. Este mensaje ha sido sometido
      ...>a programas antivirus. No obstante, el BANCO DAVIVIENDA S.A. y sus FILIALES   no
      ...>asumen ninguna responsabilidad por eventuales daños generados por
      ...>el recibo y el uso de este material, siendo responsabilidad del destinatario
      ...>verificar con sus propios medios la existencia de virus u otros
      ...>defectos. El presente correo electrónico solo refleja la opinión de
      ...>su Remitente y no representa necesariamente la opinión oficial del
      ...>BANCO DAVIVIENDA S.A. y sus FILIALES  o de sus Directivos
      ...>\"""
      iex> BanknotToYnab.parse(notification)
      %{
        amount: -18000,
        approved: true,
        cleared: "cleared",
        date: "2018-11-23",
        import_id: "2500C49ECA637B543FFFA1AEE5A3C133",
        payee_name: "CAFE SAN ALBERTO MUSEO"
      }
  """
  def parse(notification) do
    date_regex = ~r/Fecha: (?<date>[\d|\/]+)/
    amount_regex = ~r/Valor Transacción: (?<amount>[\d|,]+)/
    payee_regex = ~r/Lugar de Transacción: (?<payee_name>.+)\n/
    import_id = :crypto.hash(:md5, notification) |> Base.encode16()

    %{"date" => date} = Regex.named_captures(date_regex, notification)
    %{"amount" => amount} = Regex.named_captures(amount_regex, notification)
    %{"payee_name" => payee_name} = Regex.named_captures(payee_regex, notification)

    {amount, _} = amount |> String.replace(",", "") |> Integer.parse()

    %{
      amount: -amount,
      approved: true,
      cleared: "cleared",
      date: date |> String.replace("/", "-"),
      import_id: import_id,
      payee_name: payee_name
    }
  end
end
