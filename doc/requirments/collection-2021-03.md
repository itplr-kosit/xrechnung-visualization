# Requirement Collection 2021-03
<!-- markdownlint-disable MD003 MD013 -->


## Agenda:

1. KoSIT Visualisierungs-Komponente im Vergleich zu vollen Viewer Produkt.
2. Open Source / Kollaboration
3. Generelle Anmerkungen zur Entwicklung Zeitlinie
4. Durchgang durch Requirements


* Aus NEB Kontext: Umwandler mitliefern
* Vollwertiges PDF heisst native erstellt (nciht durch Druckversion einer Brwoserdarstellung)

* Hasken: Guter Einwand, die Visualisierung könnte dem Umfang der 
Rechnung folgen!

Es existieren Loesungen von
Paulwitz
de.NRW
Bayern hat Barrierefreiheit in PDF

## Table of Requirements


 <table cellspacing="0" border="4">
         <thead>
            <tr>
               <th>Nr.</th>
               <th>Kurzname</th>
               <th>Beschreibung</th>
               <th>Anforderungstyp</th>
               <th>Abhaengig von</th>
               <th>Anforderung an Visualisierungskomponente</th>
               <th>Anforderung an ein Vollprodukt</th>
            </tr>
         </thead>
         <tbody>
            <tr>
               <td>
                  <a href="#html">1</a>
               </td>
               <td id="html">html</td>
               <td>HTML-Ausgabe</td>
               <td>functional</td>
               <td>
                  <a href="#"/>
               </td>
               <td/>
               <td/>
            </tr>
            <tr>
               <td>
                  <a href="#html-responsive">2</a>
               </td>
               <td id="html-responsive">html-responsive</td>
               <td>HTML Responsive</td>
               <td>functional</td>
               <td>
                  <a href="#html">html</a>
               </td>
               <td>Kann default Responsive vorgeben</td>
               <td>Muss es sich seiner Umgebung anpassen</td>
            </tr>
            <tr>
               <td>
                  <a href="#pdf">3</a>
               </td>
               <td id="pdf">pdf</td>
               <td>Vollwertige PDF-Ausgabe (PDF/A)</td>
               <td>functional</td>
               <td>
                  <a href="#"/>
               </td>
               <td/>
               <td/>
            </tr>
            <tr>
               <td>
                  <a href="#pdf-accessible">4</a>
               </td>
               <td id="pdf-accessible">pdf-accessible</td>
               <td>vollwertige PDF-Ausgabe (PDF/UA), wegen der zwingenden Anforderung hinsichtlich
            Barrierefreiheit</td>
               <td>functional</td>
               <td>
                  <a href="#pdf">pdf</a>
               </td>
               <td/>
               <td/>
            </tr>
            <tr>
               <td>
                  <a href="#log">5</a>
               </td>
               <td id="log">log</td>
               <td>Protokoll-Ausgaben während der Transformationsschritte</td>
               <td>functional</td>
               <td>
                  <a href="#"/>
               </td>
               <td>Bietet die Transformatoren</td>
               <td>Muss logging bei der Ausfuehrung selber vornehmen</td>
            </tr>
            <tr>
               <td>
                  <a href="#configurability">6</a>
               </td>
               <td id="configurability">configurability</td>
               <td>Konfigurierbarkeit der Darstellung</td>
               <td>functional</td>
               <td>
                  <a href="#"/>
               </td>
               <td>Gibt eine Darstellung vor (die dem Standard genuegt)</td>
               <td>Muss sich die Darstellung fuer seinen Einsatzbereich anpassen</td>
            </tr>
            <tr>
               <td>
                  <a href="#css-standalone">7</a>
               </td>
               <td id="css-standalone">css-standalone</td>
               <td>Standalone CSS</td>
               <td>development</td>
               <td>
                  <a href="#"/>
               </td>
               <td/>
               <td/>
            </tr>
            <tr>
               <td>
                  <a href="#compact-view">8</a>
               </td>
               <td id="compact-view">compact-view</td>
               <td>Rechnungspositionen sollen tabellarisch dargestellt werden koennen.</td>
               <td>functional</td>
               <td>
                  <a href="#pdf">pdf</a>
               </td>
               <td/>
               <td/>
            </tr>
            <tr>
               <td>
                  <a href="#hierarchical-lines">9</a>
               </td>
               <td id="hierarchical-lines">hierarchical-lines</td>
               <td>Hierarchische Darstellung der Gliederungsebenen von Rechnungspositionen</td>
               <td>functional</td>
               <td>
                  <a href="#"/>
               </td>
               <td>Gliederungsebenen mit einem Default erkennbar mit machen</td>
               <td>unterschiedliche Formatierungen zu deren Hervorhebung anzubieten oder festzulegen</td>
            </tr>
            <tr>
               <td>
                  <a href="#show-standard-data-only">10</a>
               </td>
               <td id="show-standard-data-only">show-standard-data-only</td>
               <td>Alle Daten die im Standard vorgesehen sind und befuellt sind, werden dargestellt.</td>
               <td>functional</td>
               <td>
                  <a href="#"/>
               </td>
               <td/>
               <td/>
            </tr>
            <tr>
               <td>
                  <a href="#standard-data-with-content">11</a>
               </td>
               <td id="standard-data-with-content">standard-data-with-content</td>
               <td>Nur Standard Daten darstellen</td>
               <td>functional</td>
               <td>
                  <a href="#show-standard-data-only">show-standard-data-only</a>
               </td>
               <td/>
               <td/>
            </tr>
            <tr>
               <td>
                  <a href="#label-fields">12</a>
               </td>
               <td id="label-fields">label-fields</td>
               <td>Beschriftung aller Felder</td>
               <td>functional</td>
               <td>
                  <a href="#"/>
               </td>
               <td/>
               <td/>
            </tr>
            <tr>
               <td>
                  <a href="#page-numbers">13</a>
               </td>
               <td id="page-numbers">page-numbers</td>
               <td>Seitennummerierung</td>
               <td>functional</td>
               <td>
                  <a href="#pdf">pdf</a>
               </td>
               <td/>
               <td/>
            </tr>
            <tr>
               <td>
                  <a href="#separate-fields">14</a>
               </td>
               <td id="separate-fields">separate-fields</td>
               <td>Visuelle Kennzeichnung der Uebermittelten Daten</td>
               <td>functional</td>
               <td>
                  <a href="#"/>
               </td>
               <td/>
               <td/>
            </tr>
            <tr>
               <td>
                  <a href="#fluent-layout">15</a>
               </td>
               <td id="fluent-layout">fluent-layout</td>
               <td>Idealerweise keine sprunghaften Layout-Änderungen der Visualisierung</td>
               <td>functional</td>
               <td>
                  <a href="#configurability">configurability</a>
               </td>
               <td>Keine Aufgabe der Komponnte</td>
               <td>Muss dies genaess seiner Einsatzumgebung optimieren</td>
            </tr>
            <tr>
               <td>
                  <a href="#show-bt-number">16</a>
               </td>
               <td id="show-bt-number">show-bt-number</td>
               <td>Standard Kennungen anzeigen</td>
               <td>functional</td>
               <td>
                  <a href="#"/>
               </td>
               <td/>
               <td/>
            </tr>
            <tr>
               <td>
                  <a href="#pdf-element-positioning">17</a>
               </td>
               <td id="pdf-element-positioning">pdf-element-positioning</td>
               <td>Die Positionierung der Inhalte im PSD soll immer gleichbleibend sein. (Forderung ist
            vermutlich durch eingesetzte Technologie implizit gewährleistet)</td>
               <td>functional</td>
               <td>
                  <a href="#pdf">pdf</a>
               </td>
               <td>Kann eine Default Vorgabe machen</td>
               <td>Muss das sicherstellen und gewaehrleisten</td>
            </tr>
            <tr>
               <td>
                  <a href="#completness">18</a>
               </td>
               <td id="completness">completness</td>
               <td>Vollständigkeitsabsicherung</td>
               <td>functional</td>
               <td>
                  <a href="#"/>
               </td>
               <td/>
               <td/>
            </tr>
            <tr>
               <td>
                  <a href="#display-extension">19</a>
               </td>
               <td id="display-extension">display-extension</td>
               <td>Das syntaxneutrale Format muss alle Inhalte aus dem Syntax-Binding der europäischen
            Norm Und der XRechnugn Extension erfassen.</td>
               <td>functional</td>
               <td>
                  <a href="#"/>
               </td>
               <td/>
               <td/>
            </tr>
            <tr>
               <td>
                  <a href="#zahlungsbedingungen">20</a>
               </td>
               <td id="zahlungsbedingungen">zahlungsbedingungen</td>
               <td>Atomare Zerlegung von Zahlungsbedingungen</td>
               <td>functional</td>
               <td>
                  <a href="#"/>
               </td>
               <td>Es wird nur in dem Detailgerad wie der Standard es vorgibt zerlegt</td>
               <td>Kann weitere Zerlegung gemaess der Anforderungen seiner Kunden vornehmen</td>
            </tr>
            <tr>
               <td>
                  <a href="#display-non-standard-data">21</a>
               </td>
               <td id="display-non-standard-data">display-non-standard-data</td>
               <td>Inhalte im Rechnungsoriginal, die nicht vom Syntax-Binding der europäischen Norm bzw.
            der nationalen Extension erfasst sind, werden als Ergänzungsinformation in der
            Visualisierung dargestellt. Nicht erfasste Inhalte werden zudem über die LOG-Ausgabe der
            Transformationen protokolliert.</td>
               <td>functional</td>
               <td>
                  <a href="#"/>
               </td>
               <td/>
               <td/>
            </tr>
            <tr>
               <td>
                  <a href="#display-all-cius">22</a>
               </td>
               <td id="display-all-cius">display-all-cius</td>
               <td>Unterstützung der Kernrechnung EN 16931, darauf aufbauender CIUSe sowie der XRechnung
            Extension</td>
               <td>functional</td>
               <td>
                  <a href="#"/>
               </td>
               <td/>
               <td/>
            </tr>
            <tr>
               <td>
                  <a href="#display-spec-id">23</a>
               </td>
               <td id="display-spec-id">display-spec-id</td>
               <td>Spezifikationskennung erkennbar machen</td>
               <td>functional</td>
               <td>
                  <a href="#"/>
               </td>
               <td/>
               <td/>
            </tr>
            <tr>
               <td>
                  <a href="#show-codelist-values">24</a>
               </td>
               <td id="show-codelist-values">show-codelist-values</td>
               <td>Auf Codelisten basierende Datenwerte werden im Zwischenformat um zusätzliche,
            natürlichsprachliche Bezeichnungen ergänzt.</td>
               <td>functional</td>
               <td>
                  <a href="#"/>
               </td>
               <td/>
               <td/>
            </tr>
            <tr>
               <td>
                  <a href="#show-codelist-values-translated">25</a>
               </td>
               <td id="show-codelist-values-translated">show-codelist-values-translated</td>
               <td>Übersetzung der technischen Codes (z.B. Maßeinheit, Zahlweg, Rechnungsart, etc.). Also
            nicht: „XPP“ für eine Einheit, „S“ bei der Umsatzsteuer, „58“ für Code für das
            Zahlungsmittel, „380“ bei Rechnungsart, …</td>
               <td>functional</td>
               <td>
                  <a href="#show-codelist-values">show-codelist-values</a>
               </td>
               <td/>
               <td/>
            </tr>
            <tr>
               <td>
                  <a href="#handle-missing-codelist-value-translations">26</a>
               </td>
               <td id="handle-missing-codelist-value-translations">handle-missing-codelist-value-translations</td>
               <td>Die Code-Listen sollen hierzu übersetzt werden. Für Codes ohne verfügbare Übersetzung
            soll die englischsprachige Originalbezeichnung angezeigt werden und eine entsprechende
            LOG-Ausgabe erfolgen. Für Codes ohne englischsprachige Originalbezeichnung soll der
            CODE-Wert (gegebenenfalls mit dem Hinweis „unbekannter Schlüsselwert“) ausgegeben werden
            und es erfolgt ebenfalls eine LOG-Ausgabe</td>
               <td>functional</td>
               <td>
                  <a href="#show-codelist-values-translated">show-codelist-values-translated</a>
               </td>
               <td>Keine Aufgabe der Komponnte</td>
               <td>Da Uebersetzung im Vollprodukt ist, hier auch die Fehlerbehandlung</td>
            </tr>
            <tr>
               <td>
                  <a href="#show-codelist-value-and-code">27</a>
               </td>
               <td id="show-codelist-value-and-code">show-codelist-value-and-code</td>
               <td>In der Ausgabe wird sowohl der ursprüngliche Code als auch die zugehörige
            natürlichsprachliche Bezeichnung ausgegeben. Im Ausgabelayout tritt die
            natürlichsprachliche Bezeichnung in den Vordergrund.</td>
               <td>functional</td>
               <td>
                  <a href="#show-codelist-values">show-codelist-values</a>
               </td>
               <td/>
               <td/>
            </tr>
            <tr>
               <td>
                  <a href="#schematron-messages">28</a>
               </td>
               <td id="schematron-messages">schematron-messages</td>
               <td>Warnmeldungen der Schematronprüfung</td>
               <td>functional</td>
               <td>
                  <a href="#"/>
               </td>
               <td/>
               <td/>
            </tr>
            <tr>
               <td>
                  <a href="#show-specific-validation-results">29</a>
               </td>
               <td id="show-specific-validation-results">show-specific-validation-results</td>
               <td>Anzeige von Valiedierungsinformationen</td>
               <td>functional</td>
               <td>
                  <a href="#"/>
               </td>
               <td/>
               <td/>
            </tr>
            <tr>
               <td>
                  <a href="#shown-belegart">30</a>
               </td>
               <td id="shown-belegart">shown-belegart</td>
               <td>Die Belegart soll „prominent“ platziert werden, sodass die Vorgangsart direkt sichtbar
            ist.</td>
               <td>functional</td>
               <td>
                  <a href="#"/>
               </td>
               <td/>
               <td/>
            </tr>
            <tr>
               <td>
                  <a href="#shown-invoice-type">31</a>
               </td>
               <td id="shown-invoice-type">shown-invoice-type</td>
               <td>Die Rechnungsart sollte ganz oben deutlich hervorgehoben dargestellt werden, damit
            sofort ersichtlich ist, ob es sich um eine Rechnung, Korrektur oder Gutschrift
            handelt.</td>
               <td>functional</td>
               <td>
                  <a href="#"/>
               </td>
               <td/>
               <td/>
            </tr>
            <tr>
               <td>
                  <a href="#separate-from-original">32</a>
               </td>
               <td id="separate-from-original">separate-from-original</td>
               <td>Die Visualisierung soll eine entsprechende Markierung (Wasserzeichen, Fußnote o.ä.)
            ausweisen (zur Abgrenzung vom eigentlichen Original)</td>
               <td>functional</td>
               <td>
                  <a href="#"/>
               </td>
               <td/>
               <td/>
            </tr>
            <tr>
               <td>
                  <a href="#protal-hints">33</a>
               </td>
               <td id="protal-hints">protal-hints</td>
               <td>Anpassbarer Hinweistext (z. B. Kopfzeile: Alle Angaben stammen vom Sender der
            Rechnung. Beim zentralen Rechnungseingang findet keine inhaltliche Prüfung der gemachten
            Angaben statt.)</td>
               <td>functional</td>
               <td>
                  <a href="#"/>
               </td>
               <td>Keine Aufgabe der Komponnte</td>
               <td>Aufgabe einer Vollloesung</td>
            </tr>
            <tr>
               <td>
                  <a href="#display-inbox-date">34</a>
               </td>
               <td id="display-inbox-date">display-inbox-date</td>
               <td>Möglichkeit zur Anzeige des Eingangsdatums</td>
               <td>functional</td>
               <td>
                  <a href="#"/>
               </td>
               <td/>
               <td/>
            </tr>
            <tr>
               <td>
                  <a href="#portal-referenz">35</a>
               </td>
               <td id="portal-referenz">portal-referenz</td>
               <td>Mögliche Anzeige der vom ZRE erzeugten eindeutigen Rechnungsreferenz (ZRE-ID)</td>
               <td>functional</td>
               <td>
                  <a href="#"/>
               </td>
               <td>Keine Aufgabe der Komponnte</td>
               <td>Muss Vollprodukt machen</td>
            </tr>
            <tr>
               <td>
                  <a href="#add-pdf-properties">36</a>
               </td>
               <td id="add-pdf-properties">add-pdf-properties</td>
               <td>die Befüllung der PDF-Eigenschaften (für eine künftig mögliche Vorbelegung
            strukturierter Felder in E-Akte)</td>
               <td>functional</td>
               <td>
                  <a href="#pdf">pdf</a>
               </td>
               <td/>
               <td/>
            </tr>
            <tr>
               <td>
                  <a href="#operation">37</a>
               </td>
               <td id="operation">operation</td>
               <td>Unterstützung einer zentralen, serverseitigen Durchführung der Visualisierung</td>
               <td>functional</td>
               <td>
                  <a href="#"/>
               </td>
               <td/>
               <td/>
            </tr>
            <tr>
               <td>
                  <a href="#key-information">38</a>
               </td>
               <td id="key-information">key-information</td>
               <td>Ergänzung von Schlüsselinformationen in allen Ausgabeobjekten zur Gewährleistung des
            Bezugspunkts. Diese sollen umfassen</td>
               <td>functional</td>
               <td>
                  <a href="#"/>
               </td>
               <td/>
               <td/>
            </tr>
            <tr>
               <td>
                  <a href="#metadata-belegart">39</a>
               </td>
               <td id="metadata-belegart">metadata-belegart</td>
               <td>i. Belegart</td>
               <td>functional</td>
               <td>
                  <a href="#"/>
               </td>
               <td/>
               <td/>
            </tr>
            <tr>
               <td>
                  <a href="#metadata-specification-identifier">40</a>
               </td>
               <td id="metadata-specification-identifier">metadata-specification-identifier</td>
               <td>ii. Spezifikationskennung</td>
               <td>functional</td>
               <td>
                  <a href="#"/>
               </td>
               <td/>
               <td/>
            </tr>
            <tr>
               <td>
                  <a href="#metadata-belegnummer">41</a>
               </td>
               <td id="metadata-belegnummer">metadata-belegnummer</td>
               <td>iii. Belegnummer</td>
               <td>functional</td>
               <td>
                  <a href="#"/>
               </td>
               <td/>
               <td/>
            </tr>
            <tr>
               <td>
                  <a href="#metadata-belegdatum">42</a>
               </td>
               <td id="metadata-belegdatum">metadata-belegdatum</td>
               <td>iv. Belegdatum</td>
               <td>functional</td>
               <td>
                  <a href="#"/>
               </td>
               <td/>
               <td/>
            </tr>
            <tr>
               <td>
                  <a href="#data-seller-identity">43</a>
               </td>
               <td id="data-seller-identity">data-seller-identity</td>
               <td>v. Identität des Rechnungsstellers</td>
               <td>functional</td>
               <td>
                  <a href="#"/>
               </td>
               <td/>
               <td/>
            </tr>
            <tr>
               <td>
                  <a href="#data-leitweg-id">44</a>
               </td>
               <td id="data-leitweg-id">data-leitweg-id</td>
               <td>vi. Leitweg-ID</td>
               <td>functional</td>
               <td>
                  <a href="#"/>
               </td>
               <td/>
               <td/>
            </tr>
            <tr>
               <td>
                  <a href="#display-time-of-transformation">45</a>
               </td>
               <td id="display-time-of-transformation">display-time-of-transformation</td>
               <td>vii. Zeitpunkt der Transformation</td>
               <td>functional</td>
               <td>
                  <a href="#"/>
               </td>
               <td/>
               <td/>
            </tr>
            <tr>
               <td>
                  <a href="#diplay-product-name-and-version">46</a>
               </td>
               <td id="diplay-product-name-and-version">diplay-product-name-and-version</td>
               <td> viii. Produkt- und Versionskennung der Generierungskomponente</td>
               <td>functional</td>
               <td>
                  <a href="#"/>
               </td>
               <td>Keine Aufgabe der Komponnte</td>
               <td>Standard way: Has to name itself and give its Version. May mention the component it is based on.</td>
            </tr>
            <tr>
               <td>
                  <a href="#operation-zwischenformat">47</a>
               </td>
               <td id="operation-zwischenformat">operation-zwischenformat</td>
               <td>Syntaxvereinheitlichung im Zwischenformat</td>
               <td>functional</td>
               <td>
                  <a href="#"/>
               </td>
               <td/>
               <td/>
            </tr>
            <tr>
               <td>
                  <a href="#coding-of-dates">48</a>
               </td>
               <td id="coding-of-dates">coding-of-dates</td>
               <td>Datumskodierung unabhängig von Syntax des Originalbelegs</td>
               <td>functional</td>
               <td>
                  <a href="#"/>
               </td>
               <td/>
               <td/>
            </tr>
            <tr>
               <td>
                  <a href="#same-treatment-codelist-values">49</a>
               </td>
               <td id="same-treatment-codelist-values">same-treatment-codelist-values</td>
               <td> Vereinheitlichung von Code-Listen-Werten (Auflösen von Groß- und Kleinschreibung,
            Bereinigung von Leerräumen)</td>
               <td>functional</td>
               <td>
                  <a href="#"/>
               </td>
               <td/>
               <td/>
            </tr>
            <tr>
               <td>
                  <a href="#download-attachments">50</a>
               </td>
               <td id="download-attachments">download-attachments</td>
               <td>Download verlinkter Anlagen</td>
               <td>functional</td>
               <td>
                  <a href="#"/>
               </td>
               <td/>
               <td/>
            </tr>
            <tr>
               <td>
                  <a href="#add-attachments-to-display">51</a>
               </td>
               <td id="add-attachments-to-display">add-attachments-to-display</td>
               <td>Möglichkeit zum Beifügen weiterer Anlagen</td>
               <td>functional</td>
               <td>
                  <a href="#"/>
               </td>
               <td/>
               <td/>
            </tr>
            <tr>
               <td>
                  <a href="#pdf-printable">52</a>
               </td>
               <td id="pdf-printable">pdf-printable</td>
               <td>Ausdruck / Papier </td>
               <td>functional</td>
               <td>
                  <a href="#pdf">pdf</a>
               </td>
               <td/>
               <td/>
            </tr>
            <tr>
               <td>
                  <a href="#wide-screen-display">53</a>
               </td>
               <td id="wide-screen-display">wide-screen-display</td>
               <td>PC-Arbeitsplatz (z. B. 24 Zoll-Bildschirm; ggf. bei halbierter Bildbreite wegen
            gleichzeitiger Nutzung mit anderem Fachverfahren)</td>
               <td>functional</td>
               <td>
                  <a href="#html-responsive">html-responsive</a>
               </td>
               <td/>
               <td/>
            </tr>
            <tr>
               <td>
                  <a href="#mobile-display">54</a>
               </td>
               <td id="mobile-display">mobile-display</td>
               <td>Mobile Endgeräte (5 Zoll-Bildschirm)</td>
               <td>functional</td>
               <td>
                  <a href="#html-responsive">html-responsive</a>
               </td>
               <td/>
               <td/>
            </tr>
            <tr>
               <td>
                  <a href="#test-coverage">55</a>
               </td>
               <td id="test-coverage">test-coverage</td>
               <td>Testabdeckung der visuellen Darstellung:Es sollte sichergestellt werden, dass die vom
            Betrachter visuell erfassbaren Rechnungs-informationen sich nicht dadurch ändern, dass
            die Visualisierung einer Rechnung mit einem neuen Release der Visualisierungskomponente
            erzeugt wurde (Regressionstest). Natürlich haben dabei die Unterschiede außer Acht zu
            bleiben, die vom neuen Release bewusst eingeführt/geändert wurden. </td>
               <td>functional</td>
               <td>
                  <a href="#"/>
               </td>
               <td/>
               <td/>
            </tr>
         </tbody>
      </table>
