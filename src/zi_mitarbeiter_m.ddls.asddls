@EndUserText.label: 'Mitarbeiter Daten'
@AccessControl.authorizationCheck: #CHECK
define root view entity ZI_MITARBEITER_M
  as select from zmitarbeiter as Mitarbeiter
{

  key  mitarbeiterid,
       anrede,
       vorname,
       nachname,
       geburtsdatum,
       strasse,
       hausnummer,
       postleitzahl,
       ort,
       land,
       telefon

}
