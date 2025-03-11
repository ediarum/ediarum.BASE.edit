# CHANGELOG ediarum.BASE.edit 

## 2.X.X. vom XX.XX.XXXX

* BUGFIX #25: Wert für "Latein" korrigiert.

## 2.0.0 vom 22.12.2021
 
* FEATURE #14914: Variantenapparat
* FEATURE #14329: BREAKING CHANGE! Umstellung @xml:id der templates auf Perma-ID aus ediarum.DB 4.0.1
* FEATURE #14702: Schreibeakte einer Person aus dem Register zuordnen (@hand für writingSession	
* BUGFIX #12876: Einführungszitate werden richtig eingefügt; Aufgabe #14838: kleinere Schemaanpassungen
* BUGFIX #13090: Listenwerte im Schema und im CSS geändert/angepasst
* BUGFIX #14445: Aktion funktioniert jetzt auch im Textbereich
* BUGFIX 14838: CSS quote/hi[@rendition='#i'] font-type=normal
* UPDATE: Add a 'don't show XML comments' in ediarum.INTRO-CSS
* UPDATE: Add a 'don't show XML comments' in ediarum.BASE-CSS
* BUGFIX #14728: gender-appropriate language for ediarum.INTRO
* BUGFIX #13280: Fehler in Aktion `index_places`
 
## 1.2.0 vom 19.07.2019
 
* FEATURE #12170: Revisionshistorie kann angelegt werden
* FEATURE #12198: Anpassungen in ediarum.INTRO
 
## 1.1.1 vom 19.03.2019

* BUGFIX #9728: Update Action head for inserting list/head
 
## 1.1.0 vom 18.12.2018
 
* BUGFIX #10670: Verweis auf Brief (Author-Modus Funktion) funktioniert nicht
* BUGFIX #11059: Falsche Pfade in CSS für Verlinkung von &lt;ref>-Elementen (links.css)
* BUGFIX #11082: Fehler in der Aktion "correspAction[received]_placeName" (Empfangsort)
* FEATURE #11171: ediarum.INTRO für Einleitungstexte
 
## 1.0.2 vom 17.09.2018
 
* BUGFIX #10692: Link für correspContext/ref in CSS korrigiert
 
## 1.0.1 vom 17.09.2018
 
* BUGFIX #10692: Aktion bibl korrigiert; Aktionen ref, ref[note] und rs[term] auf ediarum.jar Version 2018 geupdated
* UPDATE #10692: New editor variabe ${ediarum_projects_directory_webdav}
 
## 1.0.0 vom 22.08.2018

* BREAKING CHANGE: Neue Editorvariablen ${ediarum_projects_directory} und ${ediarum_website_path}
* UPDATE #8744: Neue Benutzervariable wegen Rewrite
* UPDATE #8745: Reihenfolge der Toolbars
* BUGFIX #9309: @reason='illegible' in del-gap ergänzen
* FEATURE #9309: Reihenfolge für Aktion gap otpimiert
* FEATURE #9309: Option @reason='covered' ergänzen
* BUGFIX #9578: ediarum Autormodus: Bei unlesbarer Streichung @reason für &lt;gap/> abfragen!
* FEATURE #9971: Kennzeichnung von gedruckten Textvorlagen
* BUGFIX #10009: Link-Funktion für ref/@target
* BUGFIX #10086: Alternativer Name in Unterort
* UPDATE #10121: Neue ediarum.jar
* UPDATE #10121: Migrieren von alten zu den neuen Registeraktionen
* FEATURE #10252: ediarum.jar: Funktionen auf neue Funktionssyntax umstellen
* UPDATE #10287: CSS-Ansichten restrukturieren, CSS aufräumen
* UPDATE #10288: Entferne obsoletes ediarum_basis_readonly
* UPDATE #10289: Update templates
* UPDATE #10290: Überflüssige Aktionen in ediarum.BASIS entfernen
* BUGFIX #10339: Sortierung Werkregister
* FEATURE #10344: Verlinkungen im Institutions- und Sachregister ermöglichen
* UPDATE #10348: ediarum.REGISTER in eigenes Add-on packen
* UPDATE #10349: Registerfunktionen in ediarum.REGISTER updaten
* FEATURE #10370: Sachregister: Alternative Bennenung eines Stichworts
* UPDATE #10587: ediarum-Komponenten umbenennen
* BUGFIX #10086: Fehler beim Einfügen von Unterorten im Register
* BUGFIX #10289: Templates aktualisieren
* UPDATE #10569: Pfadangabe in CSS durch Editorvariable ersetzen
* UPDATE #6371: Im Basisframework die Aktionen mit oxy:allows-child-element versehen
* FEATURE #7376: Operation zum Einfügen XML-Fragmenten in korrekter Reihenfolge
 
## 0.27.0 vom 24.04.2018
 
* FEATURE #8672: Werktitel aus Zotero in Kommentar eines Personenregistereintrags verlinken
* FEATURE #9589: Author-Funktion für Notation von Minuten-Zeichen
* BUGFIX #9245: Schema lässt abstract als first child nicht zu
* BUGFIX #9313: Fehler im Autormodus, Registerfunktion, Anaphern:
* BUGFIX #9426: Funktion "Folio mit Link zum Digitalisat" produziert Fehler
* FEATURE #8724: Schaltfläche zum Handbuch
* FEATURE #8859: Dokument: Institution als Autor
* FEATURE #8942: Alternative Titel für Zeitschriften/Periodika	
 	
## 0.26.0 vom 11.08.2017
 
* FEATURE #8310: Nummerierung der Briefe für print-Ausgabe
* FEATURE #8493: @cert in Korrespondenz-Metadaten
* FEATURE #8492: Gedicht/Strophe (lg) im Menü verfügbar
* FEATURE #7910: ediarum für Drucktexte
* FEATURE #8636: Auszeichnung von Firmen in Handschriftenbeschreibung
* FEATURE #8599: Sonderfunktion Einrückung von Absätzen und Listen
* FEATURE #8653: Rearrangieren der Menüs "Allgemein" und "Brieftext"
* UPDATE #8703: Update ediarum.jar auf Version 2.2.0    

## 0.25.0 vom 16.06.2017
 
* FEATURE #8380: Schlagworte/Themen für Briefe und Dokumente
* FEATURE #8379: Personenauszeichnung in Handschriftenbeschreibung
* FEATURE #8485: Aktion: Verlinkung in "Anmerkungen zum Text"
* FEATURE #8449: Verlinkung von Beilagen
* FEATURE #8448: Mehrfache "Anmerkung zum Brief"
* BUGFIX #8475: Darstellung von Verweisen in "Anmerkungen zum Brief"
* BUGFIX #7853: Funktion "Auszeichnung löschen" für Firmennamen fehlerhaft
* BUGFIX #8478: ñ wird falsch ausgespielt
 
## 0.24.0 vom 15.05.2017
 
* BUGFIX #7291: Funktion "Sachanmerkung löschen" fehlerhaft
* BUGFIX #8315: Verweis auf Sachanmerkung verwendet falsches Attribut (@key statt @target)
* BUGFIX #8316: Darstellung im Author-Mode für Streichung entfernt vorhandene Formatierung
* FEATURE #6209: Tabelle sichtbar/unsichtbar
* FEATURE #7339: Bildunterschrift
* FEATURE #7367: &lt;hi> darf nicht in &lt;idno> erlaubt sein
* FEATURE #7548: @hand='unknown'
* FEATURE #7608: Schriftwechsel in Antiqua
* FEATURE #7720: Aktion für fette Textstellen
* FEATURE #7747: &lt;metamark/> in &lt;p/>
* FEATURE #7833: Erweiterung von @hand in &lt;note/> und &lt;figure/>
* FEATURE #7910: ediarum für Drucktexte erweitern (Teilimplementierung)
* FEATURE #8201: Aktion: Link auf externe Website
* FEATURE #8212: Aktion: Textauslassungen: Unwichtig eingestufter Text
 
## 0.23.1 vom 09.12.2016
 
* BUGFIX: 7536: Kalliope-URI einfügen
* BUGFIX: 7501: Copy & Paste
 
## 0.23.0 vom 14.11.2016
 
* FEATURE #6441: Lösung für die Kodierung und Beschreibung von Skizzen, Zeichnungen, etc.
* FEATURE #6970: Registerfunktionen erweitern
* BUGFIX #6179: Cursor-Position bei Arbeit in Autoransicht
* BUGFIX #7131: &lt;note/> in &lt;note/>: Einweisungszeichen, Autoransicht
* BUGFIX #7132: &lt;note/>: lb soll gesetzt werden können
* BUGFIX #7220: orgName im Register mit Pfeil angezeigt
* BUGFIX #7258: 6. Druckvorlage
* FEATURE #6167: Werte von @place erweitern
* FEATURE #6209: Tabelle sichtbar/unsichtbar
* FEATURE #6232: Mousonover-Text zu "Unsicheren Lesarten" vereinheitlichen
* FEATURE #6245: Mehrere Handschriften in teiHeader notieren
* UPDATE #6256: damage durch gap ersetzen
* FEATURE #7134: @hand in &lt;note/> erweitern
* FEATURE #7256: Verlinkung von Druckzeugen mit Registereintrag

## 0.22.0 vom 02.11.2016
 
* BUGFIX #6780: &lt;TEI xmlns...> in Registerdateien validiert nicht
* BUGFIX #6790: Funktion "Register sortieren" funktioniert nicht
* BUGFIX #6871: Negative Jahreszahlen validieren nicht
* BUGFIX #6902: Aktion "Absender (Organisation)" überprüfen
* BUGFIX #7086: Darstellung hochgestellter Zeichen in der Handschriftenbeschreibung
* FEATURE #6323: Auswahlmenü für "Sicherheit der Datierung"
* FEATURE #6402: Funktion für die Dokumentation der editorischen Verantwortung
* FEATURE #6599: Dreipunktzeichen in "Symbole" integrieren
* FEATURE #7023: Umgang mit leeren Seiten und Faksimiles (Dateinennung und Workflow ediarum)
* FEATURE #7198: ediarum.Register: Rolle einer Person bei musischen Werken

## 0.21.0 vom 18.10.2016

* FEATURE #6108: Zoteroanbindung
 
## 0.20.0 vom 05.09.2016
 
* UPDATE 6838: CSS für AvH-R Nebenrechungen
* FEATURE 6243: Druckzeugen als Textgrundlage bestimmen
* FEATURE #6683: Vorgedruckter Text in Manuskripten
* FEATURE #6653: Anmerkungen zum Text 
* FEATURE #6396: Textpassage als erledigt markieren
* FEATURE #6630: Identifizierung mit persName als unsicher kennzeichnen
* FEATURE #6832: Externe Websites in Register &lt;note> verlinken
* FEATURE #6827: Personen, Orte und Organisationen in Registereinträgen verlinken
* BUGFIX #6769: Standortangabe funktionsfähig und optimiert
* FEATURE #6738: Randstrich kodieren
* FEATURE 6211: Absätze in &lt;note>
 
## 0.19.0 vom 02.08.2016
 
* BUGFIX #6629: Die GeoNames-Funktion funktioniert nicht für Unterorte
* FEATURE #6246: Auszeichnungen von kursiven und gesperrten Wörtern in Drucktexten
* FEATURE #6639: Erweiterung des Menüpunktes "Symbole"
 
## 0.18.0 vom 26.07.2016

* UPDATE #6264: Author-Erweiterung Status Listener
* BUGFIX #6197: Adresse einfügen in Briefen nicht möglich
* BUGFIX #6324: Neueinträge in einrichtungen.xml bekommen unvollständiges Markup
* BUGFIX  #6326: Benutzung von "Symbole > Bruchzahlen" derzeit unklar
* BUGFIX  #6567: Register: Norm-ID kann nicht in Unterorte eingefügt werden
* BUGFIX  #6610: Art der Textgrundlage funktioniert nicht in Textsorte "Dokument"
* FEATURE #6178: Kodierung für Einfügezeichen
* FEATURE #6262: Tabellen-Ausrichtung
* FEATURE #6394: Verweise auf externe Quellen
* FEATURE #6515: Menü "ediarum" einrichten
* FEATURE #6568: &lt;quote> in Sachanmerkung ermöglichen
* FEATURE #6609: Tastenkombination für "Zitat" (&lt;quote>)
* FEATURE #6611: Vorangehender/nachfolgender Briefe optimieren

## 0.17.1 vom 08.07.2016

* BUGFIX #6514: extensionsListener entfernen 