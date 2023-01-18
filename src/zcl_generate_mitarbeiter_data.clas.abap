CLASS zcl_generate_mitarbeiter_data DEFINITION
PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_generate_mitarbeiter_data IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    DATA itab TYPE TABLE OF zmitarbeiter.
*   fill internal mitarbeiter table (itab)
    itab = VALUE #(
      ( mitarbeiterid = '12345' anrede = 'Herr' vorname = 'Markus' nachname = 'Mustermann' geburtsdatum = '19800101' strasse = 'Haupstraße' hausnummer = '1'
      postleitzahl = '12345' ort = 'Buxtehude' land = 'Deutschland' telefon = '1234567')
      ( mitarbeiterid = '23456' anrede = 'Frau' vorname = 'Mareike' nachname = 'Musterfrau' geburtsdatum = '19830101' strasse = 'Nebenstraße' hausnummer = '4'
      postleitzahl = '12345' ort = 'Buxtehude' land = 'Deutschland' telefon = '2130728')
      ( mitarbeiterid = '34567' anrede = 'Herr' vorname = 'Moritz' nachname = 'Mueller' geburtsdatum = '19761223' strasse = 'Unistraße' hausnummer = '33'
      postleitzahl = '12345' ort = 'Buxtehude' land = 'Deutschland' telefon = '21347634')
    ).

*   delete existing entries in the database table
    DELETE FROM zmitarbeiter.

*   insert the new table entries
    INSERT zmitarbeiter FROM TABLE @itab.

*   output the result as a console message
    out->write( |{ sy-dbcnt } employee entries inserted successfully!| ).

  ENDMETHOD.
ENDCLASS.
