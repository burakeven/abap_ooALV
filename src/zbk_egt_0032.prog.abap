*&---------------------------------------------------------------------*
*& Report ZBK_EGT_0032
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBK_EGT_0032.

INCLUDE zbk_egt_0032_top.

INCLUDE zbk_egt_0032_pbo.

INCLUDE zbk_egt_0032_pai.

INCLUDE zbk_egt_0032_frm.

START-OF-SELECTION.

PERFORM get_data.
PERFORM set_fcat.
PERFORM set_layout.

  CALL SCREEN 0100.
