defmodule BanknotToYnab do
  @moduledoc """
  Documentation for BanknotToYnab.
  """

  @doc ~S"""
  Parse notifications from any of the supported banks to a YNAB
  transaction.

  ## Examples
  iex> notification = "Apreciado(a) X:\n\nLe  informamos que se ha registrado el siguiente movimiento de su Tarjeta Crédito terminada en ****2020:\n\nFecha: 2018/11/23\nHora: 15:33:30\nValor Transacción: 18,000\nClase de Movimiento: Compra\nRespuesta: Aprobado(a)\nLugar de Transacción: CAFE SAN ALBERTO MUSE0\n\nBANCO DAVIVIENDA\nAVISO LEGAL : Este mensaje es confidencial, puede contener\ninformación privilegiada y no puede ser usado ni divulgado por\npersonas distintas de su destinatario. Si obtiene esta transmisión\npor error, por favor destruya su contenido y avise a su remitente.\nesta prohibida su retención, grabación, utilización, aprovechamiento\no divulgación con cualquier propósito. Este mensaje ha sido sometido\na programas antivirus. No obstante, el BANCO DAVIVIENDA S.A. y sus FILIALES   no\nasumen ninguna responsabilidad por eventuales daños generados por\nel recibo y el uso de este material, siendo responsabilidad del destinatario\nverificar con sus propios medios la existencia de virus u otros\ndefectos. El presente correo electrónico solo refleja la opinión de\nsu Remitente y no representa necesariamente la opinión oficial del\nBANCO DAVIVIENDA S.A. y sus FILIALES  o de sus Directivos\n"
  iex> BanknotToYnab.parse(notification)
  %{
    amount: "18,000",
    approved: true,
    cleared: "cleared",
    date: "2018/11/23",
    import_id: "1234",
    payee_name: "CAFE SAN ALBERTO MUSEO"
  }
  """
  def parse(notification) do
    %{}
  end
end
