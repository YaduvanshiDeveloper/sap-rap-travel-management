CLASS zcl_5404_passenger_flight DEFINITION
  PUBLIC
  INHERITING FROM zcl_5404_flight
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS if_oo_adt_classrun~main REDEFINITION.

  PROTECTED SECTION.
    METHODS process_passenger_flight REDEFINITION .

  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_5404_passenger_flight IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA lv_final_status TYPE string.

    process_passenger_flight(
      EXPORTING iv_passenger_name = 'Aman 5405'
      IMPORTING ev_status         = lv_final_status
    ).

    out->write( lv_final_status ).
  ENDMETHOD.

  METHOD process_passenger_flight.
    super->process_passenger_flight(
      EXPORTING iv_passenger_name = iv_passenger_name
      IMPORTING ev_status         = DATA(lv_parent_status)
    ).

    ev_status = |[RESERVATION] - { lv_parent_status }|.
  ENDMETHOD.
ENDCLASS.

