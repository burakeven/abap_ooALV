*&---------------------------------------------------------------------*
*& Report ZBK_EGT_0031
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBK_EGT_0031.

INCLUDE zbk_egt_0031_top.

INCLUDE zbk_egt_0031_pbo.

INCLUDE zbk_egt_0031_pai.

INCLUDE zbk_egt_0031_frm.

START-OF-SELECTION.

PERFORM get_data.
PERFORM set_fcat.
PERFORM set_layout.
  CALL SCREEN 0100.
