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
    Estimado Cliente


    Se ha realizado un cargo a su tarjeta MasterCard Davivienda 9020, por
    valor de 103.21 en SPORTS BASEMENT el día 04/02/2019

    De no reconocer la transacción, favor llamar al 800 6565 o 216 9214 en
    Panamá, 018000 118 110 en Colombia o (507) 216 9214 en el resto del
    mundo.


    Cordialmente

    Banco Davivienda Panamá S.A.
    """

    test "it recognizes davivienda panama" do
      assert {:ok,
              %{
                amount: -103.21,
                approved: true,
                cleared: "cleared",
                date: "2019-02-04",
                import_id: "ACFBBCE45FBD20BB26905DDE53393BD5",
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
