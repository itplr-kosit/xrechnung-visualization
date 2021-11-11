# README

## Path through pdf generation

```
xr-pdf.xsl
  template match "xr-invoice"
    call-template generiere-layout-master-set
       (defines A4 fo page header footer margins)    
    call-template generiere-page-sequence
       page-sequence.xsl
          template generiere-page-sequence
             fo header
             fo footer
             fo content (flow)
                call-template uebersicht
                    xr-content.xsl
                        template uebersicht
                            call-template page
                                content-template.xsl
                                    template page            
                                call-template uebersicht_Content as param
                                    xr-content.xsl
                                        template uebersicht_Content
                                            call-template uebersichtKaeufer
                                                xr-content.xsl
                                                    template uebersichtKaeufer
                                                        call-template box
                                                            content-template.xsl
                                                                template box
                                                            call-template list as param
                                                                content-template.xsl
                                                                    template list
                                                                apply-template list-entry as param for every term
                                                                    content-template.xsl
                                                                    template list-entry
                                            (same for uebersichtVerkaeufer, uebersichtRechnungsInfo, uebersichtRechnungsuebersicht, uebersichtUmsatzsteuer, uebersichtNachlass, uebersichtZuschlaege, uebersichtZahlungInfo, uebersichtBemerkungen)       
                call-template details
                call-template zusaetze
                call-template anlagen
                call-template laufzettel
```

## discussion

### goal

* possible configuration of layout (e.g. compact as parameter)
* seperation of nomenclatur content and data entries
  * data.xml, data-field.xml and data-value.xml
* only push or pull data

### critism

* pull of sementic data (e.g. uebersichtKaeufer)
* beginning from call-template uebersichtKaefer the process is not structured by the layout but by the data.
* xr-mapping.xsl maps informations already exists in xr

### notes

* layout of group
