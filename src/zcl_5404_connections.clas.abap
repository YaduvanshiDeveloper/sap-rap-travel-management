CLASS zcl_5404_connections DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .

    METHODS get_connections
      IMPORTING
        i_departure          TYPE /dmo/airport_from_id
      RETURNING
        VALUE(r_connections) TYPE zcert_connections.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_5404_connections IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    " टेस्ट रन: EDI एयरपोर्ट से जाने वाली उड़ानें ढूँढना
    DATA(lt_result) = get_connections( i_departure = 'EDI' ).

    out->write( '[SUCCESS] - Exam Task 5 Output for EDI Departure:' ).
    out->write( lt_result ).
  ENDMETHOD.


  METHOD get_connections.
    " लोकल टेबल्स की डिक्लेरेशन
    DATA lt_direct_flights     TYPE zcert_connections.
    DATA lt_connecting_flights TYPE zcert_connections.

    CLEAR r_connections.

    " --- लॉजिक भाग 1: सीधी उड़ानें (Direct Flights) ---
    SELECT FROM /dmo/connection
      FIELDS
        carrier_id      AS carrier_id,
        airport_from_id AS airport_from_id,
        airport_to_id   AS airport_to_id,
        '-'             AS airport_via_id
      WHERE airport_from_id = @i_departure
      INTO TABLE @lt_direct_flights.


    " --- लॉजिक भाग 2: कनेक्टिंग उड़ानें (Single-Change Onward Flights) ---
    " एरर फिक्स: यहाँ 'and_airport_to_id' को सुधार कर 'airport_to_id' कर दिया गया है
    SELECT FROM /dmo/connection AS f1
      INNER JOIN /dmo/connection AS f2
        ON  f1~carrier_id     = f2~carrier_id
        AND f1~airport_to_id   = f2~airport_from_id
      FIELDS
        f1~carrier_id      AS carrier_id,
        f1~airport_from_id AS airport_from_id,
        f2~airport_to_id   AS airport_to_id,
        f1~airport_to_id   AS airport_via_id
      WHERE f1~airport_from_id = @i_departure
        AND f2~airport_to_id   <> @i_departure       " शुद्ध और सटीक कॉलम नाम
      INTO TABLE @lt_connecting_flights.


    " --- लॉजिक भाग 3: दोनों नतीजों को जोड़ना ---
    r_connections = lt_direct_flights.
    APPEND LINES OF lt_connecting_flights TO r_connections.

    " नतीजों को व्यवस्थित सॉर्ट करना
    SORT r_connections BY carrier_id airport_via_id.

  ENDMETHOD.
ENDCLASS.

