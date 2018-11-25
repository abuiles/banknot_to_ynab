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

## Usage

For now this library supports notifications from [Davivienda Colombia](http://www.davivienda.com/). You can convert the notification to a map representing a YNAB transaction by doing the following:

``` elixir
iex > notification = """
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
esta prohibida su retención, grabación, utilización, aprovechamiento
o divulgación con cualquier propósito. Este mensaje ha sido sometido
a programas antivirus. No obstante, el BANCO DAVIVIENDA S.A. y sus FILIALES   no
asumen ninguna responsabilidad por eventuales daños generados por
el recibo y el uso de este material, siendo responsabilidad del destinatario
verificar con sus propios medios la existencia de virus u otros
defectos. El presente correo electrónico solo refleja la opinión de
su Remitente y no representa necesariamente la opinión oficial del
BANCO DAVIVIENDA S.A. y sus FILIALES  o de sus Directivos
"""

iex> BanknotToYnab.parse(notification)
  %{
    amount: "18,000",
    approved: true,
    cleared: "cleared",
    date: "2018/11/23",
    import_id: "2500C49ECA637B543FFFA1AEE5A3C133",
    payee_name: "CAFE SAN ALBERTO MUSEO"
  }
```
