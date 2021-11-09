<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xr="urn:ce.eu:en16931:2017:xoev-de:kosit:standard:xrechnung-1"
  xmlns:xrv="http://www.example.org/XRechnung-Viewer">

  <xsl:output indent="yes" method="html" encoding="UTF-8" />

  <xsl:decimal-format name="decimal" decimal-separator="," grouping-separator="." NaN="" />


    <!-- MAIN HTML -->
  <xsl:template match="/xr:invoice">

    <html lang="de">
      <head>
        <meta charset="UTF-8" />
        <title>XRechnung</title>
        <meta name="viewport" content="width=device-width, user-scalable=yes, initial-scale=1.0" />
        <style>
          <xsl:value-of select="unparsed-text('xrechnung-viewer.css')" />
        </style>
      </head>
      <body>
        <div role="main">
          <form>
            <div class="menue" role="navigation">
              <div role="tablist" class="innen">
                <div role="none">
                  <button role="tab" aria-controls="uebersicht" tabindex="0" aria-selected="true" type="button"
                    class="tab btnAktiv" id="menueUebersicht" onclick="show(this);">
                    <span>Übersicht</span>
                  </button>
                </div>
                <div role="none">
                  <button role="tab" aria-controls="details" tabindex="0" aria-selected="false" type="button"
                    class="tab" id="menueDetails" onclick="show(this);">
                    <span>Details</span>
                  </button>
                </div>
                <div role="none">
                  <button role="tab" aria-controls="zusaetze" tabindex="0" aria-selected="false" type="button"
                    class="tab" id="menueZusaetze" onclick="show(this)">
                    <span>Zusätze</span>
                  </button>
                </div>
                <div role="none">
                  <button role="tab" aria-controls="anlagen" tabindex="0" aria-selected="false" type="button"
                    class="tab" id="menueAnlagen" onclick="show(this)">
                    <span>Anlagen</span>
                  </button>
                </div>
                <div role="none">
                  <button role="tab" aria-controls="laufzettel" tabindex="0" aria-selected="false" type="button"
                    class="tab" id="menueLaufzettel" onclick="show(this)">
                    <span>Laufzettel</span>
                  </button>
                </div>
              </div>
            </div>
          </form>
          <div class="inhalt">
            <div class="innen">
              <xsl:call-template name="uebersicht" />
              <xsl:call-template name="details" />
              <xsl:call-template name="zusaetze" />
              <xsl:call-template name="anlagen" />
              <xsl:call-template name="laufzettel" />
            </div>
          </div>
        </div>
      </body>
      <script>
        <xsl:value-of select="unparsed-text('xrechnung-viewer.js')" />
      </script>
    </html>
  </xsl:template>


  <xsl:template name="uebersicht">
    <div id="uebersicht" class="divShow" role="tabpanel" aria-labelledby="menueUebersicht" tabindex="0">
      <div class="haftungausschluss">Wir übernehmen keine Haftung für die Richtigkeit der Daten.</div>
      <div class="boxtabelle boxtabelleZweispaltig">
        <div class="boxzeile">

          <xsl:apply-templates select="./xr:BUYER" />

          <div class="boxabstand"></div>

          <xsl:apply-templates select="./xr:SELLER" />

        </div>
      </div>

      <div class="boxtabelle boxabstandtop boxtabelleZweispaltig">
        <xsl:call-template name="uebersichtRechnungsinfo" />
      </div>

      <div class="boxtabelle boxabstandtop boxtabelleZweispaltig">
        <xsl:call-template name="uebersichtRechnungsuebersicht" />
      </div>

      <div class="boxtabelle boxabstandtop boxtabelleZweispaltig">
        <xsl:apply-templates select="./xr:VAT_BREAKDOWN" />
      </div>

      <div class="boxtabelle boxabstandtop boxtabelleZweispaltig">
        <xsl:apply-templates select="./xr:DOCUMENT_LEVEL_ALLOWANCES" />
      </div>

      <div class="boxtabelle boxabstandtop boxtabelleZweispaltig">
        <xsl:apply-templates select="./xr:DOCUMENT_LEVEL_CHARGES" />
      </div>

      <div class="boxtabelle boxabstandtop boxtabelleZweispaltig first">
        <div class="boxzeile">
          <xsl:call-template name="uebersichtZahlungsinformationen" />
          <xsl:call-template name="uebersichtCard" />
        </div>
      </div>

      <div class="boxtabelle">
        <div class="boxzeile">
          <xsl:call-template name="uebersichtLastschrift" />
          <xsl:call-template name="uebersichtUeberweisung" />
        </div>
      </div>

      <div class="boxtabelle boxabstandtop">
        <div class="boxzeile">
          <xsl:apply-templates select="./xr:INVOICE_NOTE" />
        </div>
      </div>
    </div>
  </xsl:template>


  <xsl:template name="uebersichtKaeufer" match="xr:BUYER">
    <div id="uebersichtKaeufer" class="box boxZweispaltig">
      <div id="BG-7" data-title="BG-7" class="boxtitel" role="heading" aria-level="2">Informationen zum Käufer
      </div>
      <div class="boxtabelle boxinhalt borderSpacing" role="list">
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Leitweg-ID:</div>
          <div id="BT-10" data-title="BT-10" class="boxdaten wert">
            <xsl:value-of select="../xr:Buyer_reference" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Name:</div>
          <div id="BT-44" data-title="BT-44" class="boxdaten wert">
            <xsl:value-of select="xr:Buyer_name" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Straße / Hausnummer:</div>
          <div id="BT-50" data-title="BT-50" class="boxdaten wert">
            <xsl:value-of select="xr:BUYER_POSTAL_ADDRESS/xr:Buyer_address_line_1" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Postfach:</div>
          <div id="BT-51" data-title="BT-51" class="boxdaten wert">
            <xsl:value-of select="xr:BUYER_POSTAL_ADDRESS/xr:Buyer_address_line_2" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Adresszusatz:</div>
          <div id="BT-163" data-title="BT-163" class="boxdaten wert">
            <xsl:value-of select="xr:BUYER_POSTAL_ADDRESS/xr:Buyer_address_line_3" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">PLZ:</div>
          <div id="BT-53" data-title="BT-53" class="boxdaten wert">
            <xsl:value-of select="xr:BUYER_POSTAL_ADDRESS/xr:Buyer_post_code" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Ort:</div>
          <div id="BT-52" data-title="BT-52" class="boxdaten wert">
            <xsl:value-of select="xr:BUYER_POSTAL_ADDRESS/xr:Buyer_city" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Bundesland:</div>
          <div id="BT-54" data-title="BT-54" class="boxdaten wert">
            <xsl:value-of select="xr:BUYER_POSTAL_ADDRESS/xr:Buyer_country_subdivision" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Land:</div>
          <div id="BT-55" data-title="BT-55" class="boxdaten wert">
            <xsl:value-of select="xr:BUYER_POSTAL_ADDRESS/xr:Buyer_country_code" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Kennung:</div>
          <div id="BT-46" data-title="BT-46" class="boxdaten wert">
            <xsl:value-of select="xr:Buyer_identifier" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Schema der Kennung:</div>
          <div id="BT-46-scheme-id" data-title="BT-46-scheme-id" class="boxdaten wert">
            <xsl:value-of select="xr:Buyer_identifier/@scheme_identifier" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Name:</div>
          <div id="BT-56" data-title="BT-56" class="boxdaten wert">
            <xsl:value-of select="xr:BUYER_CONTACT/xr:Buyer_contact_point" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Telefon:</div>
          <div id="BT-57" data-title="BT-57" class="boxdaten wert">
            <xsl:value-of select="xr:BUYER_CONTACT/xr:Buyer_contact_telephone_number" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">E-Mail-Adresse:</div>
          <div id="BT-58" data-title="BT-58" class="boxdaten wert">
            <xsl:value-of select="xr:BUYER_CONTACT/xr:Buyer_contact_email_address" />
          </div>
        </div>
      </div>
    </div>
  </xsl:template>


  <xsl:template name="uebersichtVerkaeufer" match="xr:SELLER">
    <div id="uebersichtVerkaeufer" class="box boxZweispaltig">
      <div id="BG-4" data-title="BG-4" class="boxtitel" role="heading" aria-level="2">Informationen zum
        Verkäufer
      </div>
      <div class="boxtabelle boxinhalt borderSpacing" role="list">
        <div class="boxzeile">
          <div class="boxdaten legende"></div>
          <div class="boxdaten wert" style="background-color: white;"></div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Firmenname:</div>
          <div id="BT-27" data-title="BT-27" class="boxdaten wert">
            <xsl:value-of select="xr:Seller_name" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Straße / Hausnummer:</div>
          <div id="BT-35" data-title="BT-35" class="boxdaten wert">
            <xsl:value-of select="xr:SELLER_POSTAL_ADDRESS/xr:Seller_address_line_1" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Postfach:</div>
          <div id="BT-36" data-title="BT-36" class="boxdaten wert">
            <xsl:value-of select="xr:SELLER_POSTAL_ADDRESS/xr:Seller_address_line_2" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Adresszusatz:</div>
          <div id="BT-162" data-title="BT-162" class="boxdaten wert">
            <xsl:value-of select="xr:SELLER_POSTAL_ADDRESS/xr:Seller_address_line_3" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">PLZ:</div>
          <div id="BT-38" data-title="BT-38" class="boxdaten wert">
            <xsl:value-of select="xr:SELLER_POSTAL_ADDRESS/xr:Seller_post_code" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Ort:</div>
          <div id="BT-37" data-title="BT-37" class="boxdaten wert">
            <xsl:value-of select="xr:SELLER_POSTAL_ADDRESS/xr:Seller_city" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Bundesland:</div>
          <div id="BT-39" data-title="BT-39" class="boxdaten wert">
            <xsl:value-of select="xr:SELLER_POSTAL_ADDRESS/xr:Seller_country_subdivision" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Ländercode:</div>
          <div id="BT-40" data-title="BT-40" class="boxdaten wert">
            <xsl:value-of select="xr:SELLER_POSTAL_ADDRESS/xr:Seller_country_code" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Kennung:</div>
          <div id="BT-29" data-title="BT-29" class="boxdaten wert">
            <xsl:value-of select="xr:Seller_identifier" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Schema der Kennung:</div>
          <div id="BT-29-scheme-id" data-title="BT-29-scheme-id" class="boxdaten wert">
            <xsl:value-of select="xr:Seller_identifier/@scheme_identifier" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Name:</div>
          <div id="BT-41" data-title="BT-41" class="boxdaten wert">
            <xsl:value-of select="xr:SELLER_CONTACT/xr:Seller_contact_point" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Telefon:</div>
          <div id="BT-42" data-title="BT-42" class="boxdaten wert">
            <xsl:value-of select="xr:SELLER_CONTACT/xr:Seller_contact_telephone_number" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">E-Mail-Adresse:</div>
          <div id="BT-43" data-title="BT-43" class="boxdaten wert">
            <xsl:value-of select="xr:SELLER_CONTACT/xr:Seller_contact_email_address" />
          </div>
        </div>
      </div>
    </div>
  </xsl:template>


  <xsl:template name="uebersichtRechnungsinfo">
    <div class="boxzeile">
      <div id="uebersichtRechnungsinfo" class="box box1v2">
        <div class="boxtitel" role="heading" aria-level="2">Rechnungsdaten</div>
        <div class="boxtabelle boxinhalt">
          <div class="boxcell boxZweispaltig">
            <div class="boxtabelle borderSpacing" role="list">
              <div class="boxzeile" role="listitem">
                <div class="boxdaten legende">Rechnungsnummer:</div>
                <div id="BT-1" data-title="BT-1" class="boxdaten wert">
                  <xsl:value-of select="xr:Invoice_number" />
                </div>
              </div>
              <div class="boxzeile" role="listitem">
                <div class="boxdaten legende">Rechnungsdatum:</div>
                <div id="BT-2" data-title="BT-2" class="boxdaten wert">
                  <xsl:value-of select="format-date(xr:Invoice_issue_date,'[D].[M].[Y]')" />
                </div>
              </div>
              <div class="boxzeile" role="listitem">
                <div class="boxdaten legende">Rechnungsart:</div>
                <div id="BT-3" data-title="BT-3" class="boxdaten wert">
                  <xsl:value-of select="xr:Invoice_type_code" />
                </div>
              </div>
              <div class="boxzeile" role="listitem">
                <div class="boxdaten legende">Währung:</div>
                <div id="BT-5" data-title="BT-5" class="boxdaten wert">
                  <xsl:value-of select="xr:Invoice_currency_code" />
                </div>
              </div>
              <div class="boxzeile" role="listitem">
                <div class="boxdaten legende">Abrechnungsdatum der Umsatzsteuer:</div>
                <div id="BT-7" data-title="BT-7" class="boxdaten wert">
                  <xsl:for-each select="tokenize(../xr:Value_added_tax_point_date,';')">
                    <xsl:value-of select="format-date(xs:date(.),'[D].[M].[Y]')" />
                    <xsl:if test="position() != last()">
                      <br />
                    </xsl:if>
                  </xsl:for-each>
                </div>
              </div>
              <div class="boxzeile" role="listitem">
                <div class="boxdaten legende">Code des Umsatzsteuer-Abrechnungsdatums:</div>
                <div id="BT-8" data-title="BT-8" class="boxdaten wert">
                  <xsl:value-of select="../xr:Value_added_tax_point_date_code" />
                </div>
              </div>
              <div role="listitem">
                <strong>Abrechnungszeitraum:</strong>
                <div class="boxtabelle borderSpacing" role="list">
                  <div class="boxzeile" role="listitem">
                    <div class="boxdaten legende">von:</div>
                    <div id="BT-73" data-title="BT-73" class="boxdaten wert">
                      <xsl:value-of
                        select="format-date(xr:DELIVERY_INFORMATION/xr:INVOICING_PERIOD/xr:Invoicing_period_start_date,'[D].[M].[Y]')" />
                    </div>
                  </div>
                  <div class="boxzeile" role="listitem">
                    <div class="boxdaten legende">bis:</div>
                    <div id="BT-74" data-title="BT-74" class="boxdaten wert">
                      <xsl:value-of
                        select="format-date(xr:DELIVERY_INFORMATION/xr:INVOICING_PERIOD/xr:Invoicing_period_end_date,'[D].[M].[Y]')" />
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="boxabstand"></div>
          <div class="boxcell boxZweispaltig">
            <div class="boxtabelle borderSpacing" role="list">
              <div class="boxzeile" role="listitem">
                <div class="boxdaten legende">Projektnummer:</div>
                <div id="BT-11" data-title="BT-11" class="boxdaten wert">
                  <xsl:value-of select="xr:Project_reference" />
                </div>
              </div>
              <div class="boxzeile" role="listitem">
                <div class="boxdaten legende">Vertragsnummer:</div>
                <div id="BT-12" data-title="BT-12" class="boxdaten wert">
                  <xsl:value-of select="xr:Contract_reference" />
                </div>
              </div>
              <div class="boxzeile" role="listitem">
                <div class="boxdaten legende">Bestellnummer:</div>
                <div id="BT-13" data-title="BT-13" class="boxdaten wert">
                  <xsl:value-of select="xr:Purchase_order_reference" />
                </div>
              </div>
              <div class="boxzeile" role="listitem">
                <div class="boxdaten legende">Auftragsnummer:</div>
                <div id="BT-14" data-title="BT-14" class="boxdaten wert">
                  <xsl:value-of select="xr:Sales_order_reference" />
                </div>
              </div>
              <xsl:apply-templates select="./xr:PRECEDING_INVOICE_REFERENCE" />
            </div>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="xr:PRECEDING_INVOICE_REFERENCE">
    <div role="listitem">
      <strong>Vorausgegangene Rechnungen:</strong>
      <div class="boxtabelle borderSpacing" role="list">
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Rechnungsnummer:</div>
          <div id="BT-25" data-title="BT-25" class="boxdaten wert">
            <xsl:value-of select="xr:Preceding_Invoice_reference" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Rechnungsdatum:</div>
          <div id="BT-26" data-title="BT-26" class="boxdaten wert">
            <xsl:value-of select="(format-date,xr:Preceding_Invoice_issue_date,'[D].[M].[Y]')" />
          </div>
        </div>
      </div>
    </div>
  </xsl:template>


  <xsl:template name="uebersichtRechnungsuebersicht">
    <div class="boxzeile">
      <div id="uebersichtRechnungsuebersicht" class="box">
        <div id="BG-22" data-title="BG-22" class="boxtitel" role="heading" aria-level="2">Gesamtbeträge der
          Rechnung
        </div>
        <div class="boxtabelle boxinhalt" role="table">
          <div class="rechnungsZeile" role="row">
            <div class="boxdaten rechnungSp1" role="rowheader">Summe aller Positionen</div>
            <div class="boxdaten rechnungSp2 color2" role="cell">netto</div>
            <div id="BT-106" data-title="BT-106" class="boxdaten rechnungSp3" role="cell">
              <xsl:value-of
                select="format-number(xr:DOCUMENT_TOTALS/xr:Sum_of_Invoice_line_net_amount,'###.##0,00','decimal')" />
            </div>
          </div>
          <div class="rechnungsZeile" role="row">
            <div class="boxdaten rechnungSp1" role="rowheader">Summe Nachlässe</div>
            <div class="boxdaten rechnungSp2 color2" role="cell">netto</div>
            <div id="BT-107" data-title="BT-107" class="boxdaten rechnungSp3" role="cell">
              <xsl:value-of
                select="format-number(xr:DOCUMENT_TOTALS/xr:Sum_of_allowances_on_document_level,'###.##0,00','decimal')" />
            </div>
          </div>
          <div class="rechnungsZeile" role="row">
            <div class="boxdaten rechnungSp1 paddingBottom line1Bottom" role="rowheader">Summe Zuschläge
            </div>
            <div class="boxdaten rechnungSp2 paddingBottom line1Bottom color2" role="cell">netto</div>
            <div id="BT-108" data-title="BT-108" class="boxdaten rechnungSp3 paddingBottom line1Bottom" role="cell">
              <xsl:value-of
                select="format-number(xr:DOCUMENT_TOTALS/xr:Sum_of_charges_on_document_level,'###.##0,00','decimal')" />
            </div>
          </div>
          <div class="rechnungsZeile" role="row">
            <div class="boxdaten rechnungSp1 paddingTop" role="rowheader">Gesamtsumme</div>
            <div class="boxdaten rechnungSp2 paddingTop color2" role="cell">netto</div>
            <div id="BT-109" data-title="BT-109" class="boxdaten rechnungSp3 paddingTop" role="cell">
              <xsl:value-of
                select="format-number(xr:DOCUMENT_TOTALS/xr:Invoice_total_amount_without_VAT,'###.##0,00','decimal')" />
            </div>
          </div>
          <div class="rechnungsZeile" role="row">
            <div class="boxdaten rechnungSp1" role="rowheader">Summe Umsatzsteuer</div>
            <div class="boxdaten rechnungSp2 color2" role="cell"></div>
            <div id="BT-110" data-title="BT-110" class="boxdaten rechnungSp3" role="cell">
              <xsl:value-of
                select="format-number(xr:DOCUMENT_TOTALS/xr:Invoice_total_VAT_amount,'###.##0,00','decimal')" />
            </div>
          </div>
          <div class="rechnungsZeile" role="row">
            <div class="boxdaten rechnungSp1 paddingBottom line1Bottom" role="rowheader">Summe Umsatzsteuer
              in
              Abrechnungswährung
            </div>
            <div class="boxdaten rechnungSp2 paddingBottom line1Bottom color2" role="cell"></div>
            <div id="BT-111" data-title="BT-111" class="boxdaten rechnungSp3 paddingBottom line1Bottom" role="cell">
              <xsl:value-of
                select="format-number(xr:DOCUMENT_TOTALS/xr:Invoice_total_VAT_amount_in_accounting_currency,'###.##0,00','decimal')" />
            </div>
          </div>
          <div class="rechnungsZeile" role="row">
            <div class="boxdaten rechnungSp1 paddingTop" role="rowheader">Gesamtsumme</div>
            <div class="boxdaten rechnungSp2 paddingTop color2" role="cell">brutto</div>
            <div id="BT-112" data-title="BT-112" class="boxdaten rechnungSp3 paddingTop" role="cell">
              <xsl:value-of
                select="format-number(xr:DOCUMENT_TOTALS/xr:Invoice_total_amount_with_VAT,'###.##0,00','decimal')" />
            </div>
          </div>
          <div class="rechnungsZeile" role="row">
            <div class="boxdaten rechnungSp1" role="rowheader">Gezahlter Betrag</div>
            <div class="boxdaten rechnungSp2 color2" role="cell">brutto</div>
            <div id="BT-113" data-title="BT-113" class="boxdaten rechnungSp3" role="cell">
              <xsl:value-of
                select="format-number(xr:DOCUMENT_TOTALS/xr:Paid_amount,'###.##0,00','decimal')" />
            </div>
          </div>
          <div class="rechnungsZeile" role="row">
            <div class="boxdaten rechnungSp1 paddingBottom line2Bottom" role="rowheader">Rundungsbetrag
            </div>
            <div class="boxdaten rechnungSp2 paddingBottom line2Bottom color2" role="cell">brutto</div>
            <div id="BT-114" data-title="BT-114" class="boxdaten rechnungSp3 paddingBottom line2Bottom" role="cell">
              <xsl:value-of
                select="format-number(xr:DOCUMENT_TOTALS/xr:Rounding_amount,'###.##0,00','decimal')" />
            </div>
          </div>
          <div class="rechnungsZeile" role="row">
            <div class="boxdaten rechnungSp1 paddingTop bold" role="rowheader">Fälliger Betrag</div>
            <div class="boxdaten rechnungSp2 paddingTop color2" role="cell">brutto</div>
            <div id="BT-115" data-title="BT-115" class="boxdaten rechnungSp3 paddingTop bold" role="cell">
              <xsl:value-of
                select="format-number(xr:DOCUMENT_TOTALS/xr:Amount_due_for_payment,'###.##0,00','decimal')" />
            </div>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>


  <xsl:template name="uebersichtUmsatzsteuer" match="xr:VAT_BREAKDOWN">
    <div class="boxzeile">
      <div class="uebersichtUmsatzsteuer box">
        <div id="BG-23" data-title="BG-23" class="boxtitel" role="heading" aria-level="2">Aufschlüsselung der
          Umsatzsteuer auf Ebene der Rechnung
        </div>
        <div class="boxtabelle boxinhalt" role="table">
          <div class="rechnungsZeile" role="row">
            <div class="boxdaten rechnungSp1 bold" role="rowheader">
              Umsatzsteuerkategorie:
              <span id="BT-118" data-title="BT-118">
                <xsl:value-of select="xr:VAT_category_code" />
              </span>
            </div>
            <div class="boxdaten rechnungSp2" role="cell"></div>
            <div class="boxdaten rechnungSp3" role="cell"></div>
          </div>
          <div class="rechnungsZeile" role="row">
            <div class="boxdaten rechnungSp1" role="rowheader">Gesamtsumme</div>
            <div class="boxdaten rechnungSp2 color2" role="cell">netto</div>
            <div id="BT-116" data-title="BT-116" class="boxdaten rechnungSp3" role="cell">
              <xsl:value-of select="format-number(xr:VAT_category_taxable_amount,'###.##0,00','decimal')" />
            </div>
          </div>
          <div class="rechnungsZeile" role="row">
            <div class="boxdaten rechnungSp1 line1Bottom" role="rowheader">Umsatzsteuersatz</div>
            <div class="boxdaten rechnungSp2 color2 line1Bottom" role="cell"></div>
            <div id="BT-119" data-title="BT-119" class="boxdaten rechnungSp3 line1Bottom" role="cell">
              <xsl:value-of select="xr:VAT_category_rate" />
              %
            </div>
          </div>
          <div class="rechnungsZeile" role="row">
            <div class="boxdaten rechnungSp1" role="rowheader">Umsatzsteuerbetrag</div>
            <div class="boxdaten rechnungSp2 color2" role="cell"></div>
            <div id="BT-117" data-title="BT-117" class="boxdaten rechnungSp3 bold" role="cell">
              <xsl:value-of select="format-number(xr:VAT_category_tax_amount,'###.##0,00','decimal')" />
            </div>
          </div>
        </div>

        <div class="grund" role="list">
          <div role="listitem">
            Befreiungsgrund:
            <span id="BT-120" data-title="BT-120" class="bold">
              <xsl:value-of select="xr:VAT_exemption_reason_text" />
            </span>
          </div>
          <div role="listitem">
            Kennung für den Befreiungsgrund:
            <span id="BT-121" data-title="BT-121" class="bold">
              <xsl:value-of select="xr:VAT_exemption_reason_code" />
            </span>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>


  <xsl:template name="uebersichtNachlass" match="xr:DOCUMENT_LEVEL_ALLOWANCES">
    <div class="boxzeile">
      <div id="uebersichtNachlass" class="box">
        <div id="BG-20" data-title="BG-20" class="boxtitel" role="heading" aria-level="2">Nachlass auf Ebene der
          Rechnung
        </div>
        <div class="boxtabelle boxinhalt" role="table">
          <div class="rechnungsZeile" role="row">
            <div class="boxdaten rechnungSp1 bold" role="rowheader">
              Umsatzsteuerkategorie des Nachlasses:
              <span data-title="BT-95">
                <xsl:value-of select="xr:Document_level_allowance_VAT_category_code" />
              </span>
            </div>
            <div class="boxdaten rechnungSp2" role="cell"></div>
            <div class="boxdaten rechnungSp3" role="cell"></div>
          </div>
          <div class="rechnungsZeile" role="row">
            <div class="boxdaten rechnungSp1" role="rowheader">Grundbetrag</div>
            <div class="boxdaten rechnungSp2 color2" role="cell">netto</div>
            <div id="BT-93" data-title="BT-93" class="boxdaten rechnungSp3" role="cell">
              <xsl:value-of
                select="format-number(xr:Document_level_allowance_base_amount,'###.##0,00','decimal')" />
            </div>
          </div>
          <div class="rechnungsZeile" role="row">
            <div class="boxdaten rechnungSp1 line1Bottom" role="rowheader">Prozentsatz</div>
            <div class="boxdaten rechnungSp2 color2 line1Bottom" role="cell"></div>
            <div id="BT-94" data-title="BT-94" class="boxdaten rechnungSp3 line1Bottom" role="cell">
              <xsl:value-of select="xr:Document_level_allowance_percentage" />
              %
            </div>
          </div>
          <div class="rechnungsZeile" role="row">
            <div class="boxdaten rechnungSp1" role="rowheader">Nachlass</div>
            <div class="boxdaten rechnungSp2 color2" role="cell">netto</div>
            <div id="BT-92" data-title="BT-92" class="boxdaten rechnungSp3 bold" role="cell">
              <xsl:value-of
                select="format-number(xr:Document_level_allowance_amount,'###.##0,00','decimal')" />
            </div>
          </div>
          <div class="rechnungsZeile" role="row">
            <div class="boxdaten rechnungSp1" role="rowheader">Umsatzsteuersatz des Nachlasses</div>
            <div class="boxdaten rechnungSp2 color2" role="cell"></div>
            <div id="BT-96" data-title="BT-96" class="boxdaten rechnungSp3" role="cell">
              <xsl:value-of select="xr:Document_level_allowance_VAT_rate" />
            </div>
          </div>
        </div>
        <div class="grund" role="list">
          <div role="listitem">
            Grund für den Nachlass:
            <span id="BT-97" data-title="BT-97" class="bold">
              <xsl:value-of select="xr:Document_level_allowance_reason" />
            </span>
          </div>
          <div role="listitem">
            Document level allowance reason code:
            <span id="BT-98" data-title="BT-98" class="bold">
              <xsl:value-of select="xr:Document_level_allowance_reason_code" />
            </span>
          </div>
        </div>
      </div>
    </div>
    <div class="boxabstand"></div>
  </xsl:template>


  <xsl:template name="uebersichtZuschlaege" match="xr:DOCUMENT_LEVEL_CHARGES">
    <div class="boxzeile">
      <div id="uebersichtZuschlaege" class="box">
        <div id="BG-21" data-title="BG-21" class="boxtitel" role="heading" aria-level="2">Zuschlag auf Ebene der
          Rechnung
        </div>
        <div class="boxtabelle boxinhalt" role="table">
          <div class="rechnungsZeile" role="row">
            <div class="boxdaten rechnungSp1 bold" role="rowheader">
              Umsatzsteuerkategorie des Zuschlages:
              <span data-title="BT-102">
                <xsl:value-of select="xr:Document_level_charge_VAT_category_code" />
              </span>
            </div>
            <div class="boxdaten rechnungSp2" role="cell"></div>
            <div class="boxdaten rechnungSp3" role="cell"></div>
          </div>
          <div class="rechnungsZeile" role="row">
            <div class="boxdaten rechnungSp1" role="rowheader">Grundbetrag</div>
            <div class="boxdaten rechnungSp2 color2" role="cell">netto</div>
            <div id="BT-100" data-title="BT-100" class="boxdaten rechnungSp3" role="cell">
              <xsl:value-of
                select="format-number(xr:Document_level_charge_base_amount,'###.##0,00','decimal')" />
            </div>
          </div>
          <div class="rechnungsZeile" role="row">
            <div class="boxdaten rechnungSp1 line1Bottom" role="rowheader">Prozentsatz</div>
            <div class="boxdaten rechnungSp2 color2 line1Bottom" role="cell"></div>
            <div id="BT-101" data-title="BT-101" class="boxdaten rechnungSp3 line1Bottom" role="cell">
              <xsl:value-of select="xr:Document_level_charge_percentage" />
              %
            </div>
          </div>
          <div class="rechnungsZeile" role="row">
            <div class="boxdaten rechnungSp1" role="rowheader">Zuschlag</div>
            <div class="boxdaten rechnungSp2 color2" role="cell">netto</div>
            <div id="BT-99" data-title="BT-99" class="boxdaten rechnungSp3 bold" role="cell">
              <xsl:value-of select="format-number(xr:Document_level_charge_amount,'###.##0,00','decimal')" />
            </div>
          </div>
          <div class="rechnungsZeile" role="row">
            <div class="boxdaten rechnungSp1" role="rowheader">Umsatzsteuersatz des Zuschlages</div>
            <div class="boxdaten rechnungSp2 color2" role="cell"></div>
            <div id="BT-103" data-title="BT-103" class="boxdaten rechnungSp3" role="cell">
              <xsl:value-of select="xr:Document_level_charge_VAT_rate" />
            </div>
          </div>
        </div>
        <div class="grund" role="listitem">
          <div>
            Grund für den Zuschlag:
            <span id="BT-104" data-title="BT-104" class="bold">
              <xsl:value-of select="xr:Document_level_charge_reason" />
            </span>
          </div>
          <div>
            Document level charge reason code:
            <span id="BT-105" data-title="BT-105" class="bold">
              <xsl:value-of select="xr:Document_level_charge_reason_code" />
            </span>
          </div>
        </div>
      </div>
    </div>
    <div class="boxabstand"></div>
  </xsl:template>


  <xsl:template name="uebersichtZahlungsinformationen">
    <div id="uebersichtZahlungsinformationen" class="box subBox">
      <div data-title="" class="boxtitel" role="heading" aria-level="2">Zahlungsdaten</div>
      <div class="boxtabelle boxinhalt borderSpacing" role="list">
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Skonto; weitere Zahlungsbedingungen:</div>
          <div id="BT-20" data-title="BT-20" class="boxdaten wert">
            <xsl:for-each select="tokenize(xr:Payment_terms,';')">
              <xsl:value-of select="." />
              <xsl:if test="position() != last()">
                <br />
              </xsl:if>
            </xsl:for-each>
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Fälligkeitsdatum:</div>
          <div id="BT-9" data-title="BT-9" class="boxdaten wert">
            <xsl:for-each select="tokenize(xr:Payment_due_date,';')">
              <xsl:value-of select="format-date(xs:date(.),'[D].[M].[Y]')" />
              <xsl:if test="position() != last()">
                <br />
              </xsl:if>
            </xsl:for-each>
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Code für das Zahlungsmittel:</div>
          <div id="BT-81" data-title="BT-81" class="boxdaten wert">
            <xsl:value-of select="xr:PAYMENT_INSTRUCTIONS/xr:Payment_means_type_code" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Zahlungsmittel:</div>
          <div id="BT-82" data-title="BT-82" class="boxdaten wert">
            <xsl:value-of select="xr:PAYMENT_INSTRUCTIONS/xr:Payment_means_text" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Verwendungszweck:</div>
          <div id="BT-83" data-title="BT-83" class="boxdaten wert">
            <xsl:value-of select="xr:PAYMENT_INSTRUCTIONS/xr:Remittance_information" />
          </div>
        </div>
      </div>
    </div>
  </xsl:template>


  <xsl:template name="uebersichtCard">
    <div id="uebersichtCard" class="box subBox">
      <div id="BG-18" data-title="BG-18" class="boxtitel boxtitelSub" role="heading" aria-level="3">
        Karteninformation
      </div>
      <div class="boxtabelle boxinhalt borderSpacing" role="list">
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Kartennummer:</div>
          <div id="BT-87" data-title="BT-87" class="boxdaten wert">
            <xsl:value-of
              select="xr:PAYMENT_INSTRUCTIONS/xr:PAYMENT_CARD_INFORMATION/xr:Payment_card_primary_account_number" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Karteninhaber:</div>
          <div id="BT-88" data-title="BT-88" class="boxdaten wert">
            <xsl:value-of
              select="xr:PAYMENT_INSTRUCTIONS/xr:PAYMENT_CARD_INFORMATION/xr:Payment_card_holder_name" />
          </div>
        </div>
      </div>
    </div>
  </xsl:template>


  <xsl:template name="uebersichtLastschrift">
    <div id="uebersichtLastschrift" class="box subBox">
      <div id="BG-19" data-title="BG-19" class="boxtitel boxtitelSub" role="heading" aria-level="3">Lastschrift
      </div>
      <div class="boxtabelle boxinhalt borderSpacing" role="list">
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Mandatsreferenznr.:</div>
          <div id="BT-89" data-title="BT-89" class="boxdaten wert">
            <xsl:value-of select="xr:PAYMENT_INSTRUCTIONS/xr:DIRECT_DEBIT/xr:Mandate_reference_identifier" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">IBAN:</div>
          <div id="BT-91" data-title="BT-91" class="boxdaten wert">
            <xsl:value-of select="xr:PAYMENT_INSTRUCTIONS/xr:DIRECT_DEBIT/xr:Debited_account_identifier" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Gläubiger-ID:</div>
          <div id="BT-90" data-title="BT-90" class="boxdaten wert">
            <xsl:value-of
              select="xr:PAYMENT_INSTRUCTIONS/xr:DIRECT_DEBIT/xr:Bank_assigned_creditor_identifier" />
          </div>
        </div>
      </div>
    </div>
  </xsl:template>


  <xsl:template name="uebersichtUeberweisung">
    <div id="uebersichtUeberweisung" class="box subBox">
      <div id="BG-17" data-title="BG-17" class="boxtitel boxtitelSub" role="heading" aria-level="3">Überweisung
      </div>
      <xsl:for-each select="xr:PAYMENT_INSTRUCTIONS/xr:CREDIT_TRANSFER">
        <div class="boxtabelle boxinhalt borderSpacing" role="list">
          <div class="boxzeile" role="listitem">
            <div class="boxdaten legende">Kontoinhaber:</div>
            <div id="BT-85" data-title="BT-85" class="boxdaten wert">
              <xsl:value-of select="xr:Payment_account_name" />
            </div>
          </div>
          <div class="boxzeile" role="listitem">
            <div class="boxdaten legende">IBAN:</div>
            <div id="BT-84" data-title="BT-84" class="boxdaten wert">
              <xsl:value-of select="xr:Payment_account_identifier" />
            </div>
          </div>
          <div class="boxzeile" role="listitem">
            <div class="boxdaten legende">BIC:</div>
            <div id="BT-86" data-title="BT-86" class="boxdaten wert">
              <xsl:value-of select="xr:Payment_service_provider_identifier" />
            </div>
          </div>
        </div>
      </xsl:for-each>
    </div>
  </xsl:template>


  <xsl:template name="uebersichtBemerkungen" match="xr:INVOICE_NOTE">
    <div id="uebersichtBemerkungen" class="box">
      <div id="BG-1" data-title="BG-1" class="boxtitel" role="heading" aria-level="2">Bemerkung zur Rechnung</div>
      <div class="boxtabelle boxinhalt borderSpacing" role="list">
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Betreff:</div>
          <div id="BT-21" data-title="BT-21" class="boxdaten wert">
            <xsl:value-of select="xr:Invoice_note_subject_code" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Bemerkung:</div>
          <div id="BT-22" data-title="BT-22" class="boxdaten wert">
            <xsl:value-of select="xr:Invoice_note" />
          </div>
        </div>
      </div>
    </div>
  </xsl:template>


  <xsl:template name="details">
    <div id="details" class="divHide" role="tabpanel" aria-labelledby="menueDetails" tabindex="0">
      <div class="haftungausschluss">Wir übernehmen keine Haftung für die Richtigkeit der Daten.</div>
      <xsl:apply-templates select="./xr:INVOICE_LINE" /> <!-- many -->
    </div>
  </xsl:template>


  <xsl:template match="xr:INVOICE_LINE | xr:SUB_INVOICE_LINE">
    <div class="boxtabelle boxabstandtop boxtabelleZweispaltig first">
      <div class="boxzeile">
        <div class="box subBox">
          <div id="BT-126" data-title="BT-126" class="boxtitel" role="heading" aria-level="2">
            Position
            <xsl:value-of select="xr:Invoice_line_identifier" />
          </div>
          <div class="boxtabelle boxinhalt borderSpacing" role="list">
            <div class="boxzeile" role="listitem">
              <div class="boxdaten legende">Freitext:</div>
              <div id="BT-127" data-title="BT-127" class="boxdaten wert">
                <xsl:value-of select="xr:Invoice_line_note" />
              </div>
            </div>
            <div class="boxzeile" role="listitem">
              <div class="boxdaten legende">Objektkennung:</div>
              <div id="BT-128" data-title="BT-128" class="boxdaten wert">
                <xsl:value-of select="xr:Invoice_line_object_identifier" />
              </div>
            </div>
            <div class="boxzeile" role="listitem">
              <div class="boxdaten legende">Schema der Objektkennung:</div>
              <div id="BT-128-scheme-id" data-title="BT-128-scheme-id" class="boxdaten wert">
                <xsl:value-of select="xr:Invoice_line_object_identifier/@scheme_identifier" />
              </div>
            </div>
            <div class="boxzeile" role="listitem">
              <div class="boxdaten legende">Nummer der Auftragsposition:</div>
              <div id="BT-132" data-title="BT-132" class="boxdaten wert">
                <xsl:value-of select="xr:Referenced_purchase_order_line_reference" />
              </div>
            </div>
            <div class="boxzeile" role="listitem">
              <div class="boxdaten legende">Kontierungshinweis:</div>
              <div id="BT-133" data-title="BT-133" class="boxdaten wert">
                <xsl:value-of select="xr:Invoice_line_Buyer_accounting_reference" />
              </div>
            </div>
            <div role="listitem">
              <strong id="BG-26" data-title="BG-26">Abrechnungszeitraum:</strong>
              <div class="boxtabelle borderSpacing" role="list">
                <div class="boxzeile" role="listitem">
                  <div class="boxdaten legende">von:</div>
                  <div id="BT-134" data-title="BT-134" class="boxdaten wert">
                    <xsl:value-of
                      select="format-date(xr:INVOICE_LINE_PERIOD/xr:Invoice_line_period_start_date,'[D].[M].[Y]')" />
                  </div>
                </div>
                <div class="boxzeile" role="listitem">
                  <div class="boxdaten legende">bis:</div>
                  <div id="BT-135" data-title="BT-135" class="boxdaten wert">
                    <xsl:value-of
                      select="format-date(xr:INVOICE_LINE_PERIOD/xr:Invoice_line_period_end_date,'[D].[M].[Y]')" />
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="box subBox">
          <div id="BG-29" data-title="BG-29" class="boxtitel boxtitelSub" role="heading" aria-level="3">
            Preiseinzelheiten
          </div>
          <div class="boxtabelle boxinhalt" role="table">
            <div class="rechnungsZeile" role="row">
              <div class="boxdaten detailSp1 color2" role="rowheader">Menge</div>
              <div id="BT-129" data-title="BT-129" class="boxdaten detailSp2" role="cell">
                <xsl:value-of select="xr:Invoiced_quantity" />
              </div>
            </div>
            <div class="rechnungsZeile" role="row">
              <div class="boxdaten detailSp1 color2" role="rowheader">Einheit</div>
              <div id="BT-130" data-title="BT-130" class="boxdaten detailSp2" role="cell">
                <xsl:value-of select="xr:Invoiced_quantity_unit_of_measure_code" />
              </div>
            </div>
            <div class="rechnungsZeile" role="row">
              <div class="boxdaten detailSp1 line1Bottom color2" role="rowheader">Preis pro Einheit
                (netto)
              </div>
              <div id="BT-146" data-title="BT-146" class="boxdaten detailSp2 line1Bottom" role="cell">
                <xsl:value-of
                  select="format-number(xr:PRICE_DETAILS/xr:Item_net_price,'###.##0,00','decimal')" />
              </div>
            </div>
            <div class="rechnungsZeile" role="row">
              <div class="boxdaten detailSp1 color2" role="rowheader">Gesamtpreis (netto)</div>
              <div id="BT-131" data-title="BT-131" class="boxdaten detailSp2 bold" role="cell">
                <xsl:value-of select="format-number(xr:Invoice_line_net_amount,'###.##0,00','decimal')" />
              </div>
            </div>
          </div>
          <div class="boxtabelle boxinhalt noPaddingTop borderSpacing" role="list">
            <div class="boxzeile" role="listitem">
              <div class="boxdaten legende ">Rabatt (netto):</div>
              <div id="BT-147" data-title="BT-147" class="boxdaten wert">
                <xsl:value-of
                  select="format-number(xr:PRICE_DETAILS/xr:Item_price_discount,'###.##0,00','decimal')" />
              </div>
            </div>
            <div class="boxzeile" role="listitem">
              <div class="boxdaten legende ">Listenpreis (netto):</div>
              <div id="BT-148" data-title="BT-148" class="boxdaten wert">
                <xsl:value-of
                  select="format-number(xr:PRICE_DETAILS/xr:Item_gross_price,'###.##0,00','decimal')" />
              </div>
            </div>
            <div class="boxzeile" role="listitem">
              <div class="boxdaten legende ">Anzahl der Einheit:</div>
              <div id="BT-149" data-title="BT-149" class="boxdaten wert">
                <xsl:value-of select="xr:PRICE_DETAILS/xr:Item_price_base_quantity" />
              </div>
            </div>
            <div class="boxzeile" role="listitem">
              <div class="boxdaten legende ">Code der Maßeinheit:</div>
              <div id="BT-150" data-title="BT-150" class="boxdaten wert">
                <xsl:value-of select="xr:PRICE_DETAILS/xr:Item_price_base_quantity_unit_of_measure" />
              </div>
            </div>
            <div class="boxzeile" role="listitem">
              <div class="boxdaten legende ">Umsatzsteuer:</div>
              <div id="BT-151" data-title="BT-151" class="boxdaten wert">
                <xsl:value-of select="xr:LINE_VAT_INFORMATION/xr:Invoiced_item_VAT_category_code" />
              </div>
            </div>
            <div class="boxzeile" role="listitem">
              <div class="boxdaten legende ">Umsatzsteuersatz in Prozent:</div>
              <div id="BT-152" data-title="BT-152" class="boxdaten wert">
                <xsl:value-of
                  select="format-number(xr:LINE_VAT_INFORMATION/xr:Invoiced_item_VAT_rate,'##0,##','decimal')" />
                %
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="boxtabelle">
      <div class="boxzeile">
        <div class="box subBox">
          <div id="BG-27" data-title="BG-27" class="boxtitel boxtitelSub" role="heading" aria-level="3">
            Nachlässe auf Ebene der Rechnungsposition
          </div>
          <xsl:for-each select="xr:INVOICE_LINE_ALLOWANCES">
            <div class="boxtabelle boxinhalt " role="table">
              <div class="rechnungsZeile" role="row">
                <div class="boxdaten detailSp1 color2" role="rowheader">Grundbetrag (netto)</div>
                <div id="BT-137" data-title="BT-137" class="boxdaten detailSp2" role="cell">
                  <xsl:value-of
                    select="format-number(xr:Invoice_line_allowance_base_amount,'###.##0,00','decimal')" />
                </div>
              </div>
              <div class="rechnungsZeile" role="row">
                <div class="boxdaten detailSp1 line1Bottom color2" role="rowheader">Prozentsatz</div>
                <div id="BT-138" data-title="BT-138" class="boxdaten detailSp2 line1Bottom" role="cell">
                  <xsl:value-of
                    select="format-number(xr:Invoice_line_allowance_percentage,'##0,00','decimal')" />
                  %
                </div>
              </div>
              <div class="rechnungsZeile" role="row">
                <div class="boxdaten detailSp1 color2" role="rowheader">Nachlass (netto)</div>
                <div id="BT-136" data-title="BT-136" class="boxdaten detailSp2 bold" role="cell">
                  <xsl:value-of
                    select="format-number(xr:Invoice_line_allowance_amount,'###.##0,00','decimal')" />
                </div>
              </div>
            </div>
            <div class="grundDetail" role="list">
              <div class="color2" role="listitem">
                Grund des Nachlasses:
                <span id="BT-139" data-title="BT-139" class="bold">
                  <xsl:value-of select="xr:Invoice_line_allowance_reason" />
                </span>
              </div>
              <div class="color2" role="listitem">
                Code für den Nachlassgrund:
                <span id="BT-140" data-title="BT-140" class="bold">
                  <xsl:value-of select="xr:Invoice_line_allowance_reason_code" />
                </span>
              </div>
            </div>
          </xsl:for-each>
        </div>
        <div class="box subBox">
          <div id="BG-28" data-title="BG-28" class="boxtitel boxtitelSub" role="heading" aria-level="3">
            Zuschläge auf Ebene der Rechnungsposition
          </div>
          <xsl:for-each select="xr:INVOICE_LINE_CHARGES">
            <div class="boxtabelle boxinhalt " role="table">
              <div class="rechnungsZeile" role="row">
                <div class="boxdaten detailSp1 color2" role="rowheader">Grundbetrag (netto)</div>
                <div id="BT-142" data-title="BT-142" class="boxdaten detailSp2" role="cell">
                  <xsl:value-of
                    select="format-number(xr:Invoice_line_charge_base_amount,'###.##0,00','decimal')" />
                </div>
              </div>
              <div class="rechnungsZeile" role="row">
                <div class="boxdaten detailSp1 line1Bottom color2" role="rowheader">Prozentsatz</div>
                <div id="BT-143" data-title="BT-143" class="boxdaten detailSp2 line1Bottom" role="cell">
                  <xsl:value-of
                    select="format-number(xr:Invoice_line_charge_percentage,'##0,00','decimal')" />
                  %
                </div>
              </div>
              <div class="rechnungsZeile" role="row">
                <div class="boxdaten detailSp1 color2" role="rowheader">Zuschlag (netto)</div>
                <div id="BT-141" data-title="BT-141" class="boxdaten detailSp2 bold" role="cell">
                  <xsl:value-of
                    select="format-number(xr:Invoice_line_charge_amount,'###.##0,00','decimal')" />
                </div>
              </div>
            </div>
            <div class="grundDetail" role="list">
              <div class="color2" role="listitem">
                Grund des Zuschlags:
                <span id="BT-144" data-title="BT-144" class="bold">
                  <xsl:value-of select="xr:Invoice_line_charge_reason" />
                </span>
              </div>
              <div class="color2" role="listitem">
                Code für den Zuschlagsgrund:
                <span id="BT-145" data-title="BT-145" class="bold">
                  <xsl:value-of select="xr:Invoice_line_charge_reason_code" />
                </span>
              </div>
            </div>
          </xsl:for-each>
        </div>
      </div>
    </div>
    <div class="boxtabelle">
      <div class="boxzeile">
        <div class="box subBox">
          <div id="BG-31" data-title="BG-31" class="boxtitel boxtitelSub" role="heading" aria-level="3">
            Artikelinformationen
          </div>
          <div class="boxtabelle boxinhalt ">
            <div class="boxzeile">
              <div class="boxcell boxZweispaltig">
                <div class="boxtabelle borderSpacing" role="list">
                  <div class="boxzeile" role="listitem">
                    <div class="boxdaten legende ">Bezeichnung:</div>
                    <div id="BT-153" data-title="BT-153" class="boxdaten wert bold">
                      <xsl:value-of select="xr:ITEM_INFORMATION/xr:Item_name" />
                    </div>
                  </div>
                  <div class="boxzeile" role="listitem">
                    <div class="boxdaten legende ">Beschreibung:</div>
                    <div id="BT-154" data-title="BT-154" class="boxdaten wert">
                      <xsl:value-of select="xr:ITEM_INFORMATION/xr:Item_description" />
                    </div>
                  </div>
                  <div class="boxzeile" role="listitem">
                    <div class="boxdaten legende ">Artikelnummer:</div>
                    <div id="BT-155" data-title="BT-155" class="boxdaten wert">
                      <xsl:value-of select="xr:ITEM_INFORMATION/xr:Item_Sellers_identifier" />
                    </div>
                  </div>
                  <div class="boxzeile" role="listitem">
                    <div class="boxdaten legende ">Artikelkennung des Käufers:</div>
                    <div id="BT-156" data-title="BT-156" class="boxdaten wert">
                      <xsl:value-of select="xr:ITEM_INFORMATION/xr:Item_Buyers_identifier" />
                    </div>
                  </div>
                  <div class="boxtabelle borderSpacing" role="listitem">
                    <strong id="BG-32" data-title="BG-32">Eigenschaften des Artikels:</strong>
                    <xsl:apply-templates select="xr:ITEM_INFORMATION/xr:ITEM_ATTRIBUTES" />
                  </div>
                </div>
              </div>
              <div class="boxabstand"></div>
              <div class="boxcell boxZweispaltig">
                <div class="boxtabelle borderSpacing" role="list">
                  <div class="boxzeile">
                    <div class="boxdaten legende ">Artikelkennung:</div>
                    <div id="BT-157" data-title="BT-157" class="boxdaten wert">
                      <xsl:value-of select="xr:ITEM_INFORMATION/xr:Item_standard_identifier" />
                    </div>
                  </div>
                  <div class="boxzeile" role="listitem">
                    <div class="boxdaten legende ">Schema der Artikelkennung:</div>
                    <div id="BT-157-scheme-id" data-title="BT-157-scheme-id" class="boxdaten wert">
                      <xsl:value-of
                        select="xr:ITEM_INFORMATION/xr:Item_standard_identifier/@scheme_identifier" />
                    </div>
                  </div>
                  <div class="boxzeile" role="listitem">
                    <div class="boxdaten legende ">Code der Artikelklassifizierung:</div>
                    <div id="BT-158" data-title="BT-158" class="boxdaten wert">
                      <xsl:value-of select="xr:ITEM_INFORMATION/xr:Item_classification_identifier" />
                    </div>
                  </div>
                  <div class="boxzeile" role="listitem">
                    <div class="boxdaten legende ">Kennung zur Bildung des Schemas:</div>
                    <div id="BT-158-scheme-id" data-title="BT-158-scheme-id" class="boxdaten wert">
                      <xsl:value-of
                        select="xr:ITEM_INFORMATION/xr:Item_classification_identifier/@scheme_identifier" />
                    </div>
                  </div>
                  <div class="boxzeile" role="listitem">
                    <div class="boxdaten legende ">Version zur Bildung des Schemas:</div>
                    <div id="BT-158-scheme-version-id" data-title="BT-158-scheme-version-id" class="boxdaten wert">
                      <xsl:value-of
                        select="xr:ITEM_INFORMATION/xr:Item_classification_identifier/@scheme_version_identifier" />
                    </div>
                  </div>
                  <div class="boxzeile" role="listitem">
                    <div class="boxdaten legende ">Code des Herkunftslandes:</div>
                    <div id="BT-159" data-title="BT-159" class="boxdaten wert">
                      <xsl:value-of select="xr:ITEM_INFORMATION/xr:Item_country_of_origin" />
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <xsl:apply-templates select="xr:SUB_INVOICE_LINE" />
  </xsl:template>

  <xsl:template name="eigenschaft" match="xr:ITEM_ATTRIBUTES">
    <div class="boxzeile">
      <div id="BT-160" title="BT-160" class="boxdaten legende ">
        <xsl:value-of select="xr:Item_attribute_name" />
      </div>
      <div id="BT-161" title="BT-161" class="boxdaten wert">
        <xsl:value-of select="xr:Item_attribute_value" />
      </div>
    </div>
  </xsl:template>

  <xsl:template name="sub_invoice_eigenschaft" match="xr:SUB_INVOICE_ITEM_ATTRIBUTES">
    <div class="boxzeile" role="listitem">
      <div id="BT-160" data-title="BT-160" class="boxdaten legende ">
        <xsl:value-of select="xr:Item_attribute_name" />
      </div>
      <div id="BT-161" data-title="BT-161" class="boxdaten wert">
        <xsl:value-of select="xr:Item_attribute_value" />
      </div>
    </div>
  </xsl:template>


  <xsl:template name="zusaetze">
    <div id="zusaetze" class="divHide" role="tabpanel" aria-labelledby="menueZusaetze" tabindex="0">
      <div class="haftungausschluss">Wir übernehmen keine Haftung für die Richtigkeit der Daten.</div>
      <div class="boxtabelle boxtabelleZweispaltig">
        <div class="boxzeile">
          <xsl:apply-templates select="./xr:SELLER" mode="zusaetze" />
          <div class="boxabstand"></div>
          <xsl:apply-templates select="./xr:SELLER_TAX_REPRESENTATIVE_PARTY" />
        </div>
      </div>
      <div class="boxtabelle boxabstandtop boxtabelleZweispaltig">
        <div class="boxzeile">
          <xsl:apply-templates select="./xr:BUYER" mode="zusaetze" />
          <div class="boxabstand"></div>
          <xsl:apply-templates select="./xr:DELIVERY_INFORMATION" />
        </div>
      </div>
      <div class="boxtabelle boxabstandtop boxtabelleZweispaltig">
        <div class="boxzeile">
          <xsl:call-template name="zusaetzeVertrag" />
          <div class="boxabstand"></div>
          <xsl:apply-templates select="./xr:PAYEE" />
        </div>
      </div>
    </div>
  </xsl:template>


  <xsl:template name="zusaetzeVerkaeufer" match="xr:SELLER" mode="zusaetze">
    <div id="zusaetzeVerkaeufer" class="box boxZweispaltig">
      <div id="BG-4" data-title="BG-4" class="boxtitel" role="heading" aria-level="2">Informationen zum
        Verkäufer
      </div>
      <div class="boxtabelle boxinhalt borderSpacing" role="list">
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Abweichender Handelsname:</div>
          <div id="BT-28" data-title="BT-28" class="boxdaten wert">
            <xsl:value-of select="xr:Seller_trading_name" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Bundesland:</div>
          <div id="BT-39" data-title="BT-39" class="boxdaten wert">
            <xsl:value-of select="xr:SELLER_POSTAL_ADDRESS/xr:Seller_country_subdivision" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Elektronische Adresse:</div>
          <div id="BT-34" data-title="BT-34" class="boxdaten wert">
            <xsl:value-of select="xr:Seller_electronic_address" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Schema der elektronischen Adresse:</div>
          <div id="BT-34-scheme-id" data-title="BT-34-scheme-id" class="boxdaten wert">
            <xsl:value-of select="xr:Seller_electronic_address/@scheme_identifier" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Register-/Registriernummer:</div>
          <div id="BT-30" data-title="BT-30" class="boxdaten wert">
            <xsl:value-of select="xr:Seller_legal_registration_identifier" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Umsatzsteuer-ID:</div>
          <div id="BT-31" data-title="BT-31" class="boxdaten wert">
            <xsl:value-of select="xr:Seller_VAT_identifier" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Steuernummer:</div>
          <div id="BT-32" data-title="BT-32" class="boxdaten wert">
            <xsl:value-of select="xr:Seller_tax_registration_identifier" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Schema der Steuernummer:</div>
          <div id="BT-32-scheme" data-title="BT-32-scheme" class="boxdaten wert">
            <xsl:value-of select="xr:Seller_tax_registration_identifier/@scheme_identifier" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Weitere rechtliche Informationen:</div>
          <div id="BT-33" data-title="BT-33" class="boxdaten wert">
            <xsl:value-of select="xr:Seller_additional_legal_information" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Code der Umsatzsteuerwährung:</div>
          <div id="BT-6" data-title="BT-6" class="boxdaten wert">
            <xsl:value-of select="../xr:VAT_accounting_currency_code" />
          </div>
        </div>
      </div>
    </div>
  </xsl:template>


  <xsl:template name="zusaetzeSteuervertreter" match="xr:SELLER_TAX_REPRESENTATIVE_PARTY">
    <div id="zusaetzeSteuervertreter" class="box boxZweispaltig">
      <div id="BG-11" data-title="BG-11" class="boxtitel" role="heading" aria-level="2">Steuervertreter des
        Verkäufers
      </div>
      <div class="boxtabelle boxinhalt borderSpacing" role="list">
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Name:</div>
          <div id="BT-62" data-title="BT-62" class="boxdaten wert">
            <xsl:value-of select="xr:Seller_tax_representative_name" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Straße / Hausnummer:</div>
          <div id="BT-64" data-title="BT-64" class="boxdaten wert">
            <xsl:value-of
              select="xr:SELLER_TAX_REPRESENTATIVE_POSTAL_ADDRESS/xr:Tax_representative_address_line_1" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Postfach:</div>
          <div id="BT-65" data-title="BT-65" class="boxdaten wert">
            <xsl:value-of
              select="xr:SELLER_TAX_REPRESENTATIVE_POSTAL_ADDRESS/xr:Tax_representative_address_line_2" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Adresszusatz:</div>
          <div id="BT-164" data-title="BT-164" class="boxdaten wert">
            <xsl:value-of
              select="xr:SELLER_TAX_REPRESENTATIVE_POSTAL_ADDRESS/xr:Tax_representative_address_line_3" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">PLZ:</div>
          <div id="BT-67" data-title="BT-67" class="boxdaten wert">
            <xsl:value-of
              select="xr:SELLER_TAX_REPRESENTATIVE_POSTAL_ADDRESS/xr:Tax_representative_post_code" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Ort:</div>
          <div id="BT-66" data-title="BT-66" class="boxdaten wert">
            <xsl:value-of select="xr:SELLER_TAX_REPRESENTATIVE_POSTAL_ADDRESS/xr:Tax_representative_city" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Bundesland:</div>
          <div id="BT-68" data-title="BT-68" class="boxdaten wert">
            <xsl:value-of
              select="xr:SELLER_TAX_REPRESENTATIVE_POSTAL_ADDRESS/xr:Tax_representative_country_subdivision" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Ländercode:</div>
          <div id="BT-69" data-title="BT-69" class="boxdaten wert">
            <xsl:value-of
              select="xr:SELLER_TAX_REPRESENTATIVE_POSTAL_ADDRESS/xr:Tax_representative_country_code" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Umsatzsteuer-ID:</div>
          <div id="BT-63" data-title="BT-63" class="boxdaten wert">
            <xsl:value-of select="xr:Seller_tax_representative_VAT_identifier" />
          </div>
        </div>
      </div>
    </div>
  </xsl:template>


  <xsl:template name="zusaetzeKaeufer" match="xr:BUYER" mode="zusaetze">
    <div id="zusaetzeKaeufer" class="box boxZweispaltig">
      <div id="BG-7" data-title="BG-7" class="boxtitel" role="heading" aria-level="2">Informationen zum Käufer
      </div>
      <div class="boxtabelle boxinhalt borderSpacing" role="list">
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Abweichender Handelsname:</div>
          <div id="BT-45" data-title="BT-45" class="boxdaten wert">
            <xsl:value-of select="xr:Buyer_trading_name" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Bundesland:</div>
          <div id="BT-54" data-title="BT-54" class="boxdaten wert">
            <xsl:value-of select="xr:BUYER_POSTAL_ADDRESS/xr:Buyer_country_subdivision" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Elektronische Adresse:</div>
          <div id="BT-49" data-title="BT-49" class="boxdaten wert">
            <xsl:value-of select="xr:Buyer_electronic_address" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Schema der elektronischen Adresse:</div>
          <div id="BT-49-scheme-id" data-title="BT-49-scheme-id" class="boxdaten wert">
            <xsl:value-of select="xr:Buyer_electronic_address/@scheme_identifier" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Register-/Registriernummer:</div>
          <div id="BT-47" data-title="BT-47" class="boxdaten wert">
            <xsl:value-of select="xr:Buyer_legal_registration_identifier" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Schema der Register-/Registriernummer:</div>
          <div id="BT-47-scheme-id" data-title="BT-47-scheme-id" class="boxdaten wert">
            <xsl:value-of select="xr:Buyer_legal_registration_identifier/@scheme_identifier" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Umsatzsteuer-ID:</div>
          <div id="BT-48" data-title="BT-48" class="boxdaten wert">
            <xsl:value-of select="xr:Buyer_VAT_identifier" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Kontierungsinformation:</div>
          <div id="BT-19" data-title="BT-19" class="boxdaten wert">
            <xsl:value-of select="../xr:Buyer_accounting_reference" />
          </div>
        </div>
      </div>
    </div>
  </xsl:template>


  <xsl:template name="zusaetzeLieferung" match="xr:DELIVERY_INFORMATION">
    <div id="zusaetzeLieferung" class="box boxZweispaltig">
      <div id="BG-13" data-title="BG-13" class="boxtitel" role="heading" aria-level="2">Lieferinformationen</div>
      <div class="boxtabelle boxinhalt borderSpacing" role="list">
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Kennung des Lieferorts:</div>
          <div id="BT-71" data-title="BT-71" class="boxdaten wert">
            <xsl:value-of select="xr:Deliver_to_location_identifier" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Schema der Kennung:</div>
          <div id="BT-71-scheme-id" data-title="BT-71-scheme-id" class="boxdaten wert">
            <xsl:value-of select="xr:Deliver_to_location_identifier/@scheme_identifier" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Lieferdatum:</div>
          <div id="BT-72" data-title="BT-72" class="boxdaten wert">
            <xsl:value-of select="format-date(xr:Actual_delivery_date,'[D].[M].[Y]')" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Name des Empfängers:</div>
          <div id="BT-70" data-title="BT-70" class="boxdaten wert">
            <xsl:value-of select="xr:Deliver_to_party_name" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Straße / Hausnummer:</div>
          <div id="BT-75" data-title="BT-75" class="boxdaten wert">
            <xsl:value-of select="xr:DELIVER_TO_ADDRESS/xr:Deliver_to_address_line_1" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Postfach:</div>
          <div id="BT-76" data-title="BT-76" class="boxdaten wert">
            <xsl:value-of select="xr:DELIVER_TO_ADDRESS/xr:Deliver_to_address_line_2" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Adresszusatz:</div>
          <div data-title="BT-165" class="boxdaten wert">
            <xsl:value-of select="xr:DELIVER_TO_ADDRESS/xr:Deliver_to_address_line_3" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">PLZ:</div>
          <div id="BT-78" data-itle="BT-78" class="boxdaten wert">
            <xsl:value-of select="xr:DELIVER_TO_ADDRESS/xr:Deliver_to_post_code" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Ort:</div>
          <div id="BT-77" data-title="BT-77" class="boxdaten wert">
            <xsl:value-of select="xr:DELIVER_TO_ADDRESS/xr:Deliver_to_city" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Bundesland:</div>
          <div id="BT-79" data-title="BT-79" class="boxdaten wert">
            <xsl:value-of select="xr:DELIVER_TO_ADDRESS/xr:Deliver_to_country_subdivision" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Land:</div>
          <div id="BT-80" data-title="BT-80" class="boxdaten wert">
            <xsl:value-of select="xr:DELIVER_TO_ADDRESS/xr:Deliver_to_country_code" />
          </div>
        </div>
      </div>
    </div>
  </xsl:template>


  <xsl:template name="zusaetzeVertrag">
    <div id="zusaetzeVertrag" class="box boxZweispaltig">
      <div class="boxtitel" role="heading" aria-level="2">Informationen zum Vertrag</div>
      <div class="boxtabelle boxinhalt borderSpacing" role="list">
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Vergabenummer:</div>
          <div id="BT-17" data-title="BT-17" class="boxdaten wert">
            <xsl:value-of select="xr:Tender_or_lot_reference" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Kennung der Empfangsbestätigung:</div>
          <div id="BT-15" data-title="BT-15" class="boxdaten wert">
            <xsl:value-of select="xr:Receiving_advice_reference" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Kennung der Versandanzeige:</div>
          <div id="BT-16" data-title="BT-16" class="boxdaten wert">
            <xsl:value-of select="xr:Despatch_advice_reference" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Prozesskennung:</div>
          <div id="BT-23" data-title="BT-23" class="boxdaten wert">
            <xsl:value-of select="xr:PROCESS_CONTROL/xr:Business_process_type_identifier" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Spezifikationskennung:</div>
          <div id="BT-24" data-title="BT-24" class="boxdaten wert">
            <xsl:value-of select="xr:PROCESS_CONTROL/xr:Specification_identifier" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Objektkennung:</div>
          <div id="BT-18" data-title="BT-18" class="boxdaten wert">
            <xsl:value-of select="xr:Invoiced_object_identifier" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Schema der Objektkennung:</div>
          <div id="BT-18-scheme-id" data-title="BT-18-scheme-id" class="boxdaten wert">
            <xsl:value-of select="xr:Invoiced_object_identifier/@scheme_identifier" />
          </div>
        </div>
      </div>
    </div>
  </xsl:template>


  <xsl:template name="zusaetzeZahlungsempfaenger" match="xr:PAYEE">
    <div id="zusaetzeZahlungsempfaenger" class="box boxZweispaltig">
      <div id="BG-10" data-title="BG-10" class="boxtitel" role="heading" aria-level="2">Vom Verkäufer abweichender
        Zahlungsempfänger
      </div>
      <div class="boxtabelle boxinhalt borderSpacing" role="list">
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Name:</div>
          <div id="BT-59" data-title="BT-59" class="boxdaten wert">
            <xsl:value-of select="xr:Payee_name" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Kennung:</div>
          <div id="BT-60" data-title="BT-60" class="boxdaten wert">
            <xsl:value-of select="xr:Payee_identifier" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Schema der Kennung:</div>
          <div id="BT-60-scheme-id" data-title="BT-60-scheme-id" class="boxdaten wert">
            <xsl:value-of select="xr:Payee_identifier/@scheme_identifier" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Register-/Registriernummer:</div>
          <div id="BT-61" data-title="BT-61" class="boxdaten wert">
            <xsl:value-of select="xr:Payee_legal_registration_identifier" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">Schema der Register-/Registriernummer:</div>
          <div id="BT-61-scheme-id" data-title="BT-61-scheme-id" class="boxdaten wert">
            <xsl:value-of select="xr:Payee_legal_registration_identifier/@scheme_identifier" />
          </div>
        </div>
      </div>
    </div>
  </xsl:template>


  <xsl:template name="anlagen">
    <div id="anlagen" class="divHide" role="tabpanel" aria-labelledby="menueAnlagen" tabindex="0">
      <div class="haftungausschluss">Wir übernehmen keine Haftung für die Richtigkeit der Daten.</div>
      <div class="boxtabelle boxabstandtop">
        <div class="boxzeile">
          <div id="anlagenListe" class="box">
            <div id="BG-24" data-title="BG-24" class="boxtitel" role="heading" aria-level="2">
              Rechnungsbegründende Unterlagen
            </div>
            <xsl:apply-templates select="./xr:ADDITIONAL_SUPPORTING_DOCUMENTS" />
          </div>
        </div>
      </div>
    </div>
  </xsl:template>


  <xsl:template match="xr:ADDITIONAL_SUPPORTING_DOCUMENTS">
    <div class="boxtabelle boxinhalt borderSpacing" role="list">
      <div class="boxzeile" role="listitem">
        <div class="boxdaten legende">Kennung:</div>
        <div id="BT-122" data-title="BT-122" class="boxdaten wert">
          <xsl:value-of select="xr:Supporting_document_reference" />
        </div>
      </div>
      <div class="boxzeile" role="listitem">
        <div class="boxdaten legende">Beschreibung:</div>
        <div id="BT-123" data-title="BT-123" class="boxdaten wert">
          <xsl:value-of select="xr:Supporting_document_description" />
        </div>
      </div>
      <div class="boxzeile" role="listitem">
        <div class="boxdaten legende">Verweis (z.B. Internetadresse):</div>
        <div id="BT-124" data-title="BT-124" class="boxdaten wert">
          <a href="{xr:External_document_location}" target="_blank">
            <xsl:value-of select="xr:External_document_location" />
          </a>
        </div>
      </div>
      <div class="boxzeile" role="listitem">
        <div class="boxdaten legende">Anhangsdokument:</div>
        <div id="BT-125" data-title="BT-125" class="boxdaten wert">
          <a href="#" onClick="downloadData('{xr:Supporting_document_reference}')">Öffnen
          </a>
        </div>
        <div id="{xr:Supporting_document_reference}" data-mimetype="{xr:Attached_document/@mime_code}"
          data-filename="{xr:Attached_document/@filename}" style="display:none;">
          <xsl:value-of select="xr:Attached_document" />
        </div>

      </div>
      <div class="boxzeile" role="listitem">
        <div class="boxdaten legende">Format des Anhangdokuments:</div>
        <div id="BT-125" data-title="BT-125" class="boxdaten wert">
          <xsl:value-of select="xr:Attached_document/@mime_code" />
        </div>
      </div>
      <div class="boxzeile" role="listitem">
        <div class="boxdaten legende">Name des Anhangsdokuments:</div>
        <div id="BT-125" data-title="BT-125" class="boxdaten wert">
          <xsl:value-of select="xr:Attached_document/@filename" />
        </div>
      </div>
    </div>
  </xsl:template>


  <xsl:template name="laufzettel">
    <div id="laufzettel" class="divHide" role="tabpanel" aria-labelledby="menueLaufzettel" tabindex="0">
      <div class="boxtabelle boxabstandtop">
        <div class="boxzeile">
          <div id="laufzettelHistorie" class="box">
            <div class="boxtitel" role="heading" aria-level="2">Bearbeitungshistorie</div>
            <xsl:apply-templates select="./xrv:laufzettel/xrv:laufzettelEintrag" />
          </div>
        </div>
      </div>
    </div>
  </xsl:template>


  <xsl:template match="xrv:laufzettelEintrag">
    <div class="boxtabelle boxinhalt borderSpacing" role="list">
      <div class="boxzeile" role="listitem">
        <div class="boxdaten legende">Datum/Uhrzeit:</div>
        <div class="boxdaten wert">
          <xsl:value-of select="format-dateTime(xrv:zeitstempel,'[D].[M].[Y] [H]:[m]:[s]')" />
        </div>
      </div>
      <div class="boxzeile" role="listitem">
        <div class="boxdaten legende">Betreff:</div>
        <div class="boxdaten wert">
          <xsl:value-of select="xrv:betreff" />
        </div>
      </div>
      <div class="boxzeile" role="listitem">
        <div class="boxdaten legende">Text:</div>
        <div class="boxdaten wert">
          <xsl:value-of select="xrv:text" />
        </div>
      </div>
      <div class="boxzeile" role="listitem">
        <div class="boxdaten legende">Details:</div>
        <div class="boxdaten wert">
          <xsl:value-of select="xrv:details" />
        </div>
      </div>
    </div>
  </xsl:template>

</xsl:stylesheet>
