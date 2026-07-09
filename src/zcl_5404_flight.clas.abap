CLASS zcl_5404_flight DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.
    METHODS process_passenger_flight
      IMPORTING
        iv_passenger_name TYPE string
      EXPORTING
        ev_status         TYPE string.

  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_5404_flight IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    " Base class implementation
  ENDMETHOD.

  METHOD process_passenger_flight.
    ev_status = |Flight Passenger Base: { iv_passenger_name }|.
  ENDMETHOD.
ENDCLASS.

