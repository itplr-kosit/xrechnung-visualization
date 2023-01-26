<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" 
  xmlns:xr="urn:ce.eu:en16931:2017:xoev-de:kosit:standard:xrechnung-1"
  xmlns:xrf="https://projekte.kosit.org/xrechnung/xrechnung-visualization/functions"
  xmlns:xrv="http://www.example.org/XRechnung-Viewer" exclude-result-prefixes="#all">

    <xsl:output indent="yes" method="html" encoding="UTF-8" include-content-type="no" media-type="text/html" undeclare-prefixes="yes"/>

  <xsl:import href="common-xr.xsl" />

  <xsl:param name="l10n-nl-lookup" select="true()" />

  <xsl:decimal-format name="de" decimal-separator="," grouping-separator="." NaN="" />
  <xsl:decimal-format name="en" decimal-separator="." grouping-separator="," NaN="" />

    <!-- MAIN HTML -->
  <xsl:template match="/xr:invoice">
     <!-- <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>-->
    <html lang="{$lang}">
      <head>
        <meta charset="UTF-8" />
        <title>XRechnung</title>
        <meta name="viewport" content="width=device-width, user-scalable=yes, initial-scale=1.0" />
        <style>
          <xsl:value-of select="unparsed-text('xrechnung-viewer.css')" />
        </style>
        <script>
          <xsl:value-of select="unparsed-text('FileSaver-v2.0.5.js')" />
        </script>
        <!-- according to https://stackoverflow.com/questions/436411/where-should-i-put-script-tags-in-html-markup -->
        <script>
          <xsl:value-of select="unparsed-text('xrechnung-viewer.js')" />
        </script>
      </head>
      <body>
        <div role="main">
          <form>
            <div class="menue" role="navigation">
              <div role="tablist" class="innen">
                <div role="none">
                  <button role="tab" aria-controls="uebersicht" tabindex="0" aria-selected="true" type="button"
                    class="tab btnAktiv" id="menueUebersicht" onclick="show(this);">
                    <span><xsl:value-of select="xrf:_('uebersicht')" /></span>
                  </button>
                </div>
                <div role="none">
                  <button role="tab" aria-controls="details" tabindex="0" aria-selected="false" type="button"
                    class="tab" id="menueDetails" onclick="show(this);">
                    <span><xsl:value-of select="xrf:_('details')" /></span>
                  </button>
                </div>
                <div role="none">
                  <button role="tab" aria-controls="zusaetze" tabindex="0" aria-selected="false" type="button"
                    class="tab" id="menueZusaetze" onclick="show(this)">
                    <span><xsl:value-of select="xrf:_('zusaetze')" /></span>
                  </button>
                </div>
                <div role="none">
                  <button role="tab" aria-controls="anlagen" tabindex="0" aria-selected="false" type="button"
                    class="tab" id="menueAnlagen" onclick="show(this)">
                    <span><xsl:value-of select="xrf:_('anlagen')" /></span>
                  </button>
                </div>
                <div role="none">
                  <button role="tab" aria-controls="laufzettel" tabindex="0" aria-selected="false" type="button"
                    class="tab" id="menueLaufzettel" onclick="show(this)">
                    <span><xsl:value-of select="xrf:_('laufzettel')" /></span>
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
    </html>
  </xsl:template>


  <xsl:template name="uebersicht">
    <div id="uebersicht" class="divShow" role="tabpanel" aria-labelledby="menueUebersicht" tabindex="0">
      <div class="haftungausschluss">
        <xsl:value-of select="xrf:_('_disclaimer')" />
      </div>
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
      <div class="BG-7 boxtitel" role="heading" aria-level="2">        
        <xsl:attribute name="data-title">BG-7&#013;&#010;BUYER&#013;&#010;Eine Gruppe von Informationselementen, die Informationen über den Erwerber enthalten.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
        <xsl:value-of select="xrf:_('uebersichtKaeufer')" />
      </div>
      <div class="boxtabelle boxinhalt borderSpacing" role="list">
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Buyer_reference')" />:
          </div>
          <div class="BT-10 boxdaten wert">
            <xsl:attribute name="data-title">BT-10&#013;&#010;Buyer reference&#013;&#010;Ein vom Erwerber zugewiesener und für interne Lenkungszwecke benutzter Bezeichner.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="../xr:Buyer_reference" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Buyer_name')" />:
          </div>
          <div class="BT-44 boxdaten wert">
            <xsl:attribute name="data-title">BT-44&#013;&#010;Buyer name&#013;&#010;Der vollständige Name des Erwerbers.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:Buyer_name" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Buyer_address_line_1')" />:
          </div>
          <div class="BT-50 boxdaten wert">
            <xsl:attribute name="data-title">BT-50&#013;&#010;Buyer address line 1YER&#013;&#010;Die Hauptzeile einer Anschrift. Üblicherweise ist dies entweder Strasse und Hausnummer oder der Text "Postfach" gefolgt von der Postfachnummer. &#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:BUYER_POSTAL_ADDRESS/xr:Buyer_address_line_1" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Buyer_address_line_2')" />:
          </div>
          <div class="BT-51 boxdaten wert">
            <xsl:attribute name="data-title">BT-51&#013;&#010;Buyer address line 2&#013;&#010;Eine zusätzliche Adresszeile in einer Anschrift, die verwendet werden kann, um weitere Einzelheiten in Ergänzung zur Hauptzeile anzugeben.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:BUYER_POSTAL_ADDRESS/xr:Buyer_address_line_2" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Buyer_address_line_3')" />:
          </div>
          <div class="BT-163 boxdaten wert">
            <xsl:attribute name="data-title">BT-163&#013;&#010;Buyer address line 3&#013;&#010;Eine zusätzliche Adresszeile in einer Anschrift, die verwendet werden kann, um weitere Einzelheiten in Ergänzung zur Hauptzeile anzugeben.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:BUYER_POSTAL_ADDRESS/xr:Buyer_address_line_3" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Buyer_post_code')" />:
          </div>
          <div class="BT-53 boxdaten wert">
            <xsl:attribute name="data-title">BT-53&#013;&#010;Buyer post code&#013;&#010;Die Postleitzahl.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:BUYER_POSTAL_ADDRESS/xr:Buyer_post_code" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Buyer_city')" />:
          </div>
          <div class="BT-52 boxdaten wert">
            <xsl:attribute name="data-title">BT-52&#013;&#010;Buyer city&#013;&#010;Die Bezeichnung der Stadt oder Gemeinde, in der sich die Erwerberanschrift
        befindet.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:BUYER_POSTAL_ADDRESS/xr:Buyer_city" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Buyer_country_subdivision')" />:
          </div>
          <div class="BT-54 boxdaten wert">
            <xsl:attribute name="data-title">BT-54&#013;&#010;Buyer country subdivision&#013;&#010;Die Unterteilung eines Landes (wie Region, Bundesland, Provinz
        etc.).&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:BUYER_POSTAL_ADDRESS/xr:Buyer_country_subdivision" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Buyer_country_code')" />:
          </div>
          <div class="BT-55 boxdaten wert">
            <xsl:attribute name="data-title">BT-55&#013;&#010;Buyer country code&#013;&#010;Ein Code, mit dem das Land bezeichnet wird.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:BUYER_POSTAL_ADDRESS/xr:Buyer_country_code" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Buyer_identifier')" />:
          </div>
          <div class="BT-46 boxdaten wert">
            <xsl:attribute name="data-title">BT-46&#013;&#010;Buyer identifier&#013;&#010;Eine (i. d. R. vom Verkäufer vergebene) Kennung des Erwerbers, wie z. B. die
                Debitorennummer für die Buchhaltung oder die Kundennnummer für die Auftragsverwaltung.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:Buyer_identifier" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Buyer_identifier/@scheme_identifier')" />:
          </div>
          <div data-title="BT-46-scheme-id" class="BT-46-scheme-id boxdaten wert">
            <xsl:attribute name="data-title">scheme-id-bt-46&#013;&#010;Buyer identifier/Scheme identifier&#013;&#010;Die Kennung des Bildungsschemas für BT-46.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:Buyer_identifier/@scheme_identifier" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Buyer_contact_point')" />:
          </div>
          <div class="BT-56 boxdaten wert">
            <xsl:attribute name="data-title">BT-56&#013;&#010;Buyer contact point&#013;&#010;Ansprechpartner oder Kontaktstelle beim Erwerber (wie z. B. Name einer Person,
        Abteilungs- oder Bürobezeichnung).&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:BUYER_CONTACT/xr:Buyer_contact_point" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Buyer_contact_telephone_number')" />:
          </div>
          <div class="BT-57 boxdaten wert">
            <xsl:attribute name="data-title">BT-57&#013;&#010;Buyer contact telephone number&#013;&#010;Eine Telefonnummer der Kontaktstelle.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:BUYER_CONTACT/xr:Buyer_contact_telephone_number" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Buyer_contact_email_address')" />:
          </div>
          <div class="BT-58 boxdaten wert">
            <xsl:attribute name="data-title">BT-58&#013;&#010;Buyer contact email address&#013;&#010;Eine E-Mail-Adresse der Kontaktstelle.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:BUYER_CONTACT/xr:Buyer_contact_email_address" />
          </div>
        </div>
      </div>
    </div>
  </xsl:template>


  <xsl:template name="uebersichtVerkaeufer" match="xr:SELLER">
    <div id="uebersichtVerkaeufer" class="box boxZweispaltig">
      <div class="BG-4 boxtitel" role="heading" aria-level="2">
        <xsl:attribute name="data-title">BG-4&#013;&#010;SELLER&#013;&#010;Eine Gruppe von Informationselementen, die Informationen über den Verkäufer
        enthalten.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
        <xsl:value-of select="xrf:_('uebersichtVerkaeufer')" />
      </div>
      <div class="boxtabelle boxinhalt borderSpacing" role="list">
        <div class="boxzeile">
          <div class="boxdaten legende"></div>
          <div class="boxdaten wert" style="background-color: white;"></div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Seller_name')" />:
          </div>
          <div class="BT-27 boxdaten wert">
            <xsl:attribute name="data-title">BT-27&#013;&#010;Seller name&#013;&#010;Eine Gruppe von Informationselementen, die Informationen über den Verkäufer
        enthalten.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:Seller_name" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Seller_address_line_1')" />:
          </div>
          <div class="BT-35 boxdaten wert">
            <xsl:attribute name="data-title">BT-35&#013;&#010;Seller address line 1&#013;&#010;Die Hauptzeile in einer Anschrift. Üblicherweise ist dies entweder Strasse und
                Hausnummer oder der Text Postfach gefolgt von der Postfachnummer.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:SELLER_POSTAL_ADDRESS/xr:Seller_address_line_1" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Seller_address_line_2')" />:
          </div>
          <div class="BT-36 boxdaten wert">
            <xsl:attribute name="data-title">BT-36&#013;&#010;Seller address line 2&#013;&#010;Eine zusätzliche Adresszeile in einer Anschrift, die verwendet werden kann, um
        weitere Einzelheiten in Ergänzung zur Hauptzeile anzugeben.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:SELLER_POSTAL_ADDRESS/xr:Seller_address_line_2" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Seller_address_line_3')" />:
          </div>
          <div class="BT-162 boxdaten wert">
            <xsl:attribute name="data-title">BT-162&#013;&#010;Seller address line 3&#013;&#010;Eine zusätzliche Adresszeile in einer Anschrift, die verwendet werden kann, um
        weitere Einzelheiten in Ergänzung zur Hauptzeile anzugeben.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:SELLER_POSTAL_ADDRESS/xr:Seller_address_line_3" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Seller_post_code')" />:
          </div>
          <div class="BT-38 boxdaten wert">
            <xsl:attribute name="data-title">BT-38&#013;&#010;Seller post code&#013;&#010;Die Postleitzahl.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:SELLER_POSTAL_ADDRESS/xr:Seller_post_code" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Seller_city')" />:
          </div>
          <div class="BT-37 boxdaten wert">
            <xsl:attribute name="data-title">BT-37&#013;&#010;Seller city&#013;&#010;Die Bezeichnung der Stadt oder Gemeinde, in der sich die Verkäuferanschrift
        befindet.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:SELLER_POSTAL_ADDRESS/xr:Seller_city" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Seller_country_subdivision')" />:
          </div>
          <div class="BT-39 boxdaten wert">
            <xsl:attribute name="data-title">BT-39&#013;&#010;Seller country subdivision&#013;&#010;Die Unterteilung eines Landes (wie Region, Bundesland, Provinz
        etc.).&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:SELLER_POSTAL_ADDRESS/xr:Seller_country_subdivision" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Seller_country_code')" />:
          </div>
          <div class="BT-40 boxdaten wert">
           <xsl:attribute name="data-title">BT-40&#013;&#010;Seller country code&#013;&#010;Ein Code, mit dem das Land bezeichnet wird.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:SELLER_POSTAL_ADDRESS/xr:Seller_country_code" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Seller_identifier')" />:
          </div>
          <div class="BT-29 boxdaten wert">
            <xsl:attribute name="data-title">BT-29&#013;&#010;Seller identifier&#013;&#010;Eine (i. d. R. vom Erwerber vergebene) Kennung des Verkäufers, wie z. B. die
        Kreditorennummer für das Mittelbewirtschaftungsverfahren oder die Lieferantennummer für das
        Bestellsystem.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:Seller_identifier" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Seller_identifier/@scheme_identifier')" />:
          </div>
          <div data-title="BT-29-scheme-id" class="BT-29-scheme-id boxdaten wert">
            <xsl:attribute name="data-title">scheme-id-bt-29&#013;&#010;Seller identifier/Scheme identifier&#013;&#010;Kennung des Bildungsschemas für das Element BT-29.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:Seller_identifier/@scheme_identifier" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Seller_contact_point')" />:
          </div>
          <div class="BT-41 boxdaten wert">
            <xsl:attribute name="data-title">BT-41&#013;&#010;Seller contact point&#013;&#010;Angaben zu Ansprechpartner oder Kontaktstelle (wie z. B. Name einer Person,
        Abteilungs- oder Bürobezeichnung).&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:SELLER_CONTACT/xr:Seller_contact_point" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Seller_contact_telephone_number')" />:
          </div>
          <div class="BT-42 boxdaten wert">
            <xsl:attribute name="data-title">BT-42&#013;&#010;Seller contact telephone number&#013;&#010;Telefonnummer des Ansprechpartners oder der Kontaktstelle&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:SELLER_CONTACT/xr:Seller_contact_telephone_number" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Seller_contact_email_address')" />:
          </div>
          <div class="BT-43 boxdaten wert">
            <xsl:attribute name="data-title">BT-43&#013;&#010;Seller contact email address&#013;&#010;Eine E-Mail-Adresse des Ansprechpartners oder der
        Kontaktstelle.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:SELLER_CONTACT/xr:Seller_contact_email_address" />
          </div>
        </div>
      </div>
    </div>
  </xsl:template>


  <xsl:template name="uebersichtRechnungsinfo">
    <div class="boxzeile">
      <div id="uebersichtRechnungsinfo" class="box box1v2">
        <div class="boxtitel" role="heading" aria-level="2">
          <xsl:value-of select="xrf:_('uebersichtRechnungsInfo')" />
        </div>
        <div class="boxtabelle boxinhalt">
          <div class="boxcell boxZweispaltig">
            <div class="boxtabelle borderSpacing" role="list">
              <div class="boxzeile" role="listitem">
                <div class="boxdaten legende">
                  <xsl:value-of select="xrf:_('xr:Invoice_number')" />:
                </div>
                <div class="BT-1 boxdaten wert">
                  <xsl:attribute name="data-title">BT-1&#013;&#010;Invoice number&#013;&#010;Eine eindeutige Kennung der Rechnung, die diese im System des Verkäufers
                identifiziert.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                  <xsl:value-of select="xr:Invoice_number" />
                </div>
              </div>
              <div class="boxzeile" role="listitem">
                <div class="boxdaten legende">
                  <xsl:value-of select="xrf:_('xr:Invoice_issue_date')" />:
                </div>
                <div class="BT-2 boxdaten wert">
                  <xsl:attribute name="data-title">BT-2&#013;&#010;Invoice issue date&#013;&#010;Das Datum, an dem die Rechnung ausgestellt wurde.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                  <xsl:value-of select="
                    if (matches(
                    normalize-space(
                    replace(xr:Invoice_issue_date, '-', '')
                    ),
                    $datepattern)
                    )
                    then
                    format-date(xr:Invoice_issue_date, xrf:_('date-format'))
                    else
                    xr:Invoice_issue_date"
                  />
                </div>
              </div>
              <div class="boxzeile" role="listitem">
                <div class="boxdaten legende">
                  <xsl:value-of select="xrf:_('xr:Invoice_type_code')" />:
                </div>
                <div class="BT-3 boxdaten wert">
                  <xsl:attribute name="data-title">BT-3&#013;&#010;Invoice type code&#013;&#010;Ein Code, der den Funktionstyp der Rechnung angibt.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                  <xsl:value-of select="xr:Invoice_type_code" />
                </div>
              </div>
              <div class="boxzeile" role="listitem">
                <div class="boxdaten legende">
                  <xsl:value-of select="xrf:_('xr:Invoice_currency_code')"
                  />:
                </div>
                <div class="BT-5 boxdaten wert">
                  <xsl:attribute name="data-title">BT-5&#013;&#010;Invoice currency code&#013;&#010;Die Währung, in der alle Rechnungsbeträge angegeben werden, ausgenommen ist der
                Umsatzsteuer-Gesamtbetrag, der in der Abrechnungswährung anzugeben ist.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                  <xsl:value-of select="xr:Invoice_currency_code" />
                </div>
              </div>
              <div class="boxzeile" role="listitem">
                <div class="boxdaten legende">
                  <xsl:value-of select="xrf:_('xr:Value_added_tax_point_date')"
                  />:
                </div>
                <div class="BT-7 boxdaten wert">
                  <xsl:attribute name="data-title">BT-7&#013;&#010;Value added tax point date&#013;&#010;Das Datum, zu dem die Umsatzsteuer für den Verkäufer und für den Erwerber
                abrechnungsrelevant wird. Die Anwendung von BT-7 und BT-8 schließen sich gegenseitig aus.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                  <xsl:for-each
                    select="tokenize(xr:Value_added_tax_point_date, ';')">
                    <xsl:value-of
                      select="format-date(xs:date(.), xrf:_('date-format'))" />
                    <xsl:if test="position() != last()">
                      <br />
                    </xsl:if>
                  </xsl:for-each>
                </div>
              </div>
              <div class="boxzeile" role="listitem">
                <div class="boxdaten legende">
                  <xsl:value-of
                    select="xrf:_('xr:Value_added_tax_point_date_code')"
                  />:
                </div>
                <div class="BT-8 boxdaten wert">
                  <xsl:attribute name="data-title">BT-8&#013;&#010;Value added tax point date code&#013;&#010;Ein Code für den Zeitpunkt, an dem die Umsatzsteuer für den Erwerber und den
                Verkäufer in der Buchführung nachzuweisen ist.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                  <xsl:value-of select="xr:Value_added_tax_point_date_code" />
                </div>
              </div>
              <div role="listitem">
                <strong>
                  <xsl:value-of
                    select="xrf:_('uebersichtRechnungAbrechnungszeitraum')"
                  />:
                </strong>
                <div class="boxtabelle borderSpacing" role="list">
                  <div class="boxzeile" role="listitem">
                    <div class="boxdaten legende">
                      <xsl:value-of
                        select="xrf:_('xr:Invoicing_period_start_date')"
                      />:
                    </div>
                    <div class="BT-73 boxdaten wert">
                      <xsl:attribute name="data-title">BT-73&#013;&#010;Invoicing period start date&#013;&#010;Das Datum, an dem der Abrechnungszeitraum beginnt.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                      <xsl:value-of
                        select="format-date(xr:DELIVERY_INFORMATION/xr:INVOICING_PERIOD/xr:Invoicing_period_start_date, xrf:_('date-format'))"
                      />
                    </div>
                  </div>
                  <div class="boxzeile" role="listitem">
                    <div class="boxdaten legende">
                      <xsl:value-of
                        select="xrf:_('xr:Invoicing_period_end_date')"
                      />:
                    </div>
                    <div class="BT-74 boxdaten wert">
                      <xsl:attribute name="data-title">BT-74&#013;&#010;Invoicing period start date&#013;&#010;Das Datum, an dem der Abrechnungszeitraum beginnt.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                      <xsl:value-of
                        select="format-date(xr:DELIVERY_INFORMATION/xr:INVOICING_PERIOD/xr:Invoicing_period_end_date, xrf:_('date-format'))"
                      />
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="boxabstand" />
          <div class="boxcell boxZweispaltig">
            <div class="boxtabelle borderSpacing" role="list">
              <div class="boxzeile" role="listitem">
                <div class="boxdaten legende">
                  <xsl:value-of select="xrf:_('xr:Project_reference')" />:
                </div>
                <div class="BT-11 boxdaten wert">
                  <xsl:attribute name="data-title">BT-11&#013;&#010;Project reference&#013;&#010;Die Kennung eines Projektes, auf das sich die Rechnung bezieht.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                  <xsl:value-of select="xr:Project_reference" />
                </div>
              </div>
              <div class="boxzeile" role="listitem">
                <div class="boxdaten legende">
                  <xsl:value-of select="xrf:_('xr:Contract_reference')" />:
                </div>
                <div class="BT-12 boxdaten wert">
                  <xsl:attribute name="data-title">BT-12&#013;&#010;Contract reference&#013;&#010;Die Kennung eines Projektes, auf das sich die Rechnung bezieht.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                  <xsl:value-of select="xr:Contract_reference" />
                </div>
              </div>
              <div class="boxzeile" role="listitem">
                <div class="boxdaten legende">
                  <xsl:value-of select="xrf:_('xr:Purchase_order_reference')"
                  />:
                </div>
                <div class="BT-13 boxdaten wert">
                  <xsl:attribute name="data-title">BT-13&#013;&#010;Purchase order reference&#013;&#010;Eine vom Erwerber ausgegebene Kennung für eine referenzierte
        Bestellung.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                  <xsl:value-of select="xr:Purchase_order_reference" />
                </div>
              </div>
              <div class="boxzeile" role="listitem">
                <div class="boxdaten legende">
                  <xsl:value-of select="xrf:_('xr:Sales_order_reference')"
                  />:
                </div>
                <div class="BT-14 boxdaten wert">
                  <xsl:attribute name="data-title">BT-14&#013;&#010;Sales order reference&#013;&#010;Eine vom Verkäufer ausgegebene Kennung für einen referenzierten
        Auftrag.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                  <xsl:value-of select="xr:Sales_order_reference" />
                </div>
              </div>
            </div>
            <xsl:apply-templates select="./xr:PRECEDING_INVOICE_REFERENCE" />
          </div>
        </div>
      </div>
    </div>
  </xsl:template>
  

  <xsl:template match="xr:PRECEDING_INVOICE_REFERENCE">
    <div role="list">
      <strong>
        <xsl:value-of select="xrf:_('uebersichtRechnungVorausgegangeneRechnungen')" />:
      </strong>
      <div class="boxtabelle borderSpacing" role="list">
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Preceding_Invoice_reference')" />:
          </div>
          <div class="BT-25 boxdaten wert">
            <xsl:attribute name="data-title">BT-25&#013;&#010;Preceding Invoice reference&#013;&#010;Die Kennung der vorausgegangenen Rechnung, auf die Bezug genommen
        wird.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:Preceding_Invoice_reference" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Preceding_Invoice_issue_date')" />:
          </div>
          <div class="BT-26 boxdaten wert">
            <xsl:attribute name="data-title">BT-26&#013;&#010;Preceding Invoice issue date&#013;&#010;Das Datum, zu dem die vorausgegangene Rechnung ausgestellt wurde.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="format-date(xr:Preceding_Invoice_issue_date,xrf:_('date-format'))" />
          </div>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="uebersichtRechnungsuebersicht">
    <div class="boxzeile">
      <div id="uebersichtRechnungsuebersicht" class="box">
        <div class="BG-22 boxtitel" role="heading" aria-level="2">
          <xsl:attribute name="data-title">BG-22&#013;&#010;DOCUMENT TOTALS&#013;&#010;Eine Gruppe von Informationselementen, die die monetären Gesamtbeträge der
        Rechnung enthalten.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
          <xsl:value-of select="xrf:_('uebersichtRechnungsuebersicht')" />
        </div>
        <div class="boxtabelle boxinhalt" role="table">
          <div class="rechnungsZeile" role="row">
            <div class="boxdaten rechnungSp1" role="rowheader">
              <xsl:value-of select="xrf:_('xr:Sum_of_Invoice_line_net_amount')" />
            </div>
            <div class="boxdaten rechnungSp2 color2" role="cell">
              <xsl:value-of select="xrf:_('_net')" />
            </div>
            <div class="BT-106 boxdaten rechnungSp3" role="cell">
              <xsl:attribute name="data-title">BT-106&#013;&#010;Sum of Invoice line net amount&#013;&#010;Summe aller BT-131 der Rechnung.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
              <xsl:value-of
                select="xrf:format-with-at-least-two-digits(xr:DOCUMENT_TOTALS/xr:Sum_of_Invoice_line_net_amount,$lang)" />
            </div>
          </div>
          <div class="rechnungsZeile" role="row">
            <div class="boxdaten rechnungSp1" role="rowheader">
              <xsl:value-of select="xrf:_('xr:Sum_of_allowances_on_document_level')" />
            </div>
            <div class="boxdaten rechnungSp2 color2" role="cell">
              <xsl:value-of select="xrf:_('_net')" />
            </div>
            <div class="BT-107 boxdaten rechnungSp3" role="cell">
              <xsl:attribute name="data-title">BT-107&#013;&#010;Sum of allowances on document level&#013;&#010;Summe aller in der Rechnung enthaltenen BT-92.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
              <xsl:value-of
                select="xrf:format-with-at-least-two-digits(xr:DOCUMENT_TOTALS/xr:Sum_of_allowances_on_document_level,$lang)" />
            </div>
          </div>
          <div class="rechnungsZeile" role="row">
            <div class="boxdaten rechnungSp1 paddingBottom line1Bottom" role="rowheader">
              <xsl:value-of select="xrf:_('xr:Sum_of_charges_on_document_level')" />
            </div>
            <div class="boxdaten rechnungSp2 paddingBottom line1Bottom color2" role="cell">
              <xsl:value-of select="xrf:_('_net')" />
            </div>
            <div class="BT-108 boxdaten rechnungSp3 paddingBottom line1Bottom" role="cell">
              <xsl:attribute name="data-title">BT-108&#013;&#010;Sum of charges on document level&#013;&#010;Summe aller in der Rechnung enthaltenen BT-99.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
              <xsl:value-of
                select="xrf:format-with-at-least-two-digits(xr:DOCUMENT_TOTALS/xr:Sum_of_charges_on_document_level,$lang)" />
            </div>
          </div>
          <div class="rechnungsZeile" role="row">
            <div class="boxdaten rechnungSp1 paddingTop" role="rowheader">
              <xsl:value-of select="xrf:_('xr:Invoice_total_amount_without_VAT')" />
            </div>
            <div class="boxdaten rechnungSp2 paddingTop color2" role="cell">
              <xsl:value-of select="xrf:_('_net')" />
            </div>
            <div class="BT-109 boxdaten rechnungSp3 paddingTop" role="cell">
              <xsl:attribute name="data-title">BT-109&#013;&#010;Invoice total amount without VAT&#013;&#010;Der Gesamtbetrag der Rechnung ohne Umsatzsteuer.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
              <xsl:value-of
                select="xrf:format-with-at-least-two-digits(xr:DOCUMENT_TOTALS/xr:Invoice_total_amount_without_VAT,$lang)" />
            </div>
          </div>
          <div class="rechnungsZeile" role="row">
            <div class="boxdaten rechnungSp1" role="rowheader">
              <xsl:value-of select="xrf:_('xr:Invoice_total_VAT_amount')" />
            </div>
            <div class="boxdaten rechnungSp2 color2" role="cell"></div>
            <div class="BT-110 boxdaten rechnungSp3" role="cell">
              <xsl:attribute name="data-title">BT-110&#013;&#010;Invoice total VAT amount&#013;&#010;Der Gesamtbetrag der Umsatzsteuer für die Rechnung.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
              <xsl:value-of
                select="xrf:format-with-at-least-two-digits(xr:DOCUMENT_TOTALS/xr:Invoice_total_VAT_amount,$lang)" />
            </div>
          </div>
          <div class="rechnungsZeile" role="row">
            <div class="boxdaten rechnungSp1 paddingBottom line1Bottom" role="rowheader">
              <xsl:value-of select="xrf:_('xr:Invoice_total_VAT_amount_in_accounting_currency')" />
            </div>
            <div class="boxdaten rechnungSp2 paddingBottom line1Bottom color2" role="cell"></div>
            <div class="BT-111 boxdaten rechnungSp3 paddingBottom line1Bottom" role="cell">
              <xsl:attribute name="data-title">BT-111&#013;&#010;Invoice total VAT amount in accounting currency&#013;&#010;Der Umsatzsteuergesamtbetrag, angegeben in der Abrechnungswährung, die im Land
        des Verkäufers gültig ist oder verlangt wird.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
              <xsl:value-of
                select="xrf:format-with-at-least-two-digits(xr:DOCUMENT_TOTALS/xr:Invoice_total_VAT_amount_in_accounting_currency,$lang)" />
            </div>
          </div>
          <div class="rechnungsZeile" role="row">
            <div class="boxdaten rechnungSp1 paddingTop" role="rowheader">
              <xsl:value-of select="xrf:_('xr:Invoice_total_amount_with_VAT')" />
            </div>
            <div class="boxdaten rechnungSp2 paddingTop color2" role="cell">
              <xsl:value-of select="xrf:_('_gross')" />
            </div>
            <div class="BT-112 boxdaten rechnungSp3 paddingTop" role="cell">
              <xsl:attribute name="data-title">BT-112&#013;&#010;Invoice total amount with VAT&#013;&#010;Der Gesamtbetrag der Rechnung mit Umsatzsteuer.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
              <xsl:value-of
                select="xrf:format-with-at-least-two-digits(xr:DOCUMENT_TOTALS/xr:Invoice_total_amount_with_VAT,$lang)" />
            </div>
          </div>
          <div class="rechnungsZeile" role="row">
            <div class="boxdaten rechnungSp1" role="rowheader">
              <xsl:value-of select="xrf:_('xr:Paid_amount')" />
            </div>
            <div class="boxdaten rechnungSp2 color2" role="cell">
              <xsl:value-of select="xrf:_('_gross')" />
            </div>
            <div class="BT-113 boxdaten rechnungSp3" role="cell">
              <xsl:attribute name="data-title">BT-113&#013;&#010;Paid amount&#013;&#010;Summe bereits gezahlter Beträge.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
              <xsl:value-of
                select="xrf:format-with-at-least-two-digits(xr:DOCUMENT_TOTALS/xr:Paid_amount,$lang)" />
            </div>
          </div>
          <div class="rechnungsZeile" role="row">
            <div class="boxdaten rechnungSp1 paddingBottom line2Bottom" role="rowheader">
              <xsl:value-of select="xrf:_('xr:Rounding_amount')" />
            </div>
            <div class="boxdaten rechnungSp2 paddingBottom line2Bottom color2" role="cell">
              <xsl:value-of select="xrf:_('_gross')" />
            </div>
            <div class="BT-114 boxdaten rechnungSp3 paddingBottom line2Bottom" role="cell">
              <xsl:attribute name="data-title">BT-114&#013;&#010;Rounding amount&#013;&#010;Der Betrag, um den der Rechnungsbetrag gerundet wurde.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
              <xsl:value-of
                select="xrf:format-with-at-least-two-digits(xr:DOCUMENT_TOTALS/xr:Rounding_amount,$lang)" />
            </div>
          </div>
          <div class="rechnungsZeile" role="row">
            <div class="boxdaten rechnungSp1 paddingTop bold" role="rowheader">
              <xsl:value-of select="xrf:_('xr:Amount_due_for_payment')" />
            </div>
            <div class="boxdaten rechnungSp2 paddingTop color2" role="cell">
              <xsl:value-of select="xrf:_('_gross')" />
            </div>
            <div class="BT-115 boxdaten rechnungSp3 paddingTop bold" role="cell">
              <xsl:attribute name="data-title">BT-115&#013;&#010;Amount due for payment&#013;&#010;Der ausstehende Betrag. Dies ist der BT-112
        abzüglich des BT-113.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
              <xsl:value-of
                select="xrf:format-with-at-least-two-digits(xr:DOCUMENT_TOTALS/xr:Amount_due_for_payment,$lang)" />
            </div>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>


  <xsl:template name="uebersichtUmsatzsteuer" match="xr:VAT_BREAKDOWN">
    <div class="boxzeile">
      <div class="uebersichtUmsatzsteuer box">
        <div class="BG-23 boxtitel" role="heading" aria-level="2">
          <xsl:attribute name="data-title">BG-23&#013;&#010;VAT BREAKDOWN&#013;&#010;Eine Gruppe von Informationselementen, die Informationen über die
                Umsatzsteueraufschlüsselung nach verschiedenen Kategorien, Steuersätzen und
                Ausnahmegründen enthalten.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
          <xsl:value-of select="xrf:_('uebersichtUmsatzsteuer')" />
        </div>
        <div class="boxtabelle boxinhalt" role="table">
          <div class="rechnungsZeile" role="row">
            <div class="boxdaten rechnungSp1 bold" role="rowheader">
              <xsl:value-of select="xrf:_('xr:VAT_category_code')" />:
              <span class="BT-118" data-title="BT-118">
                <xsl:value-of select="xr:VAT_category_code" />
              </span>
            </div>
            <div class="boxdaten rechnungSp2" role="cell"></div>
            <div class="boxdaten rechnungSp3" role="cell"></div>
          </div>
          <div class="rechnungsZeile" role="row">
            <div class="boxdaten rechnungSp1" role="rowheader">
              <xsl:value-of select="xrf:_('xr:VAT_category_taxable_amount')" />
            </div>
            <div class="boxdaten rechnungSp2 color2" role="cell">
              <xsl:value-of select="xrf:_('_net')" />
            </div>
            <div class="BT-116 boxdaten rechnungSp3" role="cell">
              <xsl:attribute name="data-title">BT-116&#013;&#010;VAT category taxable amount&#013;&#010;Summe aller zu versteuernden Beträge, für die ein bestimmter Code der
        Umsatzsteuerkategorie und ein bestimmter Umsatzsteuersatz gelten (falls ein
        kategoriespezifischer Umsatzsteuersatz gilt).&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
              <xsl:value-of select="xrf:format-with-at-least-two-digits(xr:VAT_category_taxable_amount,$lang)" />
            </div>
          </div>
          <div class="rechnungsZeile" role="row">
            <div class="boxdaten rechnungSp1 line1Bottom" role="rowheader">
              <xsl:value-of select="xrf:_('xr:VAT_category_rate')" />
            </div>
            <div class="boxdaten rechnungSp2 color2 line1Bottom" role="cell"></div>
            <div class="BT-119 boxdaten rechnungSp3 line1Bottom" role="cell">
              <xsl:attribute name="data-title">BT-119&#013;&#010;VAT category rate&#013;&#010;Der Umsatzsteuersatz, angegeben als für die betreffende Umsatzsteuerkategorie
                geltender Prozentsatz.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
              <xsl:value-of select="xr:VAT_category_rate" /> %
            </div>
          </div>
          <div class="rechnungsZeile" role="row">
            <div class="boxdaten rechnungSp1" role="rowheader">
              <xsl:value-of select="xrf:_('xr:VAT_category_tax_amount')" />
            </div>
            <div class="boxdaten rechnungSp2 color2" role="cell"></div>
            <div class="BT-117 boxdaten rechnungSp3 bold" role="cell">
              <xsl:attribute name="data-title">BT-117&#013;&#010;VAT category tax amount&#013;&#010;Der für die betreffende Umsatzsteuerkategorie zu entrichtende Gesamtbetrag.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
              <xsl:value-of select="xrf:format-with-at-least-two-digits(xr:VAT_category_tax_amount,$lang)" />
            </div>
          </div>
        </div>

        <div class="grund" role="list">
          <div role="listitem">
            <xsl:value-of select="xrf:_('xr:VAT_exemption_reason_text')" />:
            <span class="BT-120 bold">
              <xsl:attribute name="data-title">BT-120&#013;&#010;VAT exemption reason text&#013;&#010;In Textform angegebener Grund für die Ausnahme des Betrages von der
            Umsatzsteuerpflicht. Sofern die Umsatzsteuerkategorie AE für die Rechnung gilt, ist hier
                der Text Umkehrung der Steuerschuldnerschaft oder der entsprechende Normtext in der für
        die Rechnung gewählten Sprache anzugeben.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
              <xsl:value-of select="xr:VAT_exemption_reason_text" />
            </span>
          </div>
          <div role="listitem">
            <xsl:value-of select="xrf:_('xr:VAT_exemption_reason_code')" />:
            <span class="BT-121 bold">
              <xsl:attribute name="data-title">BT-121&#013;&#010;VAT exemption reason code&#013;&#010;Ein Code für den Grund für die Ausnahme des Betrages von der
                Umsatzsteuerpflicht. Die Codeliste VAT exemption reason code list (VATEX) wird von der
        Connecting Europe Facility gepflegt und herausgegeben.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
              <xsl:value-of select="xr:VAT_exemption_reason_code" />
            </span>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>


  <xsl:template name="uebersichtNachlass" match="xr:DOCUMENT_LEVEL_ALLOWANCES">
    <div class="boxzeile">
      <div class="uebersichtNachlass box">
        <div class="BG-20 boxtitel" role="heading" aria-level="2">
          <xsl:attribute name="data-title">BG-20&#013;&#010;DOCUMENT LEVEL ALLOWANCES&#013;&#010;Eine Gruppe von Informationselementen, die Informationen über Nachlässe
                enthalten, die für die Rechnung als Ganzes gelten.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
          <xsl:value-of select="xrf:_('uebersichtNachlass')" />
        </div>
        <div class="boxtabelle boxinhalt" role="table">
          <div class="rechnungsZeile" role="row">
            <div class="boxdaten rechnungSp1 bold" role="rowheader">
              <xsl:value-of select="xrf:_('xr:Document_level_allowance_VAT_category_code')" />:
              <span>
                <xsl:attribute name="data-title">BT-95&#013;&#010;Document level allowance VAT category code&#013;&#010;Ein Code für das Umsatzsteuermerkmal, das auf den BT-92
                anzuwenden ist.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                <xsl:value-of select="xr:Document_level_allowance_VAT_category_code" />
              </span>
            </div>
            <div class="boxdaten rechnungSp2" role="cell"></div>
            <div class="boxdaten rechnungSp3" role="cell"></div>
          </div>
          <div class="rechnungsZeile" role="row">
            <div class="boxdaten rechnungSp1" role="rowheader">
              <xsl:value-of select="xrf:_('xr:Document_level_allowance_base_amount')" />
            </div>
            <div class="boxdaten rechnungSp2 color2" role="cell">
              <xsl:value-of select="xrf:_('_net')" />
            </div>
            <div class="BT-93 boxdaten rechnungSp3" role="cell">
              <xsl:attribute name="data-title">BT-93&#013;&#010;Document level allowance base amount&#013;&#010;Der Grundbetrag, der in Verbindung mit der BT-94 zur Berechnung des <termname>BT-92</termname> verwendet
        werden kann.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
              <xsl:value-of
                select="xrf:format-with-at-least-two-digits(xr:Document_level_allowance_base_amount,$lang)" />
            </div>
          </div>
          <div class="rechnungsZeile" role="row">
            <div class="boxdaten rechnungSp1 line1Bottom" role="rowheader">
              <xsl:value-of select="xrf:_('xr:Document_level_allowance_percentage')" />
            </div>
            <div class="boxdaten rechnungSp2 color2 line1Bottom" role="cell"></div>
            <div class="BT-94 boxdaten rechnungSp3 line1Bottom" role="cell">
              <xsl:attribute name="data-title">BT-94&#013;&#010;Document level allowance percentage&#013;&#010;Der Prozentsatz, der in Verbindung mit dem BT-93 zur Berechnung des <termname>BT-92</termname> verwendet
        werden kann.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
              <xsl:value-of select="xr:Document_level_allowance_percentage" /> %
            </div>
          </div>
          <div class="rechnungsZeile" role="row">
            <div class="boxdaten rechnungSp1" role="rowheader">
              <xsl:value-of select="xrf:_('xr:Document_level_allowance_amount')" />
            </div>
            <div class="boxdaten rechnungSp2 color2" role="cell">
              <xsl:value-of select="xrf:_('_net')" />
            </div>
            <div class="BT-92 boxdaten rechnungSp3 bold" role="cell">
              <xsl:attribute name="data-title">BT-92&#013;&#010;Document level allowance amount&#013;&#010;Der Nachlassbetrag ohne Umsatzsteuer.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
              <xsl:value-of
                select="xrf:format-with-at-least-two-digits(xr:Document_level_allowance_amount,$lang)" />
            </div>
          </div>
          <div class="rechnungsZeile" role="row">
            <div class="boxdaten rechnungSp1" role="rowheader">
              <xsl:value-of select="xrf:_('xr:Document_level_allowance_VAT_rate')" />
            </div>
            <div class="boxdaten rechnungSp2 color2" role="cell"></div>
            <div class="BT-96 boxdaten rechnungSp3" role="cell">
              <xsl:attribute name="data-title">BT-96&#013;&#010;Document level allowance VAT rate&#013;&#010;Der für den BT-92 geltende und in Prozent angegebene
        Umsatzsteuersatz.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
              <xsl:value-of select="xr:Document_level_allowance_VAT_rate" />
            </div>
          </div>
        </div>
        <div class="grund" role="list">
          <div role="listitem">
            <xsl:value-of select="xrf:_('xr:Document_level_allowance_reason')" />:
            <span class="BT-97 bold">
              <xsl:attribute name="data-title">BT-97&#013;&#010;Document level allowance reason&#013;&#010;Der in Textform angegebene Grund für den BT-92.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
              <xsl:value-of select="xr:Document_level_allowance_reason" />
            </span>
          </div>
          <div role="listitem">
            <xsl:value-of select="xrf:_('xr:Document_level_allowance_reason_code')" />:
            <span class="BT-98 bold">
              <xsl:attribute name="data-title">BT-98&#013;&#010;Document level allowance reason code&#013;&#010;Der als Code angegebene Grund für den BT-92.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
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
        <div class="BG-21 boxtitel" role="heading" aria-level="2">
          <xsl:attribute name="data-title">BG-21&#013;&#010;DOCUMENT LEVEL CHARGES&#013;&#010;Eine Gruppe von Informationselementen, die Informationen über Kosten, Zuschläge, und Steuern – ausgenommen die Umsatzsteuer – enthalten, die für die Rechnung als Ganzes gelten.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
          <xsl:value-of select="xrf:_('uebersichtZuschlaege')" />
        </div>
        <div class="boxtabelle boxinhalt" role="table">
          <div class="rechnungsZeile" role="row">
            <div class="boxdaten rechnungSp1 bold" role="rowheader">
              <xsl:value-of select="xrf:_('xr:Document_level_charge_VAT_category_code')" />:
              <span class="BT-102">
                <xsl:attribute name="data-title">BT-102&#013;&#010;Document level charge VAT category code&#013;&#010;Ein Code für das Umsatzsteuermerkmal dieser Elementgruppe.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                <xsl:value-of select="xr:Document_level_charge_VAT_category_code" />
              </span>
            </div>
            <div class="boxdaten rechnungSp2" role="cell"></div>
            <div class="boxdaten rechnungSp3" role="cell"></div>
          </div>
          <div class="rechnungsZeile" role="row">
            <div class="boxdaten rechnungSp1" role="rowheader">
              <xsl:value-of select="xrf:_('xr:Document_level_charge_base_amount')" />
            </div>
            <div class="boxdaten rechnungSp2 color2" role="cell">
              <xsl:value-of select="xrf:_('_net')" />
            </div>
            <div class="BT-100 boxdaten rechnungSp3" role="cell">
                <xsl:attribute name="data-title">BT-100&#013;&#010;Document level charge base amount&#013;&#010;Der Grundbetrag, der in Verbindung mit dem BT-101 zur Berechnung des BT-99 verwendet werden kann (Bemessungsgrundlage).&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
              <xsl:value-of
                select="xrf:format-with-at-least-two-digits(xr:Document_level_charge_base_amount,$lang)" />
            </div>
          </div>
          <div class="rechnungsZeile" role="row">
            <div class="boxdaten rechnungSp1 line1Bottom" role="rowheader">
              <xsl:value-of select="xrf:_('xr:Document_level_charge_percentage')" />
            </div>
            <div class="boxdaten rechnungSp2 color2 line1Bottom" role="cell"></div>
            <div class="BT-101 boxdaten rechnungSp3 line1Bottom" role="cell">
                <xsl:attribute name="data-title">BT-101&#013;&#010;Document level charge percentage&#013;&#010;Der Prozentsatz, der in Verbindung mit dem BT-100 zur Berechnung des BT-99 verwendet werden kann.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
              <xsl:value-of select="xr:Document_level_charge_percentage" /> %
            </div>
          </div>
          <div class="rechnungsZeile" role="row">
            <div class="boxdaten rechnungSp1" role="rowheader">
              <xsl:value-of select="xrf:_('xr:Document_level_charge_amount')" />
            </div>
            <div class="boxdaten rechnungSp2 color2" role="cell">
              <xsl:value-of select="xrf:_('_net')" />
            </div>
            <div class="BT-99 boxdaten rechnungSp3 bold" role="cell">
                <xsl:attribute name="data-title">BT-99&#013;&#010;Document level charge amount&#013;&#010;Der Betrag einer Abgabe ohne die Umsatzsteuer.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
              <xsl:value-of select="xrf:format-with-at-least-two-digits(xr:Document_level_charge_amount,$lang)" />
            </div>
          </div>
          <div class="rechnungsZeile" role="row">
            <div class="boxdaten rechnungSp1" role="rowheader">
              <xsl:value-of select="xrf:_('xr:Document_level_charge_VAT_rate')" />
            </div>
            <div class="boxdaten rechnungSp2 color2" role="cell"></div>
            <div class="BT-103 boxdaten rechnungSp3" role="cell">
                <xsl:attribute name="data-title">BT-103&#013;&#010;Document level charge VAT rate&#013;&#010;Der Umsatzsteuersatz, dargestellt als Prozentsatz, der für die Abgaben auf der
                Dokumentenebene BT-99 gilt.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
              <xsl:value-of select="xr:Document_level_charge_VAT_rate" />
            </div>
          </div>
        </div>
        <div class="grund" role="list">
            <div role="listitem">
              <xsl:value-of select="xrf:_('xr:Document_level_charge_reason')" />:
              <span class="BT-104 bold" >
              <xsl:attribute name="data-title">BT-104&#013;&#010;Document level charge reason&#013;&#010;Der in Textform angegebene Grund für die Abgaben auf der
        Dokumentenebene.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
              <xsl:value-of select="xr:Document_level_charge_reason" />
            </span>
          </div>
            <div role="listitem">
              <xsl:value-of select="xrf:_('xr:Document_level_charge_reason_code')" />:
            <span class="BT-105 bold">
              <xsl:attribute name="data-title">BT-105&#013;&#010;Document level charge reason code&#013;&#010;Der als Code angegebene Grund für die Abgaben auf der Dokumentenebene.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
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
      <div data-title="" class="boxtitel" role="heading" aria-level="2">
        <xsl:value-of select="xrf:_('uebersichtZahlungInfo')" />
      </div>
      <div class="boxtabelle boxinhalt borderSpacing" role="list">
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Payment_terms')" />:
          </div>
          <div class="BT-20 boxdaten wert">
            <xsl:attribute name="data-title">BT-20&#013;&#010;Payment terms&#013;&#010;Eine Textbeschreibung der Zahlungsbedingungen, die für den fälligen Zahlungsbetrag gelten (einschließlich Beschreibung möglicher Skonto- und Verzugsbedingungen). Dieses Informationselement kann mehrere Zeilen und mehrere Angaben zu Zahlungsbedingungen beinhalten und sowohl unstrukturierten als strukturierten Text enthalten. Der unstrukturierte Text darf dabei keine # enthalten.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:for-each select="tokenize(xr:Payment_terms,';')">
              <xsl:value-of select="." />
              <xsl:if test="position() != last()">
                <br />
              </xsl:if>
            </xsl:for-each>
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Payment_due_date')" />:
          </div>
          <div class="BT-9 boxdaten wert">
            <xsl:attribute name="data-title">BT-9&#013;&#010;Payment due date&#013;&#010;Das Fälligkeitsdatum des Rechnungsbetrages.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:for-each select="tokenize(xr:Payment_due_date,';')">
              <xsl:value-of select="format-date(xs:date(.),xrf:_('date-format'))" />
              <xsl:if test="position() != last()">
                <br />
              </xsl:if>
            </xsl:for-each>
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Payment_means_type_code')" />:
          </div>
          <div class="BT-81 boxdaten wert">
            <xsl:attribute name="data-title">BT-81&#013;&#010;Payment means type code&#013;&#010;Das als Code ausgedrückte erwartete oder genutzte Zahlungsmittel. Hierzu wird
        auf die Codeliste UN/ECE 4461 verwiesen.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:PAYMENT_INSTRUCTIONS/xr:Payment_means_type_code" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Payment_means_text')" />:
          </div>
          <div class="BT-82 boxdaten wert">
            <xsl:attribute name="data-title">BT-82&#013;&#010;Payment means text&#013;&#010;Das in Textform ausgedrückte erwartete oder genutzte
        Zahlungsmittel.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:PAYMENT_INSTRUCTIONS/xr:Payment_means_text" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Remittance_information')" />:
          </div>
          <div class="BT-83 boxdaten wert">
            <xsl:attribute name="data-title">BT-83&#013;&#010;Remittance information&#013;&#010;Ein Textwert, der zur Verknüpfung der Zahlung mit der vom Verkäufer
                ausgestellten Rechnung verwendet wird.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:PAYMENT_INSTRUCTIONS/xr:Remittance_information" />
          </div>
        </div>
      </div>
    </div>
  </xsl:template>


  <xsl:template name="uebersichtCard">
    <div id="uebersichtCard" class="box subBox">
      <div class="BG-18 boxtitel boxtitelSub" role="heading" aria-level="3">
        <xsl:attribute name="data-title">BG-18&#013;&#010;PAYMENT CARD INFORMATION&#013;&#010;Eine Gruppe von Informationselementen, die Informationen über die für die
        Zahlung genutzte Karte enthalten.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
        <xsl:value-of select="xrf:_('uebersichtZahlungKarte')" />
      </div>
      <div class="boxtabelle boxinhalt borderSpacing" role="list">
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Payment_card_primary_account_number')" />:
          </div>
          <div class="BT-87 boxdaten wert">
            <xsl:attribute name="data-title">BT-87&#013;&#010;Payment card primary account number&#013;&#010;Die Nummer der Kreditkarte, die für die Zahlung genutzt wurde.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of
              select="xr:PAYMENT_INSTRUCTIONS/xr:PAYMENT_CARD_INFORMATION/xr:Payment_card_primary_account_number" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Payment_card_holder_name')" />:
          </div>
          <div class="BT-88 boxdaten wert">
            <xsl:attribute name="data-title">BT-88&#013;&#010;Payment card holder name&#013;&#010;Name des Karteninhabers.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of
              select="xr:PAYMENT_INSTRUCTIONS/xr:PAYMENT_CARD_INFORMATION/xr:Payment_card_holder_name" />
          </div>
        </div>
      </div>
    </div>
  </xsl:template>


  <xsl:template name="uebersichtLastschrift">
    <div id="uebersichtLastschrift" class="box subBox">
      <div class="BG-19 boxtitel boxtitelSub" role="heading" aria-level="3">
        <xsl:attribute name="data-title">BG-19&#013;&#010;DIRECT DEBIT&#013;&#010;Eine Gruppe von Informationselementen, die spezifische Informationen über die
        vorgesehene Lastschrift geben.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
        <xsl:value-of select="xrf:_('uebersichtZahlungLastschrift')" />
      </div>
      <div class="boxtabelle boxinhalt borderSpacing" role="list">
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Mandate_reference_identifier')" />:
          </div>
          <div class="BT-89 boxdaten wert">
            <xsl:attribute name="data-title">BT-89&#013;&#010;Mandate reference identifier&#013;&#010;Eindeutige Kennung, die vom Zahlungsempfänger zur Referenzierung der
        Einzugsermächtigung zugewiesen wird (Mandatsreferenznummer).&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:PAYMENT_INSTRUCTIONS/xr:DIRECT_DEBIT/xr:Mandate_reference_identifier" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Debited_account_identifier')" />:
          </div>
          <div class="BT-91 boxdaten wert">
            <xsl:attribute name="data-title">BT-91&#013;&#010;Debited account identifier&#013;&#010;Die Kennung des Kontos, von dem die Lastschrift erfolgen soll: IBAN für
        Zahlungen im SEPA-Raum, Kontonummer oder IBAN im Falle von
        Auslandszahlungen.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:PAYMENT_INSTRUCTIONS/xr:DIRECT_DEBIT/xr:Debited_account_identifier" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Bank_assigned_creditor_identifier')" />:
          </div>
          <div class="BT-90 boxdaten wert">
            <xsl:attribute name="data-title">BT-90&#013;&#010;Bank assigned creditor identifier&#013;&#010;Die eindeutige Kennung des Verkäufers (Seller) oder des Zahlungsempfängers
        (Payee), um am SEPA-Lastschriftverfahren teilnehmen zu können
        (Gläubiger-ID).&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of
              select="xr:PAYMENT_INSTRUCTIONS/xr:DIRECT_DEBIT/xr:Bank_assigned_creditor_identifier" />
          </div>
        </div>
      </div>
    </div>
  </xsl:template>


  <xsl:template name="uebersichtUeberweisung">
    <div id="uebersichtUeberweisung" class="box subBox">
      <div class="BG-17 boxtitel boxtitelSub" role="heading" aria-level="3">
        <xsl:attribute name="data-title">BG-17&#013;&#010;CREDIT TRANSFER&#013;&#010;Eine Gruppe von Informationselementen, die Informationen über das Bankkonto
        geben, auf das die Überweisung zu leisten ist.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
        <xsl:value-of select="xrf:_('uebersichtZahlungUeberweisung')" />
      </div>
      <xsl:for-each select="xr:PAYMENT_INSTRUCTIONS/xr:CREDIT_TRANSFER">
        <div class="boxtabelle boxinhalt borderSpacing" role="list">
          <div class="boxzeile" role="listitem">
            <div class="boxdaten legende">
              <xsl:value-of select="xrf:_('xr:Payment_account_name')" />:
            </div>
            <div class="BT-85 boxdaten wert">
              <xsl:attribute name="data-title">BT-85&#013;&#010;Payment account name&#013;&#010;Name des Kontos bei einem Zahlungsdienstleister, auf das die Zahlung erfolgen
        soll. (z. B. Kontoinhaber)&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
              <xsl:value-of select="xr:Payment_account_name" />
            </div>
          </div>
          <div class="boxzeile" role="listitem">
            <div class="boxdaten legende">
              <xsl:value-of select="xrf:_('xr:Payment_account_identifier')" />:
            </div>
            <div class="BT-84 boxdaten wert">
              <xsl:attribute name="data-title">BT-84&#013;&#010;Payment account identifier&#013;&#010;Die Kennung des Kontos, auf das die Zahlung erfolgen soll: IBAN für Zahlungen
        im SEPA-Raum, Kontonummer oder IBAN im Falle von Auslandszahlungen.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
              <xsl:value-of select="xr:Payment_account_identifier" />
            </div>
          </div>
          <div class="boxzeile" role="listitem">
            <div class="boxdaten legende">
              <xsl:value-of select="xrf:_('xr:Payment_service_provider_identifier')" />:
            </div>
            <div class="BT-86 boxdaten wert">
              <xsl:attribute name="data-title">&#013;&#010;Payment service provider identifier&#013;&#010;Die Kennung des Konto führenden Kreditinstitutes, diese Kennung ergibt sich bei Zahlungen im SEPA-Raum im Regelfall aus der IBAN.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
              <xsl:value-of select="xr:Payment_service_provider_identifier" />
            </div>
          </div>
        </div>
      </xsl:for-each>
    </div>
  </xsl:template>


  <xsl:template name="uebersichtBemerkungen" match="xr:INVOICE_NOTE">
    <div class="uebersichtBemerkungen box">
      <div class="BG-1 boxtitel" role="heading" aria-level="2">
        <xsl:attribute name="data-title">BG-1&#013;&#010;INVOICE NOTE&#013;&#010;Eine Gruppe von Informationselementen für rechnungsrelevante Erläuterungen mit
        Hinweisen auf den Rechnungsbetreff.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
        <xsl:value-of select="xrf:_('_invoice-note-group')" />
      </div>
      <div class="boxtabelle boxinhalt borderSpacing" role="list">
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Invoice_note_subject_code')" />:
          </div>
          <div class="BT-21 boxdaten wert">
            <xsl:attribute name="data-title">BT-21&#013;&#010;Invoice note subject code&#013;&#010;Der Betreff für den nachfolgenden Textvermerk zur Rechnung.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:Invoice_note_subject_code" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Invoice_note')" />:
          </div>
          <div class="BT-22 boxdaten wert">
            <xsl:attribute name="data-title">BT-22&#013;&#010;Invoice note&#013;&#010;Ein Textvermerk, der unstrukturierte Informationen enthält, die für die
        Rechnung als Ganzes maßgeblich sind. Erforderlichenfalls können Angaben zur
        Aufbewahrungspflicht gem. § 14 Abs. 4 Nr. 9 UStG hier aufgenommen werden.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:Invoice_note" />
          </div>
        </div>
      </div>
    </div>
  </xsl:template>


  <xsl:template name="details">
    <div id="details" class="divHide" role="tabpanel" aria-labelledby="menueDetails" tabindex="0">
      <div class="haftungausschluss">
        <xsl:value-of select="xrf:_('_disclaimer')" />
      </div>
      <xsl:apply-templates select="./xr:INVOICE_LINE" /> <!-- many -->
    </div>
  </xsl:template>


  <xsl:template match="xr:INVOICE_LINE | xr:SUB_INVOICE_LINE">
    <div class="boxtabelle boxabstandtop boxtabelleZweispaltig first">
      <div class="boxzeile">
        <div class="box subBox">
          <div class="BT-126 boxtitel" role="heading" aria-level="2">
            <xsl:attribute name="data-title">BT-126&#013;&#010;Invoice line identifier&#013;&#010;Eindeutige Bezeichnung für die betreffende Rechnungsposition.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="concat( xrf:_('xr:Invoice_line_identifier') , ': ', xr:Invoice_line_identifier)" />
          </div>
          <div class="boxtabelle boxinhalt borderSpacing" role="list">
            <div class="boxzeile" role="listitem">
              <div class="boxdaten legende">
                <xsl:value-of select="xrf:_('xr:Invoice_line_note')" />:
              </div>
              <div class="BT-127 boxdaten wert">
                <xsl:attribute name="data-title">BT-127&#013;&#010;Invoice line note&#013;&#010;Ein Textvermerk, der unstrukturierte Informationen enthält, die für die
        Rechnungsposition maßgeblich sind.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                <xsl:value-of select="xr:Invoice_line_note" />
              </div>
            </div>
            <div class="boxzeile" role="listitem">
              <div class="boxdaten legende">
                <xsl:value-of select="xrf:_('xr:Invoice_line_object_identifier')" />:
              </div>
              <div class="BT-128 boxdaten wert">
                <xsl:attribute name="data-title">BT-128&#013;&#010;Invoice line object identifier&#013;&#010;Eine vom Verkäufer angegebene Kennung für ein Objekt, auf das sich die
        Rechnungsposition bezieht (z. B. Zählernummer, Telefonnummer, Kfz-Kennzeichen, versicherte
        Person, Abonnement-Nummer, Rufnummer).&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                <xsl:value-of select="xr:Invoice_line_object_identifier" />
              </div>  
            </div>
            <div class="boxzeile" role="listitem">
              <div class="boxdaten legende">
                <xsl:value-of select="xrf:_('xr:Invoice_line_object_identifier/@scheme_identifier')" />:
              </div>
              <div data-title="BT-128-scheme-id" class="BT-128-scheme-id boxdaten wert">
                <xsl:attribute name="data-title">bt-128-scheme-id&#013;&#010;Invoiced object identifier/Scheme identifier&#013;&#010;Die Kennung des Bildungsmusters der Objektkennung.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                <xsl:value-of select="xr:Invoice_line_object_identifier/@scheme_identifier" />
              </div>
            </div>
            <div class="boxzeile" role="listitem">
              <div class="boxdaten legende">
                <xsl:value-of select="xrf:_('xr:Referenced_purchase_order_line_reference')" />:
              </div>
              <div class="BT-132 boxdaten wert">
                <xsl:attribute name="data-title">BT-132&#013;&#010;Referenced purchase order line reference&#013;&#010;Eine vom Erwerber ausgegebene Kennung für eine referenzierte Position einer
                Bestellung/eines Auftrags.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                <xsl:value-of select="xr:Referenced_purchase_order_line_reference" />
              </div>
            </div>
            <div class="boxzeile" role="listitem">
              <div class="boxdaten legende">
                <xsl:value-of select="xrf:_('xr:Invoice_line_Buyer_accounting_reference')" />:
              </div>
              <div class="BT-133 boxdaten wert">
                <xsl:attribute name="data-title">BT-133&#013;&#010;Invoice line Buyer accounting reference&#013;&#010;Ein Textwert, der angibt, an welcher Stelle die betreffenden Daten in den
                Finanzkonten des Erwerbers zu buchen sind.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                <xsl:value-of select="xr:Invoice_line_Buyer_accounting_reference" />
              </div>
            </div>
            <div role="listitem">
              <strong class="BG-26">
                <xsl:attribute name="data-title">BG-26&#013;&#010;INVOICE LINE PERIOD&#013;&#010;Eine Gruppe von Informationselementen, die Informationen über den für die
        Rechnungsposition maßgeblichen Abrechnungszeitraum enthalten.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                <xsl:value-of select="xrf:_('detailsPositionAbrechnungszeitraum')" />:
              </strong>
              <div class="boxtabelle borderSpacing" role="list">
                <div class="boxzeile" role="listitem">
                  <div class="boxdaten legende">
                    <xsl:value-of select="xrf:_('xr:Invoice_line_period_start_date')" />:
                  </div>
                  <div class="BT-134 boxdaten wert">
                    <xsl:attribute name="data-title">BT-134&#013;&#010;Invoice line period start date&#013;&#010;Das Datum, an dem der Abrechnungszeitraum der betreffenden Rechnungsposition
        beginnt.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                    <xsl:value-of
                      select="format-date(xr:INVOICE_LINE_PERIOD/xr:Invoice_line_period_start_date,xrf:_('date-format'))" />
                  </div>
                </div>
                <div class="boxzeile" role="listitem">
                  <div class="boxdaten legende">
                    <xsl:value-of select="xrf:_('xr:Invoice_line_period_end_date')" />:
                  </div>
                  <div class="BT-135 boxdaten wert">
                    <xsl:attribute name="data-title">BT-135&#013;&#010;Invoice line period end date&#013;&#010;Das Datum, an dem der Abrechnungszeitraum der betreffenden Rechnungsposition
        endet.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                    <xsl:value-of
                      select="format-date(xr:INVOICE_LINE_PERIOD/xr:Invoice_line_period_end_date,xrf:_('date-format'))" />
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="box subBox">
          <div class="BG-29 boxtitel boxtitelSub" role="heading" aria-level="3">
            <xsl:attribute name="data-title">BG-29&#013;&#010;PRICE DETAILS&#013;&#010;Eine Gruppe von Informationselementen, die Informationen über den Preis für die 
        in der betreffenden Rechnungsposition in Rechnung gestellten Waren und Dienstleistungen
        enthalten.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xrf:_('detailsPositionPreiseinzelheiten')" />
          </div>
          <div class="boxtabelle boxinhalt" role="table">
            <div class="rechnungsZeile" role="row">
              <div class="boxdaten detailSp1 color2" role="rowheader">
                <xsl:value-of select="xrf:_('xr:Invoiced_quantity')" />
              </div>
              <div class="BT-129 boxdaten detailSp2" role="cell">
                <xsl:attribute name="data-title">BT-129&#013;&#010;Invoiced quantity&#013;&#010;Die Menge zu dem in der betreffenden Zeile in Rechnung gestellten Einzelposten
        (Waren oder Dienstleistungen).&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                <xsl:value-of select="xr:Invoiced_quantity" />
              </div>
            </div>
            <div class="rechnungsZeile" role="row">
              <div class="boxdaten detailSp1 color2" role="rowheader">
                <xsl:value-of select="xrf:_('xr:Invoiced_quantity_unit_of_measure_code')" />
              </div>
              <div class="BT-130 boxdaten detailSp2" role="cell">
                <xsl:attribute name="data-title">BT-130&#013;&#010;Invoiced quantity unit of measure code&#013;&#010;Die für BT-129 geltende Maßeinheit.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                <xsl:value-of select="xr:Invoiced_quantity_unit_of_measure_code" />
              </div>
            </div>
            <div class="rechnungsZeile" role="row">
              <div class="boxdaten detailSp1 line1Bottom color2" role="rowheader">
                <xsl:value-of select="xrf:_('xr:Item_net_price')" />
              </div>
              <div class="BT-146 boxdaten detailSp2 line1Bottom" role="cell">
                <xsl:attribute name="data-title">BT-146&#013;&#010;Item net price&#013;&#010;Der Preis eines Postens, ohne Umsatzsteuer, nach Abzug des für diese
                Rechnungsposition geltenden Rabatts.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                <xsl:value-of
                  select="xrf:format-with-at-least-two-digits(xr:PRICE_DETAILS/xr:Item_net_price,$lang)" />
              </div>
            </div>
            <div class="rechnungsZeile" role="row">
              <div class="boxdaten detailSp1 color2" role="rowheader">
                <xsl:value-of select="xrf:_('xr:Invoice_line_net_amount')" />
              </div>
              <div class="BT-131 boxdaten detailSp2 bold" role="cell">
                <xsl:attribute name="data-title">BT-131&#013;&#010;Invoice line net amount&#013;&#010;Der Gesamtbetrag der Rechnungsposition. Dies ist der Betrag ohne Umsatzsteuer,
        aber einschließlich aller für die Rechnungsposition geltenden Nachlässe und Abgaben sowie
        sonstiger anfallender Steuern.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                <xsl:value-of select="xrf:format-with-at-least-two-digits(xr:Invoice_line_net_amount,$lang)" />
              </div>
            </div>
          </div>
          <div class="boxtabelle boxinhalt noPaddingTop borderSpacing" role="list">
            <div class="boxzeile" role="listitem">
              <div class="boxdaten legende">
                <xsl:value-of select="xrf:_('xr:Item_price_discount')" />:
              </div>
              <div class="BT-147 boxdaten wert">
                <xsl:attribute name="data-title">BT-147&#013;&#010;Item price discount&#013;&#010;Der gesamte zur Berechnung des Netto-Postenpreises vom Brutto-Postenpreis
                subtrahierte Rabatt.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                <xsl:value-of
                  select="xrf:format-with-at-least-two-digits(xr:PRICE_DETAILS/xr:Item_price_discount,$lang)" />
              </div>
            </div>
            <div class="boxzeile" role="listitem">
              <div class="boxdaten legende">
                <xsl:value-of select="xrf:_('xr:Item_gross_price')" />:
              </div>
              <div class="BT-148 boxdaten wert">
                <xsl:attribute name="data-title">BT-148&#013;&#010;Item gross price&#013;&#010;Der Postenpreis ohne Umsatzsteuer vor Abzug des
        Postenpreisrabatts.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                <xsl:value-of
                  select="xrf:format-with-at-least-two-digits(xr:PRICE_DETAILS/xr:Item_gross_price,$lang)" />
              </div>
            </div>
            <div class="boxzeile" role="listitem">
              <div class="boxdaten legende">
                <xsl:value-of select="xrf:_('xr:Item_price_base_quantity')" />:
              </div>
              <div class="BT-149 boxdaten wert">
                <xsl:attribute name="data-title">BT-149&#013;&#010;Item price base quantity&#013;&#010;Die Anzahl von Einheiten, für die der Postenpreis gilt.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                <xsl:value-of select="xr:PRICE_DETAILS/xr:Item_price_base_quantity" />
              </div>
            </div>
            <div class="boxzeile" role="listitem">
              <div class="boxdaten legende">
                <xsl:value-of select="xrf:_('xr:Item_price_base_quantity_unit_of_measure')" />:
              </div>
              <div class="BT-150 boxdaten wert">
                <xsl:attribute name="data-title">BT-150&#013;&#010;Item price base quantity unit of measure code&#013;&#010;Der Code der zu Grunde gelegten Maßeinheit.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                <xsl:value-of select="xr:PRICE_DETAILS/xr:Item_price_base_quantity_unit_of_measure" />
              </div>
            </div>
            <div class="boxzeile" role="listitem">
              <div class="boxdaten legende">
                <xsl:value-of select="xrf:_('xr:Invoiced_item_VAT_category_code')" />:
              </div>
              <div class="BT-151 boxdaten wert">
                <xsl:attribute name="data-title">BT-151&#013;&#010;Invoiced item VAT category code&#013;&#010;Der Code der für den in Rechnung gestellten Posten geltenden
                Umsatzsteuerkategorie.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                <xsl:value-of select="xr:LINE_VAT_INFORMATION/xr:Invoiced_item_VAT_category_code" />
              </div>
            </div>
            <div class="boxzeile" role="listitem">
              <div class="boxdaten legende">
                <xsl:value-of select="xrf:_('xr:Invoiced_item_VAT_rate')" />:
              </div>
              <div class="BT-152 boxdaten wert">
                <xsl:attribute name="data-title">BT-152&#013;&#010;Invoiced item VAT rate&#013;&#010;Der für den in Rechnung gestellten Posten geltende und als Prozentsatz
                angegebene Umsatzsteuersatz.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                <xsl:value-of
                  select="xrf:format-with-at-least-two-digits(xr:LINE_VAT_INFORMATION/xr:Invoiced_item_VAT_rate,$lang)" /> %
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="boxtabelle">
      <div class="boxzeile">
        <div class="box subBox">
          <div class="BG-27 boxtitel boxtitelSub" role="heading" aria-level="3">
            <xsl:attribute name="data-title">BG-27&#013;&#010;INVOICE LINE ALLOWANCES&#013;&#010;Eine Gruppe von Informationselementen, die Informationen über die für die
        betreffende Rechnungsposition geltenden Nachlässe enthalten.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xrf:_('detailsPositionNachlaesse')" />
          </div>
          <xsl:for-each select="xr:INVOICE_LINE_ALLOWANCES">
            <div class="boxtabelle boxinhalt " role="table">
              <div class="rechnungsZeile" role="row">
                <div class="boxdaten detailSp1 color2" role="rowheader">
                  <xsl:value-of select="xrf:_('xr:Invoice_line_allowance_base_amount')" />
                </div>
                <div class="BT-137 boxdaten detailSp2" role="cell">
                  <xsl:attribute name="data-title">BT-137&#013;&#010;Invoice line allowance base amount&#013;&#010;Der Grundbetrag, der in Verbindung mit BT-138 zur Berechnung des BT-136
        verwendet werden kann.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                  <xsl:value-of
                    select="xrf:format-with-at-least-two-digits(xr:Invoice_line_allowance_base_amount,$lang)" />
                </div>
              </div>
              <div class="rechnungsZeile" role="row">
                <div class="boxdaten detailSp1 line1Bottom color2" role="rowheader">
                  <xsl:value-of select="xrf:_('xr:Invoice_line_allowance_percentage')" />
                </div>
                <div class="BT-138 boxdaten detailSp2 line1Bottom" role="cell">
                  <xsl:attribute name="data-title">BT-138&#013;&#010;Invoice line allowance percentage&#013;&#010;Der Prozentsatz, der in Verbindung mit dem BT-137 zur Berechnung des BT-136
        verwendet werden kann.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                  <xsl:value-of
                    select="xrf:format-with-at-least-two-digits(xr:Invoice_line_allowance_percentage,$lang)" /> %
                </div>
              </div>
              <div class="rechnungsZeile" role="row">
                <div class="boxdaten detailSp1 color2" role="rowheader">
                  <xsl:value-of select="xrf:_('xr:Invoice_line_allowance_amount')" />
                </div>
                <div class="BT-136 boxdaten detailSp2 bold" role="cell">
                  <xsl:attribute name="data-title">BT-136&#013;&#010;Invoice line allowance amount&#013;&#010;Der Nachlassbetrag ohne Umsatzsteuer.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                  <xsl:value-of
                    select="xrf:format-with-at-least-two-digits(xr:Invoice_line_allowance_amount,$lang)" />
                </div>
              </div>
            </div>
            <div class="grundDetail" role="list">
              <div class="color2" role="listitem">
                <xsl:value-of select="xrf:_('xr:Invoice_line_allowance_reason')" />:
                <span class="BT-139 bold">
                  <xsl:attribute name="data-title">BT-139&#013;&#010;Invoice line allowance reason&#013;&#010;Der in Textform angegebene Grund für den
        Rechnungspositionennachlass.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                  <xsl:value-of select="xr:Invoice_line_allowance_reason" />
                </span>
              </div>
              <div class="color2" role="listitem">
                <xsl:value-of select="xrf:_('xr:Invoice_line_allowance_reason_code')" />:
                <span class="BT-140 bold">
                  <xsl:attribute name="data-title">BT-140&#013;&#010;Invoice line allowance reason code&#013;&#010;Der als Code angegebene Grund für den Rechnungspositionennachlass.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                  <xsl:value-of select="xr:Invoice_line_allowance_reason_code" />
                </span>
              </div>
            </div>
          </xsl:for-each>
        </div>
        <div class="box subBox">
          <div class="BG-28 boxtitel boxtitelSub" role="heading" aria-level="3">
            <xsl:attribute name="data-title">BG-28&#013;&#010;INVOICE LINE CHARGES&#013;&#010;Eine Gruppe von Informationselementen, die Informationen über Kosten,
        Zuschläge, und Steuern – ausgenommen die Umsatzsteuer – enthalten, die für die jeweilige
        Rechnungsposition gelten.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xrf:_('detailsPositionZuschlaege')" />
          </div>
          <xsl:for-each select="xr:INVOICE_LINE_CHARGES">
            <div class="boxtabelle boxinhalt " role="table">
              <div class="rechnungsZeile" role="row">
                <div class="boxdaten detailSp1 color2" role="rowheader">
                  <xsl:value-of select="xrf:_('xr:Invoice_line_charge_base_amount')" />
                </div>
                <div class="BT-142 boxdaten detailSp2" role="cell">
                  <xsl:attribute name="data-title">BT-142&#013;&#010;Invoice line charge base amount&#013;&#010;Der Grundbetrag, der in Verbindung mit BT-143 zur Berechnung des BT-141
        verwendet werden kann.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                  <xsl:value-of
                    select="xrf:format-with-at-least-two-digits(xr:Invoice_line_charge_base_amount,$lang)" />
                </div>
              </div>
              <div class="rechnungsZeile" role="row">
                <div class="boxdaten detailSp1 line1Bottom color2" role="rowheader">
                  <xsl:value-of select="xrf:_('xr:Invoice_line_charge_percentage')" />
                </div>
                <div class="BT-143 boxdaten detailSp2 line1Bottom" role="cell">
                  <xsl:attribute name="data-title">BT-143&#013;&#010;Invoice line charge percentage&#013;&#010;Der Prozentsatz, der in Verbindung mit dem BT-142 zur Berechnung des BT-141
        verwendet werden kann.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                  <xsl:value-of
                    select="xrf:format-with-at-least-two-digits(xr:Invoice_line_charge_percentage,$lang)" /> %
                </div>
              </div>
              <div class="rechnungsZeile" role="row">
                <div class="boxdaten detailSp1 color2" role="rowheader">
                  <xsl:value-of select="xrf:_('xr:Invoice_line_charge_amount')" />
                </div>
                <div class="BT-141 boxdaten detailSp2 bold" role="cell">
                  <xsl:attribute name="data-title">BT-141&#013;&#010;Invoice line charge amount&#013;&#010;Der Betrag einer Abgabe ohne die Umsatzsteuer.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                  <xsl:value-of
                    select="xrf:format-with-at-least-two-digits(xr:Invoice_line_charge_amount,$lang)" />
                </div>
              </div>
            </div>
            <div class="grundDetail" role="list">
              <div class="color2" role="listitem">
                <xsl:value-of select="xrf:_('xr:Invoice_line_charge_reason')" />:
                <span class="BT-144 bold">
                  <xsl:attribute name="data-title">BT-144&#013;&#010;Invoice line charge reason&#013;&#010;Der in Textform angegebene Grund für die
        Rechnungspositionenabgaben.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                  <xsl:value-of select="xr:Invoice_line_charge_reason" />
                </span>
              </div>
              <div class="color2" role="listitem">
                <xsl:value-of select="xrf:_('xr:Invoice_line_charge_reason_code')" />:
                <span class="BT-145 bold">
                  <xsl:attribute name="data-title">BT-145&#013;&#010;Invoice line charge reason code&#013;&#010;Der als Code angegebene Grund für die Rechnungspositionenabgaben.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
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
          <div class="BG-31 boxtitel boxtitelSub" role="heading" aria-level="3">
            <xsl:attribute name="data-title">BG-31&#013;&#010;ITEM INFORMATION&#013;&#010;Eine Gruppe von Informationselementen, die Informationen über die in Rechnung
        gestellten Waren und Dienstleistungen enthalten.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xrf:_('detailsPositionArtikelinformationen')" />
          </div>
          <div class="boxtabelle boxinhalt ">
            <div class="boxzeile">
              <div class="boxcell boxZweispaltig">
                <div class="boxtabelle borderSpacing" role="list">
                  <div class="boxzeile" role="listitem">
                    <div class="boxdaten legende">
                      <xsl:value-of select="xrf:_('xr:Item_name')" />:
                    </div>
                    <div class="BT-153 boxdaten wert bold">
                      <xsl:attribute name="data-title">BT-153&#013;&#010;Item name&#013;&#010;Ein Name des Postens.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                      <xsl:value-of select="xr:ITEM_INFORMATION/xr:Item_name" />
                    </div>
                  </div>
                  <div class="boxzeile" role="listitem">
                    <div class="boxdaten legende">
                      <xsl:value-of select="xrf:_('xr:Item_description')" />:
                    </div>
                    <div class="BT-154 boxdaten wert">
                      <xsl:attribute name="data-title">BT-154&#013;&#010;Item description&#013;&#010;Eine Beschreibung des Postens.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                      <xsl:value-of select="xr:ITEM_INFORMATION/xr:Item_description" />
                    </div>
                  </div>
                  <div class="boxzeile" role="listitem">
                    <div class="boxdaten legende">
                      <xsl:value-of select="xrf:_('xr:Item_Sellers_identifier')" />:
                    </div>
                    <div class="BT-155 boxdaten wert">
                      <xsl:attribute name="data-title">BT-155&#013;&#010;Item Sellers identifier&#013;&#010;Eine dem Posten vom Verkäufer zugewiesene Kennung.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                      <xsl:value-of select="xr:ITEM_INFORMATION/xr:Item_Sellers_identifier" />
                    </div>
                  </div>
                  <div class="boxzeile" role="listitem">
                    <div class="boxdaten legende">
                      <xsl:value-of select="xrf:_('xr:Item_Buyers_identifier')" />:
                    </div>
                    <div class="BT-156 boxdaten wert">
                      <xsl:attribute name="data-title">BT-156&#013;&#010;Item Buyers identifier&#013;&#010;Eine dem Posten vom Erwerber zugewiesene Kennung.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                      <xsl:value-of select="xr:ITEM_INFORMATION/xr:Item_Buyers_identifier" />
                    </div>
                  </div>
                  <div class="boxtabelle borderSpacing" role="listitem">
                    <strong class="BG-32">
                      <xsl:attribute name="data-title">BG-32&#013;&#010;ITEM ATTRIBUTES&#013;&#010;Eine Gruppe von Informationselementen, die Informationen über die Eigenschaften
        der in Rechnung gestellten Waren und Dienstleistungen enthalten.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                      <xsl:value-of select="xrf:_('detailsPositionArtikeleigenschaften')" />:
                    </strong>
                    <xsl:apply-templates select="xr:ITEM_INFORMATION/xr:ITEM_ATTRIBUTES" />
                  </div>
                </div>
              </div>
              <div class="boxabstand"></div>
              <div class="boxcell boxZweispaltig">
                <div class="boxtabelle borderSpacing" role="list">
                  <div class="boxzeile">
                    <div class="boxdaten legende">
                      <xsl:value-of select="xrf:_('xr:Item_standard_identifier')" />:
                    </div>
                    <div class="BT-157 boxdaten wert">
                      <xsl:attribute name="data-title">BT-157&#013;&#010;Item standard identifier&#013;&#010;Eine auf einem registrierten Schema basierende Postenkennung.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                      <xsl:value-of select="xr:ITEM_INFORMATION/xr:Item_standard_identifier" />
                    </div>
                  </div>
                  <div class="boxzeile" role="listitem">
                    <div class="boxdaten legende">
                      <xsl:value-of select="xrf:_('xr:Item_standard_identifier/@scheme_identifier')" />:
                    </div>
                    <div data-title="BT-157-scheme-id" class="BT-157-scheme-id boxdaten wert">
                      <xsl:attribute name="data-title">scheme-id-bt-157&#013;&#010;Item standard identifier/Scheme identifier&#013;&#010;Die Kennung des Schemas für das Element BT-157.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                      <xsl:value-of
                        select="xr:ITEM_INFORMATION/xr:Item_standard_identifier/@scheme_identifier" />
                    </div>
                  </div>
                  <div class="boxzeile" role="listitem">
                    <div class="boxdaten legende">
                      <xsl:value-of select="xrf:_('xr:Item_classification_identifier')" />:
                    </div>
                    <div class="BT-158 boxdaten wert">
                      <xsl:attribute name="data-title">BT-158&#013;&#010;Item classification identifier&#013;&#010;Ein Code für die Klassifizierung des Postens nach Typ bzw. Art oder Wesen bzw.
                Beschaffenheit.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                      <xsl:value-of select="xr:ITEM_INFORMATION/xr:Item_classification_identifier" />
                    </div>
                  </div>
                  <div class="boxzeile" role="listitem">
                    <div class="boxdaten legende">
                      <xsl:value-of select="xrf:_('xr:Item_classification_identifier/@scheme_identifier')" />:
                    </div>
                    <div data-title="BT-158-scheme-id" class="BT-158-scheme-id boxdaten wert">
                      <xsl:attribute name="data-title">scheme-id-bt-158&#013;&#010;Item classification identifier/Scheme identifier&#013;&#010;Die Kennung des Bildungsschemas für das Informationselement BT-158.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                      <xsl:value-of
                        select="xr:ITEM_INFORMATION/xr:Item_classification_identifier/@scheme_identifier" />
                    </div>
                  </div>
                  <div class="boxzeile" role="listitem">
                    <div class="boxdaten legende">
                      <xsl:value-of select="xrf:_('xr:Item_classification_identifier/@scheme_version_identifier')" />:
                    </div>
                    <div data-title="BT-158-scheme-version-id" class="BT-158-scheme-version-id boxdaten wert">
                      <xsl:attribute name="data-title">scheme-version-id-bt-158&#013;&#010;Item classification identifier/Scheme version identifier&#013;&#010;Die Version des Bildungsschemas für das Informationselement BT-158.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                      <xsl:value-of
                        select="xr:ITEM_INFORMATION/xr:Item_classification_identifier/@scheme_version_identifier" />
                    </div>
                  </div>
                  <div class="boxzeile" role="listitem">
                    <div class="boxdaten legende">
                      <xsl:value-of select="xrf:_('xr:Item_country_of_origin')" />:
                    </div>
                    <div class="BT-159 boxdaten wert">
                      <xsl:attribute name="data-title">BT-159&#013;&#010;Item country of origin&#013;&#010;Der Ländercode, der das Land angibt, aus dem die Ware stammt oder in dem die
                Dienstleistung erbracht wird.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
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
      <div class="BT-160 boxdaten legende">
        <xsl:attribute name="data-title">BT-160&#013;&#010;Item attribute name&#013;&#010;Der Name der Eigenschaft des Postens, wie z. B. Farbe.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
        <xsl:value-of select="xr:Item_attribute_name" />
      </div>
      <div class="BT-161 boxdaten wert">
        <xsl:attribute name="data-title">BT-161&#013;&#010;Item attribute value&#013;&#010;Der Wert der Eigenschaft des Postens, wie z. B. rot.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
        <xsl:value-of select="xr:Item_attribute_value" />
      </div>
    </div>
  </xsl:template>

    <xsl:template name="sub_invoice_eigenschaft" match="xr:SUB_INVOICE_ITEM_ATTRIBUTES">
        <div class="boxzeile" role="listitem">
            <div class="BT-160 boxdaten legende">
        <xsl:attribute name="data-title">BT-160&#013;&#010;Item attribute name&#013;&#010;Der Name der Eigenschaft des Postens, wie z. B. Farbe.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
        <xsl:value-of select="xr:Item_attribute_name" />
      </div>
      <div class="BT-161 boxdaten wert">
        <xsl:attribute name="data-title">BT-161&#013;&#010;Item attribute value&#013;&#010;Der Wert der Eigenschaft des Postens, wie z. B. rot.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
        <xsl:value-of select="xr:Item_attribute_value" />
      </div>
        </div>
    </xsl:template>
    
    
    <xsl:template name="zusaetze">
        <div id="zusaetze" class="divHide" role="tabpanel" aria-labelledby="menueZusaetze" tabindex="0">
            <div class="haftungausschluss">
                <xsl:value-of select="xrf:_('_disclaimer')" />
            </div>
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
            <div class="BG-4 boxtitel" role="heading" aria-level="2">
              <xsl:attribute name="data-title">BG-4&#013;&#010;SELLER&#013;&#010;Eine Gruppe von Informationselementen, die Informationen über den Verkäufer
        enthalten.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
              <xsl:value-of select="xrf:_('uebersichtVerkaeufer')" />
            </div>
            <div class="boxtabelle boxinhalt borderSpacing" role="list">
                <div class="boxzeile" role="listitem">
                    <div class="boxdaten legende">
                        <xsl:value-of select="xrf:_('xr:Seller_trading_name')" />:
                    </div>
                    <div class="BT-28 boxdaten wert">
                      <xsl:attribute name="data-title">BT-28&#013;&#010;Seller trading name&#013;&#010;Ein Name, unter dem der Verkäufer bekannt ist, sofern abweichend vom Namen des
        Verkäufers.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                      <xsl:value-of select="xr:Seller_trading_name" />
                    </div>
                </div>
                <div class="boxzeile" role="listitem">
                    <div class="boxdaten legende">
                        <xsl:value-of select="xrf:_('xr:Seller_country_subdivision')" />:
                    </div>
                    <div class="BT-39 boxdaten wert">
                      <xsl:attribute name="data-title">BT-39&#013;&#010;Seller country subdivision&#013;&#010;Die Unterteilung eines Landes (wie Region, Bundesland, Provinz
        etc.).&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                      <xsl:value-of select="xr:SELLER_POSTAL_ADDRESS/xr:Seller_country_subdivision" />
                    </div>
                </div>
                <div class="boxzeile" role="listitem">
                    <div class="boxdaten legende">
                        <xsl:value-of select="xrf:_('xr:Seller_electronic_address')" />:
                    </div>
                    <div class="BT-34 boxdaten wert">
                      <xsl:attribute name="data-title">BT-34&#013;&#010;Seller electronic address&#013;&#010;Gibt die elektronische Adresse des Verkäufers an, an die die Antwort der Anwendungsebene auf eine Rechnung
                gesendet werden kann.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                      <xsl:value-of select="xr:Seller_electronic_address" />
                    </div>
                </div>
                <div class="boxzeile" role="listitem">
                    <div class="boxdaten legende">
                        <xsl:value-of select="xrf:_('xr:Seller_electronic_address/@scheme_identifier')" />:
                    </div>
                    <div data-title="BT-34-scheme-id" class="BT-34-scheme-id boxdaten wert">
                      <xsl:attribute name="data-title">scheme-id-bt-34&#013;&#010;Seller electronic address/Scheme identifier&#013;&#010;Das Bildungsschema für BT-34.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                      <xsl:value-of select="xr:Seller_electronic_address/@scheme_identifier" />
                    </div>
                </div>
                <div class="boxzeile" role="listitem">
                    <div class="boxdaten legende">
                        <xsl:value-of select="xrf:_('xr:Seller_legal_registration_identifier')" />:
                    </div>
                    <div class="BT-30 boxdaten wert">
                      <xsl:attribute name="data-title">BT-30&#013;&#010;Seller legal registration identifier&#013;&#010;Eine von einer offiziellen Registrierstelle ausgegebene Kennung, die den
        Verkäufer als Rechtsträger oder juristische Person identifiziert.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                      <xsl:value-of select="xr:Seller_legal_registration_identifier" />
                    </div>
                </div>
                <div class="boxzeile" role="listitem">
                    <div class="boxdaten legende">
                        <xsl:value-of select="xrf:_('xr:Seller_legal_registration_identifier/@scheme_identifier')" />:
                    </div>
                    <div data-title="BT-30-scheme-id" class="BT-30-scheme-id boxdaten wert">
                      <xsl:attribute name="data-title">scheme-id-bt-30&#013;&#010;Seller legal registration identifier/Scheme identifier&#013;&#010;Das für das Element BT-30 geltende Schema.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                      <xsl:value-of select="xr:Seller_legal_registration_identifier/@scheme_identifier" />
                    </div>
                </div>
                
                <div class="boxzeile" role="listitem">
                    <div class="boxdaten legende">
                        <xsl:value-of select="xrf:_('xr:Seller_VAT_identifier')" />:
                    </div>
                    <div class="BT-31 boxdaten wert">
                      <xsl:attribute name="data-title">BT-31&#013;&#010;Seller VAT identifier&#013;&#010;Die Umsatzsteuer-Identifikationsnummer des Verkäufers. Verfügt der Verkäufer
        über eine solche, ist sie hier anzugeben, sofern nicht Angaben zum BG-11
            gemacht werden.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                      <xsl:value-of select="xr:Seller_VAT_identifier" />
                    </div>
                </div>
                <div class="boxzeile" role="listitem">
                    <div class="boxdaten legende">
                        <xsl:value-of select="xrf:_('xr:Seller_tax_registration_identifier')" />:
                    </div>
                    <div class="BT-32 boxdaten wert">
                      <xsl:attribute name="data-title">BT-32&#013;&#010;Seller tax registration identifier&#013;&#010;Eine örtliche steuerrechtliche Kennung des Verkäufers (bestimmt durch dessen
        Adresse) oder ein Verweis auf seinen eingetragenen Steuerstatus. (Hier ist ggf. die Angabe
                Steuerschuldnerschaft des Leistungsempfängers oder die USt-Befreiung des Rechnungsstellers
        einzutragen.)&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                      <xsl:value-of select="xr:Seller_tax_registration_identifier" />
                    </div>
                </div>
                <div class="boxzeile" role="listitem">
                    <div class="boxdaten legende">
                        <xsl:value-of select="xrf:_('xr:Seller_additional_legal_information')" />:
                    </div>
                    <div class="BT-33 boxdaten wert">
                      <xsl:attribute name="data-title">BT-33&#013;&#010;Seller additional legal information&#013;&#010;Weitere rechtliche Informationen, die für den Verkäufer maßgeblich sind (wie z.
        B. Grundkapital).&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                      <xsl:value-of select="xr:Seller_additional_legal_information" />
                    </div>
                </div>
                <div class="boxzeile" role="listitem">
                    <div class="boxdaten legende">
                        <xsl:value-of select="xrf:_('xr:VAT_accounting_currency_code')" />:
                    </div>
                    <div class="BT-6 boxdaten wert">
                      <xsl:attribute name="data-title">BT-6&#013;&#010;VAT accounting currency code&#013;&#010;Die für die Umsatzsteuer-Abrechnungs- und -Meldezwecke verwendete Währung, die
                im Land des Verkäufers gültig ist oder verlangt wird.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                      <xsl:value-of select="../xr:VAT_accounting_currency_code" />
                    </div>
                </div>
            </div>
        </div>
    </xsl:template>
    

  <xsl:template name="zusaetzeSteuervertreter" match="xr:SELLER_TAX_REPRESENTATIVE_PARTY">
    <div id="zusaetzeSteuervertreter" class="box boxZweispaltig">
      <div class="BG-11 boxtitel" role="heading" aria-level="2">
        <xsl:attribute name="data-title">BG-11&#013;&#010;SELLER TAX REPRESENTATIVE PARTY&#013;&#010;Eine Gruppe von Informationselementen, die Informationen über den
        Steuervertreter des Verkäufers enthalten.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
        <xsl:value-of select="xrf:_('zusaetzeSteuervertreter')" />
      </div>
      <div class="boxtabelle boxinhalt borderSpacing" role="list">
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Seller_tax_representative_name')" />:
          </div>
          <div class="BT-62 boxdaten wert">
            <xsl:attribute name="data-title">BT-62&#013;&#010;Seller tax representative name&#013;&#010;Der vollständige Name des Steuervertreters des Verkäufers.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:Seller_tax_representative_name" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Tax_representative_address_line_1')" />:
          </div>
          <div class="BT-64 boxdaten wert">
            <xsl:attribute name="data-title">BT-64&#013;&#010;Tax representative address line 1&#013;&#010;Die Hauptzeile in einer Anschrift. Üblicherweise ist dies entweder Strasse und
        Hausnummer oder der Text Postfach gefolgt von der Postfachnummer.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of
              select="xr:SELLER_TAX_REPRESENTATIVE_POSTAL_ADDRESS/xr:Tax_representative_address_line_1" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Tax_representative_address_line_2')" />:
          </div>
          <div class="BT-65 boxdaten wert">
            <xsl:attribute name="data-title">BT-65&#013;&#010;Tax representative address line 2&#013;&#010;Eine zusätzliche Adresszeile in einer Anschrift, die verwendet werden kann, um
        weitere Einzelheiten in Ergänzung zur Hauptzeile anzugeben.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of
              select="xr:SELLER_TAX_REPRESENTATIVE_POSTAL_ADDRESS/xr:Tax_representative_address_line_2" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Tax_representative_address_line_3')" />:
          </div>
          <div class="BT-164 boxdaten wert">
            <xsl:attribute name="data-title">BT-164&#013;&#010;Tax representative address line 3&#013;&#010;Eine zusätzliche Adresszeile in einer Anschrift, die verwendet werden kann, um
        weitere Einzelheiten in Ergänzung zur Hauptzeile anzugeben.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of
              select="xr:SELLER_TAX_REPRESENTATIVE_POSTAL_ADDRESS/xr:Tax_representative_address_line_3" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Tax_representative_post_code')" />:
          </div>
          <div class="BT-67 boxdaten wert">
            <xsl:attribute name="data-title">BT-67&#013;&#010;Tax representative post code&#013;&#010;Die Postleitzahl.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of
              select="xr:SELLER_TAX_REPRESENTATIVE_POSTAL_ADDRESS/xr:Tax_representative_post_code" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Tax_representative_city')" />:
          </div>
          <div class="BT-66 boxdaten wert">
            <xsl:attribute name="data-title">BT-66&#013;&#010;Tax representative city&#013;&#010;Die Bezeichnung der Stadt oder Gemeinde, in der sich die Anschrift des
        Steuervertreters befindet.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:SELLER_TAX_REPRESENTATIVE_POSTAL_ADDRESS/xr:Tax_representative_city" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Tax_representative_country_subdivision')" />:
          </div>
          <div class="BT-68 boxdaten wert">
            <xsl:attribute name="data-title">BT-68&#013;&#010;Tax representative country subdivision&#013;&#010;Die Unterteilung eines Landes.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of
              select="xr:SELLER_TAX_REPRESENTATIVE_POSTAL_ADDRESS/xr:Tax_representative_country_subdivision" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Tax_representative_country_code')" />:
          </div>
          <div class="BT-69 boxdaten wert">
            <xsl:attribute name="data-title">BT-69&#013;&#010;Tax representative country code&#013;&#010;Ein Code, mit dem das Land bezeichnet wird.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of
              select="xr:SELLER_TAX_REPRESENTATIVE_POSTAL_ADDRESS/xr:Tax_representative_country_code" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Seller_tax_representative_VAT_identifier')" />:
          </div>
          <div class="BT-63 boxdaten wert">
            <xsl:attribute name="data-title">BT-63&#013;&#010;Seller tax representative VAT identifier&#013;&#010;Die Umsatzsteuer-Identifikationsnummer des Steuervertreters des
            Verkäufers.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:Seller_tax_representative_VAT_identifier" />
          </div>
        </div>
      </div>
    </div>
  </xsl:template>


  <xsl:template name="zusaetzeKaeufer" match="xr:BUYER" mode="zusaetze">
    <div id="zusaetzeKaeufer" class="box boxZweispaltig">
      <div class="BG-7 boxtitel" role="heading" aria-level="2">
        <xsl:attribute name="data-title">BG-7&#013;&#010;BUYER&#013;&#010;Eine Gruppe von Informationselementen, die Informationen über den Erwerber
        enthalten.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
        <xsl:value-of select="xrf:_('zusaetzeKaeufer')" />
      </div>
      <div class="boxtabelle boxinhalt borderSpacing" role="list">
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Buyer_trading_name')" />:
          </div>
          <div class="BT-45 boxdaten wert">
            <xsl:attribute name="data-title">BT-45&#013;&#010;Buyer trading name&#013;&#010;Eine Gruppe von Informationselementen, die Informationen über den Erwerber
        enthalten.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:Buyer_trading_name" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Buyer_country_subdivision')" />:
          </div>
          <div class="BT-54 boxdaten wert">
            <xsl:attribute name="data-title">BT-54&#013;&#010;Buyer country subdivision&#013;&#010;Die Unterteilung eines Landes (wie Region, Bundesland, Provinz
        etc.).&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:BUYER_POSTAL_ADDRESS/xr:Buyer_country_subdivision" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Buyer_electronic_address')" />:
          </div>
                    <div class="BT-30 boxdaten wert">
                      <xsl:attribute name="data-title">BT-30&#013;&#010;Seller legal registration identifier&#013;&#010;Eine von einer offiziellen Registrierstelle ausgegebene Kennung, die den
        Verkäufer als Rechtsträger oder juristische Person identifiziert.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                      <xsl:value-of select="xr:Seller_legal_registration_identifier" />
                    </div>
                </div>
                <div class="boxzeile" role="listitem">
                    <div class="boxdaten legende">
                        <xsl:value-of select="xrf:_('xr:Seller_legal_registration_identifier/@scheme_identifier')"/>: </div>
                    <div data-title="BT-30-scheme-id" class="BT-30-scheme-id boxdaten wert">
                      <xsl:attribute name="data-title">scheme-id-bt-30&#013;&#010;Seller legal registration identifier/Scheme identifier&#013;&#010;Das für das Element BT-30 geltende Schema.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
                      <xsl:value-of select="xr:Seller_legal_registration_identifier/@scheme_identifier"/>
                    </div>
                </div>
                <div class="boxzeile" role="listitem">
                    <div class="boxdaten legende">
                        <xsl:value-of select="xrf:_('xr:Seller_VAT_identifier')" />:
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Buyer_electronic_address/@scheme_identifier')" />:
          </div>
          <div data-title="BT-49-scheme-id" class="BT-49-scheme-id boxdaten wert">
            <xsl:attribute name="data-title">scheme-id-bt-49&#013;&#010;Buyer electronic address/Scheme identifier&#013;&#010;Gibt eine elektronische Adresse des Erwerbers an, an die eine Rechnung gesendet werden sollte.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:Buyer_electronic_address/@scheme_identifier" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Buyer_legal_registration_identifier')" />:
          </div>
          <div class="BT-47 boxdaten wert">
            <xsl:attribute name="data-title">BT-47&#013;&#010;Buyer legal registration identifier&#013;&#010;Ein von einer offiziellen Registrierstelle ausgegebener Bezeichner, der den
        Erwerber als Rechtsträger oder juristische Person identifiziert. Z. B.
        Handelsregister-Eintrag, Vereinsregister etc.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:Buyer_legal_registration_identifier" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Buyer_legal_registration_identifier/@scheme_identifier')" />:
          </div>
          <div data-title="BT-47-scheme-id" class="BT-47-scheme-id boxdaten wert">
            <xsl:attribute name="data-title">scheme-id-bt-47&#013;&#010;Buyer legal registration identifier/Scheme identifier&#013;&#010;Die Kennung des Bildungsschemas für den BT-47.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:Buyer_legal_registration_identifier/@scheme_identifier" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Buyer_VAT_identifier')" />:
          </div>
          <div class="BT-48 boxdaten wert">
            <xsl:attribute name="data-title">BT-48&#013;&#010;Buyer VAT identifier&#013;&#010;Die Umsatzsteuer-Identifikationsnummer des Erwerbers.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:Buyer_VAT_identifier" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Buyer_accounting_reference')" />:
          </div>
          <div class="BT-19 boxdaten wert">
            <xsl:attribute name="data-title">BT-19&#013;&#010;Buyer accounting reference&#013;&#010;Ein Textwert, der angibt, an welcher Stelle die betreffenden Daten in den
        Finanzkonten des Erwerbers zu buchen sind.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="../xr:Buyer_accounting_reference" />
          </div>
        </div>
      </div>
    </div>
  </xsl:template>


  <xsl:template name="zusaetzeLieferung" match="xr:DELIVERY_INFORMATION">
    <div id="zusaetzeLieferung" class="box boxZweispaltig">
      <div class="BG-13 boxtitel" role="heading" aria-level="2">
        <xsl:attribute name="data-title">BG-13&#013;&#010;DELIVERY INFORMATION&#013;&#010;Eine Gruppe von Informationselementen, die Informationen darüber enthalten, wo
        und wann die in Rechnung gestellten Waren und Dienstleistungen geliefert bzw. erbracht
        werden.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
        <xsl:value-of select="xrf:_('zusaetzeLieferung')" />
      </div>
      <div class="boxtabelle boxinhalt borderSpacing" role="list">
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Deliver_to_location_identifier')" />:
          </div>
          <div class="BT-71 boxdaten wert">
            <xsl:attribute name="data-title">BT-71&#013;&#010;Deliver to location identifier&#013;&#010;Ein Bezeichner für den Ort, an den die Waren geliefert oder an dem die
        Dienstleistungen erbracht werden.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:Deliver_to_location_identifier" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Deliver_to_location_identifier/@scheme_identifier')" />:
          </div>
          <div data-title="BT-71-scheme-id" class="BT-71-scheme-id boxdaten wert">
            <xsl:attribute name="data-title">scheme-id-bt-71&#013;&#010;Deliver to location identifier/Scheme identifier&#013;&#010;Die Kennung des Bildungsschemas für den BT-71.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:Deliver_to_location_identifier/@scheme_identifier" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Actual_delivery_date')" />:
          </div>
          <div class="BT-72 boxdaten wert">
            <xsl:attribute name="data-title">BT-72&#013;&#010;Actual delivery date&#013;&#010;Datum, an dem die Lieferung tatsächlich erfolgt bzw. die Dienstleistung
        tatsächlich erbracht wird.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="format-date(xr:Actual_delivery_date,xrf:_('date-format'))" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Deliver_to_party_name')" />:
          </div>
          <div class="BT-70 boxdaten wert">
            <xsl:attribute name="data-title">BT-70&#013;&#010;Deliver to party name&#013;&#010;Der Name des Empfängers, an den die Waren geliefert bzw. für den die
                Dienstleistungen erbracht werden.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:Deliver_to_party_name" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Deliver_to_address_line_1')" />:
          </div>
          <div class="BT-75 boxdaten wert">
            <xsl:attribute name="data-title">BT-75&#013;&#010;Deliver to address line 1&#013;&#010;Die Hauptzeile einer Anschrift. Üblicherweise ist dies entweder Strasse und
        Hausnummer oder der Text Postfach gefolgt von der Postfachnummer.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:DELIVER_TO_ADDRESS/xr:Deliver_to_address_line_1" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Deliver_to_address_line_2')" />:
          </div>
          <div class="BT-76 boxdaten wert">
            <xsl:attribute name="data-title">BT-76&#013;&#010;Deliver to address line 2&#013;&#010;Eine zusätzliche Adresszeile in einer Anschrift, die verwendet werden kann, um
        weitere Einzelheiten in Ergänzung zur Hauptzeile anzugeben.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:DELIVER_TO_ADDRESS/xr:Deliver_to_address_line_2" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Deliver_to_address_line_3')" />:
          </div>
          <div class="BT-165 boxdaten wert">
            <xsl:attribute name="data-title">BT-165&#013;&#010;Deliver to address line 3&#013;&#010;Eine zusätzliche Adresszeile in einer Anschrift, die verwendet werden kann, um
        weitere Einzelheiten in Ergänzung zur Hauptzeile anzugeben.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:DELIVER_TO_ADDRESS/xr:Deliver_to_address_line_3" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Deliver_to_post_code')" />:
          </div>
          <div class="BT-78 boxdaten wert">
            <xsl:attribute name="data-title">BT-78&#013;&#010;Deliver to post code&#013;&#010;Die Postleitzahl.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:DELIVER_TO_ADDRESS/xr:Deliver_to_post_code" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Deliver_to_city')" />:
          </div>
          <div class="BT-77 boxdaten wert">
            <xsl:attribute name="data-title">BT-77&#013;&#010;Deliver to city&#013;&#010;Die Bezeichnung der Stadt oder Gemeinde, in der sich die Erwerberanschrift
        befindet.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:DELIVER_TO_ADDRESS/xr:Deliver_to_city" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Deliver_to_country_subdivision')" />:
          </div>
          <div class="BT-79 boxdaten wert">
            <xsl:attribute name="data-title">BT-79&#013;&#010;Deliver to country subdivision&#013;&#010;Die Unterteilung eines Landes (wie Region, Bundesland, Provinz
        etc.).&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:DELIVER_TO_ADDRESS/xr:Deliver_to_country_subdivision" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Deliver_to_country_code')" />:
          </div>
          <div class="BT-80 boxdaten wert">
            <xsl:attribute name="data-title">BT-80&#013;&#010;Deliver to country code&#013;&#010;Ein Code, mit dem das Land bezeichnet wird.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:DELIVER_TO_ADDRESS/xr:Deliver_to_country_code" />
          </div>
        </div>
      </div>
    </div>
  </xsl:template>


  <xsl:template name="zusaetzeVertrag">
    <div id="zusaetzeVertrag" class="box boxZweispaltig">
      <div class="boxtitel" role="heading" aria-level="2">
        <xsl:value-of select="xrf:_('zusaetzeVertrag')" />
      </div>
      <div class="boxtabelle boxinhalt borderSpacing" role="list">
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Tender_or_lot_reference')" />:
          </div>
          <div class="BT-17 boxdaten wert">
            <xsl:attribute name="data-title">BT-17&#013;&#010;Tender or lot reference&#013;&#010;Die Kennung der Ausschreibung oder des Loses auf die/das sich die Rechnung
        bezieht.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:Tender_or_lot_reference" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Receiving_advice_reference')" />:
          </div>
          <div class="BT-15 boxdaten wert">
            <xsl:attribute name="data-title">BT-15&#013;&#010;Receiving advice reference&#013;&#010;Eine Kennung für eine referenzierte Empfangsbestätigung.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:Receiving_advice_reference" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Despatch_advice_reference')" />:
          </div>
          <div class="BT-16 boxdaten wert">
            <xsl:attribute name="data-title">BT-16&#013;&#010;Despatch advice reference&#013;&#010;Eine Kennung für eine referenzierte Versandanzeige.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:Despatch_advice_reference" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Business_process_type_identifier')" />:
          </div>
          <div class="BT-23 boxdaten wert">
            <xsl:attribute name="data-title">BT-23&#013;&#010;Business process type&#013;&#010;Identifiziert den Kontext des Geschäftsprozesses, in dem die Transaktion
                erfolgt. Er ermöglicht es dem Erwerber, die Rechnung in angemessener Weise zu verarbeiten.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:PROCESS_CONTROL/xr:Business_process_type_identifier" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Specification_identifier')" />:
          </div>
          <div class="BT-24 boxdaten wert">
            <xsl:attribute name="data-title">BT-24&#013;&#010;Specification identifier&#013;&#010;Eine Kennung der Spezifikation, die das gesamte Regelwerk zum semantischen
        Inhalt, zu den Kardinalitäten und den Geschäftsregeln enthält, denen die in der Rechnung
        enthaltenen Daten entsprechen.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:PROCESS_CONTROL/xr:Specification_identifier" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Invoiced_object_identifier')" />:
          </div>
          <div class="BT-18 boxdaten wert">
            <xsl:attribute name="data-title">BT-18&#013;&#010;Invoiced object identifier&#013;&#010;Eine vom Verkäufer angegebene Kennung für ein Objekt, auf das sich die Rechnung bezieht (z. B. Zählernummer, Telefonnummer, Kfz-Kennzeichen, versicherte Person, Abonnement-Nummer, Rufnummer).&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:Invoiced_object_identifier" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Invoiced_object_identifier/@scheme_identifier')" />:
          </div>
          <div data-title="BT-18-scheme-id" class="BT-18-scheme-id boxdaten wert">
            <xsl:attribute name="data-title">bt-18-scheme-id&#013;&#010;Invoiced object identifier/Scheme identifier&#013;&#010;Die Kennung des Bildungsmusters der Objektkennung.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:Invoiced_object_identifier/@scheme_identifier" />
          </div>
        </div>
      </div>
    </div>
  </xsl:template>


  <xsl:template name="zusaetzeZahlungsempfaenger" match="xr:PAYEE">
    <div id="zusaetzeZahlungsempfaenger" class="box boxZweispaltig">
      <div class="BG-10 boxtitel" role="heading" aria-level="2">
        <xsl:attribute name="data-title">BG-10&#013;&#010;PAYEE&#013;&#010;Eine Gruppe von Informationselementen, die Informationen über den
        Zahlungsempfänger enthalten. Die Gruppe wird genutzt, wenn der Zahlungsempfänger nicht mit dem
        Verkäufer identisch ist.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
        <xsl:value-of select="xrf:_('zusaetzeZahlungsempfaenger')" />
      </div>
      <div class="boxtabelle boxinhalt borderSpacing" role="list">
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Payee_name')" />:
          </div>
          <div class="BT-59 boxdaten wert">
            <xsl:attribute name="data-title">BT-59&#013;&#010;Payee name&#013;&#010;Eine Gruppe von Informationselementen, die Informationen über den
        Zahlungsempfänger enthalten. Die Gruppe wird genutzt, wenn der Zahlungsempfänger nicht mit dem
        Verkäufer identisch ist.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:Payee_name" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Payee_identifier')" />:
          </div>
          <div class="BT-60 boxdaten wert">
            <xsl:attribute name="data-title">&#013;&#010;&#013;&#010;&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:Payee_identifier" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Payee_identifier/@scheme_identifier')" />:
          </div>
          <div data-title="BT-60-scheme-id" class="BT-60-scheme-id boxdaten wert">
            <xsl:attribute name="data-title">BT-60&#013;&#010;Payee identifier&#013;&#010;Eine Kennung für den Zahlungsempfänger.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:Payee_identifier/@scheme_identifier" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Payee_legal_registration_identifier')" />:
          </div>
          <div class="BT-61 boxdaten wert">
            <xsl:attribute name="data-title">BT-61&#013;&#010;Payee legal registration identifier&#013;&#010;Eine von einer offiziellen Registrierstelle ausgegebene Kennung, die den
        Zahlungsempfänger als einen Rechtsträger oder eine juristische Person
        identifiziert.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:Payee_legal_registration_identifier" />
          </div>
        </div>
        <div class="boxzeile" role="listitem">
          <div class="boxdaten legende">
            <xsl:value-of select="xrf:_('xr:Payee_legal_registration_identifier/@scheme_identifier')" />:
          </div>
          <div data-title="BT-61-scheme-id" class="BT-61-scheme-id boxdaten wert">
            <xsl:attribute name="data-title">scheme-id-bt-61&#013;&#010;Payee legal registration identifier/Scheme identifier&#013;&#010;Das für das Element BT-61 geltende Schema.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
            <xsl:value-of select="xr:Payee_legal_registration_identifier/@scheme_identifier" />
          </div>
        </div>
      </div>
    </div>
  </xsl:template>


  <xsl:template name="anlagen">
    <div id="anlagen" class="divHide" role="tabpanel" aria-labelledby="menueAnlagen" tabindex="0">
      <div class="haftungausschluss">
        <xsl:value-of select="xrf:_('_disclaimer')" />
      </div>
      <div class="boxtabelle boxabstandtop">
        <div class="boxzeile">
          <div id="anlagenListe" class="box">
            <div class="BG-24 boxtitel" role="heading" aria-level="2">
              <xsl:attribute name="data-title">BG-24&#013;&#010;ADDITIONAL SUPPORTING DOCUMENTS&#013;&#010;Eine Gruppe von Informationselementen mit Informationen über
        rechnungsbegründende Unterlagen, die Belege für die in der Rechnung gestellten Ansprüche
        enthalten.s&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
              <xsl:value-of select="xrf:_('anlagenListe')" />
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
        <div class="boxdaten legende">
          <xsl:value-of select="xrf:_('xr:Supporting_document_reference')" />:
        </div>
        <div class="BT-122 boxdaten wert">
          <xsl:attribute name="data-title">BT-122&#013;&#010;Supporting document reference&#013;&#010;Eine Kennung der rechnungsbegründenden Unterlage.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
          <xsl:value-of select="xr:Supporting_document_reference" />
        </div>
      </div>
      <div class="boxzeile" role="listitem">
        <div class="boxdaten legende">
          <xsl:value-of select="xrf:_('xr:Supporting_document_description')" />:
        </div>
        <div class="BT-123 boxdaten wert">
          <xsl:attribute name="data-title">BT-123&#013;&#010;Supporting document description&#013;&#010;Eine Beschreibung der rechnungsbegründenden Unterlage.s&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
          <xsl:value-of select="xr:Supporting_document_description" />
        </div>
      </div>
      <div class="boxzeile" role="listitem">
        <div class="boxdaten legende">
          <xsl:value-of select="xrf:_('xr:External_document_location')" />:
        </div>
        <div class="BT-124 boxdaten wert">
          <xsl:attribute name="data-title">BT-124&#013;&#010;External document location&#013;&#010;Die Internetadresse bzw. URL (Uniform Resource Locator), unter der das externe
        Dokument verfügbar ist.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
          <a href="{xr:External_document_location}" target="_blank">
            <xsl:value-of select="xr:External_document_location" />
          </a>
        </div>
      </div>
        
      <div class="boxzeile" role="listitem">
        <div class="boxdaten legende">
          <xsl:value-of select="xrf:_('xr:Attached_document')" />:
        </div>
        <!-- HTML5 restrictions for id attribute: must contain at least 1 character, can't contain any space characters -->
        <!-- JS restrictions for param in getElementById(id), in this case $doc-ref-id: case-sensitive string unique within the document -->
          <xsl:variable name="doc-ref-id" as="xs:string" select="translate(normalize-space(xr:Supporting_document_reference), ' ', '-')"/>
        <div class="BT-125 boxdaten wert">
          <xsl:attribute name="data-title">BT-125&#013;&#010;Attached document&#013;&#010;Ein als Binärobjekt eingebettetes Anhangsdokument.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
        <xsl:choose>
            <xsl:when test="empty(xr:Attached_document/text())">
                <xsl:value-of select="xrf:_('no-data')" />
            </xsl:when>
            <xsl:otherwise>
                <a href="#{$doc-ref-id}" onClick="downloadData('{$doc-ref-id}', '{xr:Attached_document/@mime_code}', '{xr:Attached_document/@filename}')">
                    <xsl:value-of select="xrf:_('_open')" />
                </a>    
            </xsl:otherwise>
        </xsl:choose>    
        </div>
          <div id="{$doc-ref-id}" style="display:none;">
          <xsl:value-of select="xr:Attached_document" />
        </div>

      </div>
        
        
      <div class="boxzeile" role="listitem">
        <div class="boxdaten legende">
          <xsl:value-of select="xrf:_('xr:Attached_document/@mime_code')" />:
        </div>
        <div class="BT-125 boxdaten wert">
          <xsl:attribute name="data-title">mime-code-bt-125&#013;&#010;Attached document/Attached document Mime code&#013;&#010;Der MIME Code des eingebetteten Anhangsdokumentes.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
          <xsl:value-of select="xr:Attached_document/@mime_code" />
        </div>
      </div>
      <div class="boxzeile" role="listitem">
        <div class="boxdaten legende">
          <xsl:value-of select="xrf:_('xr:Attached_document/@filename')" />:
        </div>
        <div class="BT-125 boxdaten wert">
          <xsl:attribute name="data-title">doc-filename-bt-125&#013;&#010;Attached document/Attached document Filename&#013;&#010;Der Dateiname des eingebetteten Anhangsdokumentes. Dieser muss innerhalb
          einer Rechnung eindeutig sein (nicht case-sensitiv). Die Dateinamenserweiterung
          (extension), in der meist der Typ der Datei angegeben wird, ist dabei Teil des Dateinamens
          und wird bei der Bestimmung der Eindeutigkeit einbezogen.&#013;&#010;<xsl:value-of select="@xr:src"/></xsl:attribute>
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
            <div class="boxtitel" role="heading" aria-level="2">
              <xsl:value-of select="xrf:_('laufzettelHistorie')" />
            </div>
            <xsl:apply-templates select="./xrv:laufzettel/xrv:laufzettelEintrag" />
          </div>
        </div>
      </div>
    </div>
  </xsl:template>


  <xsl:template match="xrv:laufzettelEintrag">
    <div class="boxtabelle boxinhalt borderSpacing" role="list">
      <div class="boxzeile" role="listitem">
        <div class="boxdaten legende">
          <xsl:value-of select="xrf:_('xrv:zeitstempel')" />:
        </div>
        <div class="boxdaten wert">
          <xsl:value-of select="format-dateTime(xrv:zeitstempel,xrf:_('datetime-format'))" />
        </div>
      </div>
      <div class="boxzeile" role="listitem">
        <div class="boxdaten legende">
          <xsl:value-of select="xrf:_('xrv:betreff')" />:
        </div>
        <div class="boxdaten wert">
          <xsl:value-of select="xrv:betreff" />
        </div>
      </div>
      <div class="boxzeile" role="listitem">
        <div class="boxdaten legende">
          <xsl:value-of select="xrf:_('xrv:text')" />:
        </div>
        <div class="boxdaten wert">
          <xsl:value-of select="xrv:text" />
        </div>
      </div>
      <div class="boxzeile" role="listitem">
        <div class="boxdaten legende">
          <xsl:value-of select="xrf:_('xrv:details')" />:
        </div>
        <div class="boxdaten wert">
          <xsl:value-of select="xrv:details" />
        </div>
      </div>
    </div>
  </xsl:template>

</xsl:stylesheet>
