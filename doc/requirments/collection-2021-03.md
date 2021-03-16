# Requirement Collection 2021-03
<!-- markdownlint-disable MD003 MD013 -->

## Table of Requirements

<table cellspacing="0" border="0">
    <colgroup></colgroup>
    <colgroup></colgroup>
    <colgroup></colgroup>
    <colgroup></colgroup>
    <colgroup></colgroup>
    <tr>
        <td ><b> </b></td>
    <td><b>Anforderungen</b></td>
        <td><b>Priorisierung</b></td>
        <td><b>Fragen/Bemerkungen</b></td>
        <td><b>KoSIT Bemerkungen</b></td>
    </tr>
    <tr>
        <td>a</td>
        <td>HTML-Ausgabe</td>
        <td>10</td>
        <td></td>
        <td>-</td>
    </tr>
    <tr>
        <td>b</td>
        <td>vollwertige PDF-Ausgabe (PDF/A)</td>
        <td>10 (nicht BY)</td>
        <td></td>
        <td>-</td>
    </tr>
    <tr>
        <td></td>
        <td>vollwertige PDF-Ausgabe (PDF/UA), wegen der zwingenden Anforderung hinsichtlich Barrierefreiheit</td>
        <td>10</td>
        <td></td>
        <td>-</td>
    </tr>
    <tr>
        <td >c</td>
        <td>Protokoll-Ausgaben w&auml;hrend der Transformationsschritte</td>
        <td>10</td>
        <td>Fehlerhinweise an Admins; Logging</td>
        <td>Was ist damit gemeint? Wieso?</td>
    </tr>
    <tr>
        <td >d</td>
        <td><i>Offen ist die Frage, ob das syntaxneutrale Zwischenformat offizielles Teilprodukt (vereinheitliche Aufl&ouml;sung des Syntax-Bindings und m&ouml;gliche Datenquelle f&uuml;r die automatisierte Weiterverarbeitung) ist oder nicht;</i></td>
        <td>7</td>
        <td>Verf&uuml;gbarkeit des Zwischenformats</td>
        <td>Diese Frage ist nicht offen: Sondern ist es **NICHT**!</td>
    </tr>
    <tr>
        <td >e</td>
        <td><i>Offen ist zudem die Frage, ob HTML-Ausgabe und PDF-Ausgabe ein identisches Layout bieten m&uuml;ssen oder eine jeweils formatoptimale Variante darstellen sollten. In diesem Zusammenhang sollte auch &uuml;ber eine explizit barrierefreie Variante nachgedacht werden</i></td>
        <td></td>
        <td>gleichm&auml;&szlig;ig gepflegt und aufbereitet</td>
        <td>Das sind Formate fuer verschiedene Medien, also natuerlich unterschiedliches Look and Feel (ansonsten braeuchte man die verschiedenen Formate ja auch wiederum nicht)</td>
    </tr>
    <tr>
        <td>2.</td>
        <td>Optische Aufbereitung </td>
        <td></td>
        <td></td>
        <td>-</td>
    </tr>
    <tr>
        <td>a</td>
        <td>M&ouml;glichst &uuml;bersichtlich gestaltet</td>
        <td>10</td>
        <td></td>
        <td>Das ist zu unspezifisch, faellt evtl. eher in den Bereich Konfigurierbarkeit der Visu</td>
    </tr>
    <tr>
        <td>b</td>
        <td>Rechnungspositionen sollen tabellarisch dargestellt werden.</td>
        <td></td>
        <td>Hierarchisierung</td>
        <td>Ist is quasi schon: Standalone CSS. Rechnungszeilen in `ol` statt `div` ?</td>
    </tr>
    <tr>
        <td></td>
        <td>Tabellarische Aufstellung Rechnungspositionen</td>
        <td></td>
        <td>Zwischensummen</td>
        <td>Muesste auch schon da sein (die oberste Position ist die Zwischensumme der unteren.</td>
    </tr>
    <tr>
        <td></td>
        <td>Kompaktere Darstellung der Positionen (tabellarisch wie von Papierrechnungen gewohnt)</td>
        <td>9</td>
        <td>? Vorschl&auml;ge n&ouml;tig</td>
        <td>Redundant zu </td>
    </tr>
    <tr>
        <td>c</td>
        <td>Gliederungsebenen sollen in der Tabelle durch entsprechende Formatierung hervorgehoben werden.</td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td >d</td>
        <td>Alle im XML bef&uuml;llten Felder sind visuell darzustellen. Sollten Angaben in der Visualisierung nicht visuell aufbereitet werden k&ouml;nnen, so m&uuml;ssen dennoch alle bef&uuml;llten Felder nachvollziehbar sein. Davon unabh&auml;ngig sollten Rechnungen, die &uuml;ber die Anforderungen der EN 16931 und XRechnung Extension hinausgehen, m&ouml;glichst vom Validator zur&uuml;ckgewiesen werden.</td>
        <td></td>
        <td>Anforderung auch an Validierung</td>
        <td><ol><li>Weitere ueber EN hinausgehende Felder sind kein Verstoss, daher keine Frage der Validierung.</li>
        <li>Gesonderte Darstellung von nicht EN Feldern ist ein wichtiger Punkt</li>
        </ol></td>
    </tr>
    <tr>
        <td >e</td>
        <td>Inhaltslose Strukturen werden im Zwischenformat bereinigt und nicht in der Visualisierung aufbereitet (keine leeren Ausgabebereiche)</td>
        <td>10</td>
        <td></td>
        <td>Feature automatisch da, wenn Zwischenformat abgeschafft ist.</td>
    </tr>
    <tr>
        <td >f</td>
        <td>Beschriftung aller Felder (bereits heute so, jedoch ein deutlicher Vorteil gegen&uuml;ber Papierrechnungen in ihren unterschiedlichsten (intern.) Auspr&auml;gungen).</td>
        <td>10</td>
        <td>f&uuml;r PDF und HTML &quot;Stra&szlig;e&quot;BT-schadet nicht</td>
        <td>Was ist hier gemeint??</td>
    </tr>
    <tr>
        <td>g</td>
        <td>Seitennummerierung</td>
        <td>10</td>
        <td>Seite 1/4</td>
    </tr>
    <tr>
        <td >h</td>
        <td>Deutliche Unterscheidung zwischen den vom Rechnungssteller gelieferten Inhalten und Hinweisen/Inhalten, die von der Visualisierung hinzugef&uuml;gt wurden. Umgesetzt ist dies aktuell durch die graue Hinterlegung der &bdquo;Felder&ldquo;, in denen die vom Rechnungssteller gelieferten Eintragungen stehen. &bdquo;Formular-basierte&ldquo;-Variante</td>
        <td>10</td>
        <td>f&uuml;r Barrierrefreiheit anderweitige Hinweise</td>
        <td>Voellig unklar. Das kann sich nur auf Pruefbericht beziehen.</td>
    </tr>
    <tr>
        <td>i</td>
        <td>Idealerweise keine sprunghaften Layout-&Auml;nderungen der Visualisierung</td>
        <td>10</td>
        <td></td>
        <td>Nice to have. Wer bezahlt CSS Design Profis?</td>
    </tr>
    <tr>
        <td>3.</td>
        <td>Die Kennungen aus dem semantischen Modell sollen zu jeder Information direkt sichtbar angezeigt werden</td>
        <td></td>
        <td>s. 2f</td>
        <td>Ist einerseits doch. Oder bezieht sich das auf Pruefbericht?</td>
    </tr>
    <tr>
        <td>4.</td>
        <td>Die Positionierung der Inhalte soll immer gleichbleibend sein. (Forderung ist vermutlich durch eingesetzte Technologie implizit gew&auml;hrleistet)</td>
        <td>10</td>
        <td></td>
        <td></td>
        <td>Steht im Widerspruch zur Natur und Sind und Zweck von HTML. Was ist hier genauer gemeint? Screenshots? Zeichnungen? </td>
    </tr>
    <tr>
        <td    >5.</td>
        <td   ><b>Vollst&auml;ndigkeitsabsicherung</b></td>
        <td></td>
        <td></td>
        <td>Wichtiger Punkt</td>
    </tr>
    <tr>
        <td>a</td>
        <td>Das syntaxneutrale Format muss alle Inhalte aus dem Syntax-Binding der europ&auml;ischen Norm Und der XRechnugn Extension erfassen.</td>
        <td>10</td>
        <td></td>
        <td>Erledigt sich automatisch mit der Abschaffung des Zwischenformats</td>
    </tr>
    <tr>
        <td >c</td>
        <td>Syntaktische Konkretisierungen aus dem XRechnungs-CIUS (insbesondere Zahlungsbedingungen) sollen atomar zerlegt im syntaxneutralem Format abgebildet werden</td>
        <td>10</td>
        <td></td>
        <td>Hat nix mit Zwischenformat zu tun aber ist ein guter Punkt und umsetzbar.</td>
    </tr>
    <tr>
        <td>d</td>
        <td>Alle Inhalte im syntaxneutralen Format werden in allen Ausgabevarianten platziert und dargestellt </td>
        <td>10</td>
        <td></td>
        <td>Teil der Vollstaendigkeit</td>
    </tr>
    <tr>
        <td >e</td>
        <td>Inhalte im Rechnungsoriginal, die nicht vom Syntax-Binding der europ&auml;ischen Norm bzw. der nationalen Extension erfasst sind, werden als Erg&auml;nzungsinformation in der Visualisierung dargestellt. Nicht erfasste Inhalte werden zudem &uuml;ber die LOG-Ausgabe der Transformationen protokolliert.</td>
        <td>10</td>
        <td></td>
        <td>Siehe oben. Und es wird kein Log geben.</td>
    </tr>
    <tr>
        <td>6</td>
        <td><b>Darzustellende Inhalte</b></td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td>a</td>
        <td>Unterst&uuml;tzung der Kernrechnung EN 16931, darauf aufbauender CIUSe sowie der XRechnung Extension</td>
        <td>10</td>
        <td></td>
        <td>s.o.</td>
    </tr>
    <tr>
        <td>b</td>
        <td>Spezifikationskennung erkennbar machen</td>
        <td>10</td>
        <td></td>
        <td>Guter Punkt</td>
    </tr>
    <tr>
        <td>7.</td>
        <td>Behandlung von Codelisten-Werten </td>
        <td></td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td >a</td>
        <td>Auf Codelisten basierende Datenwerte werden im Zwischenformat um zus&auml;tzliche, nat&uuml;rlichsprachliche Bezeichnungen erg&auml;nzt.</td>
        <td>10</td>
        <td>Intergration der Codelisten mit &Uuml;bersetzung  (ins Deutsche als Wunsch)</td>
        <td></td>
    </tr>
    <tr>
        <td ></td>
        <td>&Uuml;bersetzung der technischen Codes (z.B. Ma&szlig;einheit, Zahlweg, Rechnungsart, etc.). Also nicht: &bdquo;XPP&ldquo; f&uuml;r eine Einheit, &bdquo;S&ldquo; bei der Umsatzsteuer, &bdquo;58&ldquo; f&uuml;r Code f&uuml;r das Zahlungsmittel, &bdquo;380&ldquo; bei Rechnungsart, &hellip;</td>
        <td>10</td>
        <td>Intergration der Codelisten mit &Uuml;bersetzung  (ins Deutsche als Wunsch)</td>
        <td>s.o.</td>
    </tr>
    <tr>
        <td >b</td>
        <td>Die Code-Listen sollen hierzu &uuml;bersetzt werden. F&uuml;r Codes ohne verf&uuml;gbare &Uuml;bersetzung soll die englischsprachige Originalbezeichnung angezeigt werden und eine entsprechende LOG-Ausgabe erfolgen. F&uuml;r Codes ohne englischsprachige Originalbezeichnung soll der CODE-Wert (gegebenenfalls mit dem Hinweis &bdquo;unbekannter Schl&uuml;sselwert&ldquo;) ausgegeben werden und es erfolgt ebenfalls eine LOG-Ausgabe</td>
        <td>10</td>
        <td>s. o.</td>
        <td>Mehrsprachigkeit der Codelisten ist in Arbeit. Aber noch in der fruehen Entwicklung.</td>
    </tr>
    <tr>
        <td >c</td>
        <td>In der Ausgabe wird sowohl der urspr&uuml;ngliche Code als auch die zugeh&ouml;rige nat&uuml;rlichsprachliche Bezeichnung ausgegeben. Im Ausgabelayout tritt die nat&uuml;rlichsprachliche Bezeichnung in den Vordergrund.</td>
        <td>5</td>
        <td>s.o.</td>
    </tr>
    <tr>
        <td>8.</td>
        <td>Warnmeldungen der Schematronpr&uuml;fung</td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td ></td>
        <td>k&ouml;nnten ggf. in der Visualisierung und in Zusammenhang mit den betroffenen Elementen ausgegeben werden. Der Umgang mit Warnungen m&uuml;sste in diesem Zusammenhang allerdings grunds&auml;tzlich betrachtet werden, zumal die eigentlichen Rechnungssachbearbeiter nicht mit technischen Meldungen &uuml;bersch&uuml;ttet werden sollen. </td>
        <td   sdval="3">3</td>
        <td></td>
        <td>Das ist nur mit Zusammenlegung von Pruefebricht mit Visu moeglich!!! Aber gerne!</td>
    </tr>
    <tr>
        <td>9.</td>
        <td><b>Weitergehende Markierungen/Hinweise</b></td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td>a</td>
        <td>Die Belegart soll &bdquo;prominent&ldquo; platziert werden, sodass die Vorgangsart direkt sichtbar ist.</td>
        <td>10</td>
        <td></td>
        <td>Was ist gemeint?</td>
    </tr>
    <tr>
        <td ></td>
        <td>Die Rechnungsart sollte ganz oben deutlich hervorgehoben dargestellt werden, damit sofort ersichtlich ist, ob es sich um eine Rechnung, Korrektur oder Gutschrift handelt.</td>
        <td>10</td>
        <td></td>
        <td>Guter Punkt</td>
    </tr>
    <tr>
        <td >b</td>
        <td>Die Visualisierung soll eine entsprechende Markierung (Wasserzeichen, Fu&szlig;note o.&auml;.) ausweisen (zur Abgrenzung vom eigentlichen Original)</td>
        <td>10</td>
        <td>&quot;Visualisierung der Rechnung&quot; o.&Auml;. ; kein Wasserzeichen; z. B. am Seitenrand des PDF; individuell</td>
        <td>Fuer wen ist das wichtig?</td>
    </tr>
    <tr>
        <td></td>
        <td>Gestaltung der Visualisierung soll keine Verwechselungsgefahr mit dem Rechnungsoriginal hervorrufen k&ouml;nnen</td>
        <td>10</td>
        <td>s.o.</td>
    </tr>
    <tr>
        <td>c</td>
        <td>Anpassbarer Hinweistext (z. B. Kopfzeile: Alle Angaben stammen vom Sender der Rechnung. Beim zentralen Rechnungseingang findet keine inhaltliche Pr&uuml;fung der gemachten Angaben statt.)</td>
        <td>10</td>
        <td>Quellangaben; individuelle Platzhalter</td>
    </tr>
    <tr>
        <td>d</td>
        <td>M&ouml;glichkeit zur Anzeige des Eingangsdatums</td>
        <td>10</td>
        <td>s. 9d</td>
        <td>Frage der Konfigurierbarkeit. Und eigentlich so nur mit Zusammenlegung mit Pruefbericht</td>
    </tr>
    <tr>
        <td>e</td>
        <td>M&ouml;gliche Anzeige der vom ZRE erzeugten eindeutigen Rechnungsreferenz (ZRE-ID)</td>
        <td>10</td>
        <td>als Zusatzfunktion m&ouml;glich?</td>
           <td>Frage der Konfigurierbarkeit. Und eigentlich so nur mit Zusammenlegung mit Pruefbericht</td>
    </tr>
    <tr>
        <td>f</td>
        <td>die Bef&uuml;llung der PDF-Eigenschaften (f&uuml;r eine k&uuml;nftig m&ouml;gliche Vorbelegung strukturierter Felder in E-Akte)</td>
        <td   sdval="7">7</td>
        <td>BaW&uuml;, RLP</td>
        <td>Frage der Konfigurierbarkeit. Welche sollen das sein?</td>
    </tr>
    <tr>
        <td    >10.</td>
        <td   >Betrieb / Plattformunabh&auml;ngigkeit / Kompatibilit&auml;t </td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td ></td>
        <td>Unterst&uuml;tzung einer zentralen, serverseitigen Durchf&uuml;hrung der Visualisierung</td>
        <td>10 (Clientseitige Umsetzung wird nicht verfolgt; Prio 1)</td>
        <td>mindestens serverseitig umgesetzt; clientbasiert m&ouml;glich, aber nicht zwingend; in erster Linie ausgerichtet am Bedarf der &ouml;ff. AG auch mit Portal; Server bleibt im Zust.-bereich der jew. Instanz</td>
           <td>Keine KoSIT Frage</td>
    </tr>
    <tr>
        <td    >11.</td>
        <td   ><b>Metadaten</b></td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td ></td>
        <td>Erg&auml;nzung von Schl&uuml;sselinformationen in allen Ausgabeobjekten zur Gew&auml;hrleistung des Bezugspunkts. Diese sollen umfassen</td>
        <td   sdval="7">7</td>
        <td></td>
    </tr>
    <tr>
        <td></td>
        <td>i. Belegart</td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td></td>
        <td> ii. Spezifikationskennung</td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td></td>
        <td> iii. Belegnummer</td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td></td>
        <td> iv. Belegdatum</td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td></td>
        <td> v. Identit&auml;t des Rechnungsstellers</td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td></td>
        <td> vi. Leitweg-ID</td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td></td>
        <td> vii. Zeitpunkt der Transformation</td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td></td>
        <td> viii. Produkt- und Versionskennung der Generierungskomponente</td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td    >12.</td>
        <td   >Syntaxvereinheitlichung im Zwischenformat</td>
        <td>?</td>
        <td>Aussage zur Nutzbarkeit des Zwischenformats; Pflege gew&auml;hrleisten (Feldbeschreibung, verl&auml;ssliches Vorgehen)</td>
    </tr>
    <tr>
        <td>a</td>
        <td>Datumskodierung unabh&auml;ngig von Syntax des Originalbelegs</td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td>b</td>
        <td> Vereinheitlichung von Code-Listen-Werten (Aufl&ouml;sen von Gro&szlig;- und Kleinschreibung, Bereinigung von Leerr&auml;umen)</td>
        <td></td>
        <td>Frage an Validierung</td>
    </tr>
    <tr>
        <td    >13.</td>
        <td   >Behandlung von Anlagen</td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td >a</td>
        <td>Download verlinkter Anlagen und Einbettung im Zwischenformat</td>
        <td   sdval="0">0</td>
        <td>getrennte Sichtweisen f&uuml;r PDF und XML; gro&szlig;e Dateien nicht darstellbar; keine Darstellung von Anlagen</td>
    </tr>
    <tr>
        <td>b</td>
        <td>M&ouml;glichkeit zum Beif&uuml;gen weiterer Anlagen</td>
        <td   sdval="0">0</td>
        <td></td>
    </tr>
    <tr>
        <td    >14.</td>
        <td   >Ausgabeoptimierung f&uuml;r unterschiedliche Medien / Ger&auml;te</td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td>a</td>
        <td>Ausdruck / Papier </td>
        <td>10</td>
        <td>ausdruckbar</td>
    </tr>
    <tr>
        <td >b</td>
        <td>PC-Arbeitsplatz (z. B. 24 Zoll-Bildschirm; ggf. bei halbierter Bildbreite wegen gleichzeitiger Nutzung mit anderem Fachverfahren)</td>
        <td>10</td>
        <td>PDF, HTML-responsive </td>
    </tr>
    <tr>
        <td >c</td>
        <td>Mobile Endger&auml;te (5 Zoll-Bildschirm)</td>
        <td   sdval="1">1</td>
        <td>Anforderungen im Wandel und steigern sich wahrscheinlich</td>
    </tr>
    <tr>
        <td     sdval="15">15</td>
        <td   ><b>Bereitstellung</b></td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td >a</td>
        <td>Testabdeckung der visuellen Darstellung:Es sollte sichergestellt werden, dass die vom Betrachter visuell  erfassbaren Rechnungs-informationen sich nicht dadurch &auml;ndern, dass die Visualisierung einer Rechnung mit einem neuen Release der Visualisierungskomponente erzeugt wurde (Regressionstest). Nat&uuml;rlich haben dabei die Unterschiede au&szlig;er Acht zu bleiben, die vom neuen Release bewusst eingef&uuml;hrt/ge&auml;ndert wurden. </td>
        <td>10</td>
        <td></td>
    </tr>
    <tr>
        <td>b</td>
        <td>Support</td>
        <td>10</td>
        <td>n&auml;her zu bestimmen? Analog Validierung? </td>
    </tr>
    <tr>
        <td>c</td>
        <td>dauerhafte Pflege, Weiterentwicklung und geeignete Bereitstellung</td>
        <td>10</td>
        <td></td>
    </tr>
    <tr>
        <td     sdval="16">16</td>
        <td   ><b>Entwicklungspotential</b></td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td ></td>
        <td>Modifikationsm&ouml;glichkeit f&uuml;r eigene Anpassungen (bereits heute so), um z.B. ZRE spezifische Anpassungen vornehmen zu k&ouml;nnen, vgl. oben. K&uuml;nftig typische Anforderungen m&ouml;glichst durch Belegung von Variablen gestaltbar.</td>
        <td>10</td>
        <td>feste Konfigurationsm&ouml;glichkeiten f&uuml;r die Platzhalter</td>
    </tr>
</table>
