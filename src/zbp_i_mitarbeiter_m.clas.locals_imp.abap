CLASS lhc_ZI_MITARBEITER_M DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zi_mitarbeiter_m RESULT result.

    METHODS eingliedern FOR MODIFY
      IMPORTING keys FOR ACTION zi_mitarbeiter_m~eingliedern RESULT result.

    METHODS CalculateMitarbeiterId FOR DETERMINE ON MODIFY
      IMPORTING keys FOR zi_mitarbeiter_m~CalculateMitarbeiterId.

    METHODS validateOrt FOR VALIDATE ON SAVE
      IMPORTING keys FOR zi_mitarbeiter_m~validateOrt.

ENDCLASS.

CLASS lhc_ZI_MITARBEITER_M IMPLEMENTATION.

  METHOD get_instance_features.

    READ ENTITY zi_mitarbeiter_m FROM VALUE #( FOR keyval IN keys
                                                    (  %key                    = keyval-%key
                                                    "  %control-travel_id      = if_abap_behv=>mk-on
                                                      %control-mitarbeiterid = if_abap_behv=>mk-on
                                                      ) )
                              RESULT DATA(lt_mitarbeiter_result).


    result = VALUE #( FOR ls_mitarbeiter IN lt_mitarbeiter_result
                      ( %key                           = ls_mitarbeiter-%key
                        %features-%action-eingliedern =  if_abap_behv=>fc-o-enabled
                      ) ).

  ENDMETHOD.

  METHOD eingliedern.

    MODIFY ENTITY  IN LOCAL MODE zi_mitarbeiter_m
            UPDATE FROM VALUE #( FOR key IN keys ( mitarbeiterid = key-mitarbeiterid
                                                     ort = 'Buxtehude'
                                                     ) )
           FAILED   failed
           REPORTED reported.

    " Read changed data for action result
    READ ENTITY IN LOCAL MODE zi_mitarbeiter_m
         FROM VALUE #( FOR key IN keys (  mitarbeiterid = key-mitarbeiterid
                                          %control = VALUE #(
                                            anrede     = if_abap_behv=>mk-on
                                            vorname      = if_abap_behv=>mk-on
                                            nachname        = if_abap_behv=>mk-on
                                            geburtsdatum     = if_abap_behv=>mk-on
                                            strasse     = if_abap_behv=>mk-on
                                            hausnummer   = if_abap_behv=>mk-on
                                            postleitzahl  = if_abap_behv=>mk-on
                                            ort     = if_abap_behv=>mk-on
                                            land      = if_abap_behv=>mk-on
                                            telefon      = if_abap_behv=>mk-on

                                          ) ) )
         RESULT DATA(lt_mitarbeiter).

    result = VALUE #( FOR mitarbeiter IN lt_mitarbeiter ( mitarbeiterid = mitarbeiter-mitarbeiterid
                                                %param    = mitarbeiter
                                              ) ).

  ENDMETHOD.

  METHOD CalculateMitarbeiterId.

    READ ENTITY IN LOCAL MODE zi_mitarbeiter_m
          FIELDS ( mitarbeiterid )
            WITH CORRESPONDING #( keys )
          RESULT DATA(lt_mitarbeiter).

    DELETE lt_mitarbeiter WHERE mitarbeiterid IS NOT INITIAL.
    CHECK lt_mitarbeiter IS NOT INITIAL.

    "Get max travelID
    SELECT SINGLE FROM zmitarbeiter FIELDS MAX( mitarbeiterid ) INTO @DATA(lv_max_mykey).

    "update involved instances
    MODIFY ENTITY IN LOCAL MODE zi_mitarbeiter_m
        UPDATE FIELDS ( mitarbeiterid )
        WITH VALUE #( FOR ls_mitarbeiter IN lt_mitarbeiter INDEX INTO i (
                          %key      = ls_mitarbeiter-%key
                          mitarbeiterid = lv_max_mykey + i
                          ) )
    REPORTED DATA(lt_reported).

  ENDMETHOD.

  METHOD validateOrt.

    "Ort und Postleitzahl müssen zusammenpassen.

  ENDMETHOD.

ENDCLASS.
