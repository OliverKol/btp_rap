@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View für Mitarbeiter'

@UI: {
 headerInfo: { typeName: 'Mitarbeiter', typeNamePlural: 'Mitarbeiter', title: { type: #STANDARD, value: 'MitarbeiterID' } } }

@Search.searchable: true

define root view entity ZC_MITARBEITER_M
  as projection on ZI_MITARBEITER_M
{
      @UI.facet: [ { id:              'Mitarbeiter',
                           purpose:         #STANDARD,
                           type:            #IDENTIFICATION_REFERENCE,
                           label:           'Mitarbeiter',
                           position:        10 } ]

      @UI.hidden: true
  key mitarbeiterid as MitarbeiterID,
      @UI: {
             lineItem:       [ { position: 20, importance: #MEDIUM } ],
             identification: [ { position: 20, label: 'Anrede'} ] }
      anrede,
      @UI: {
         lineItem:       [ { position: 25, importance: #HIGH } ],
         identification: [ { position: 25, label: 'Vorname' } ] }
      @Search.defaultSearchElement: true
      vorname,
      @UI: {
         lineItem:       [ { position: 30, importance: #HIGH } ],
         identification: [ { position: 30, label: 'Nachname' } ] }
      @Search.defaultSearchElement: true
      nachname,
      @UI: {
         lineItem:       [ { position: 35, importance: #MEDIUM } ],
         identification: [ { position: 35, label: 'Geburtsdatum' } ] }
      geburtsdatum,
      @UI: {
         lineItem:       [ { position: 40, importance: #MEDIUM } ],
         identification: [ { position: 40, label: 'Straße' } ] }
      strasse,
      @UI: {
         lineItem:       [ { position: 45, importance: #MEDIUM } ],
         identification: [ { position: 45, label: 'Hausnummer' } ] }
      hausnummer,
      @UI: {
         lineItem:       [ { position: 50, importance: #MEDIUM } ],
         identification: [ { position: 50, label: 'Postleitzahl' } ] }
      postleitzahl,
      @UI: {
         lineItem:       [ { position: 55, importance: #MEDIUM } ],
         identification: [ { position: 55, label: 'Ort' } ] }
      @Search.defaultSearchElement: true
      ort,
      @UI: {
         lineItem:       [ { position: 60, importance: #MEDIUM } ],
         identification: [ { position: 60, label: 'Land' } ] }
      land,
      @UI: {
         lineItem:       [ { position: 65, importance: #MEDIUM } ],
         identification: [ { position: 65, label: 'Telefnnummer' } ] }
      telefon

}
