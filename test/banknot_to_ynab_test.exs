defmodule BanknotToYnabTest do
  use ExUnit.Case

  describe "Colombia banks" do
    @davivienda """
    Apreciado(a) X:

    Le  informamos que se ha registrado el siguiente movimiento de su Tarjeta Crédito terminada en ****2020:

    Fecha: 2018/11/23
    Hora: 15:33:30
    Valor Transacción: 18,000
    Clase de Movimiento: Compra
    Respuesta: Aprobado(a)
    Lugar de Transacción: CAFE SAN ALBERTO MUSEO

    BANCO DAVIVIENDA
    AVISO LEGAL : Este mensaje es confidencial, puede contener
    información privilegiada y no puede ser usado ni divulgado por
    personas distintas de su destinatario. Si obtiene esta transmisión
    por error, por favor destruya su contenido y avise a su remitente.
    esta prohibida su retención, grabación, utilización, aprovechamientop
    o divulgación con cualquier propósito. Este mensaje ha sido sometido
    a programas antivirus. No obstante, el BANCO DAVIVIENDA S.A. y sus FILIALES   no
    asumen ninguna responsabilidad por eventuales daños generados por
    el recibo y el uso de este material, siendo responsabilidad del destinatario
    verificar con sus propios medios la existencia de virus u otros
    defectos. El presente correo electrónico solo refleja la opinión de
    su Remitente y no representa necesariamente la opinión oficial del
    BANCO DAVIVIENDA S.A. y sus FILIALES  o de sus Directivos
    """

    test "it recognizes davivienda colombia" do
      assert {:ok,
              %{
                amount: -18000,
                approved: true,
                cleared: "cleared",
                date: "2018-11-23",
                import_id: "816E67F5B544F6B490687F939BA6B98D",
                payee_name: "CAFE SAN ALBERTO MUSEO"
              }} = BanknotToYnab.parse(@davivienda)
    end
  end

  describe "Panama banks" do
    @davivienda """
    Estimado(a) Sr. (a):
    John Doe

    Se registró COMPRAS con tarjeta débito MASTERCARD terminación 9029, en SPORTS BASEMENT., por $ 103.21.
    En caso de no reconocer esta transacción, agradecemos contactarnos a
    nuestro Call Center al (507) 366-6565, en horarios de atención
    de lunes a viernes de 7:30 am a 6:00 pm, y los sábados de 8:00 am a 1:00
    pm.
    Para reportes fuera de este horario desde Panamá, favor llamar al 216-9214
    o 800-6565, desde Colombia al 01-800-0118110,

    o (507) 216-9214 desde cualquier parte del mundo.

    Cordialmente,
    Banco Davivienda Panamá S.A.
    """

    test "it recognizes davivienda panama" do
      assert {:ok,
              %{
                amount: -103.21,
                approved: true,
                cleared: "cleared",
                date: "2019-05-31",
                import_id: "E061BAABE4A99A544342ADB999C74EA5",
                payee_name: "SPORTS BASEMENT"
              }} = BanknotToYnab.parse(@davivienda)
    end
  end

  describe "unknown payload" do
    test "returns :error" do
      assert {:error, :unknown_provider} = BanknotToYnab.parse("break it")
    end
  end
end
