*&---------------------------------------------------------------------*
*& Report ZBK_EGT_0034
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBK_EGT_0034.

INCLUDE zbk_egt_0033_top.

INCLUDE zbk_egt_0033_cls.

INCLUDE zbk_egt_0033_pbo.

INCLUDE zbk_egt_0033_pai.

INCLUDE zbk_egt_0033_frm.

INITIALIZATION.

gs_variant_temp-report = sy-repid.
CALL FUNCTION 'LVC_VARIANT_DEFAULT_GET' "ON AYARLI BİR PARAMETRE, VARYANT VARSA OTOMATIK OLARAK ONU YAKALAR.
 EXPORTING
   I_SAVE              = 'A'
  CHANGING
    cs_variant          = gs_variant_temp
 EXCEPTIONS
   WRONG_INPUT         = 1
   NOT_FOUND           = 2
   PROGRAM_ERROR       = 3
   OTHERS              = 4
          .
IF sy-subrc eq 0.
  p_vari = gs_variant_temp-variant.
  ENDIF.

at SELECTION-SCREEN on VALUE-REQUEST FOR p_vari.

CALL FUNCTION 'LVC_VARIANT_F4'
  EXPORTING
    is_variant                = gs_variant_temp
*   IT_DEFAULT_FIELDCAT       =
   I_SAVE                    = 'A'
 IMPORTING
*   E_EXIT                    =
   ES_VARIANT                = gs_variant_temp
* EXCEPTIONS
*   NOT_FOUND                 = 1
*   PROGRAM_ERROR             = 2
*   OTHERS                    = 3
          .
IF sy-subrc eq 0.
    p_vari = gs_variant_temp-variant.
ENDIF.



START-OF-SELECTION.

PERFORM get_data.
PERFORM set_fcat.
PERFORM set_layout.

  CALL SCREEN 0100.
