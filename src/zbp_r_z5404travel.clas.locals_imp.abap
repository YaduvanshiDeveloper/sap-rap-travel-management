CLASS lhc_zrz5404travel DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR ZrZ5404travel RESULT result.

    METHODS setInitialStatus FOR DETERMINE ON SAVE
      IMPORTING keys FOR ZrZ5404travel~setInitialStatus.

ENDCLASS.



CLASS lhc_zrz5404travel IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD setInitialStatus.

    MODIFY ENTITIES OF zr_z5404travel IN LOCAL MODE
      ENTITY ZrZ5404travel
      UPDATE
      FIELDS ( Status )
      WITH VALUE #(
        FOR key IN keys (
          %tky   = key-%tky
          Status = 'N'
        )
      ).

  ENDMETHOD.

ENDCLASS.
