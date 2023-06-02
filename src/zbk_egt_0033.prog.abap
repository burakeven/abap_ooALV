*&---------------------------------------------------------------------*
*& Report ZBK_EGT_0033
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBK_EGT_0033.

INCLUDE zbk_egt_0033_top.

INCLUDE zbk_egt_0033_cls.

INCLUDE zbk_egt_0033_pbo.

INCLUDE zbk_egt_0033_pai.

INCLUDE zbk_egt_0033_frm.

START-OF-SELECTION.

PERFORM get_data.
PERFORM set_fcat.
PERFORM set_layout.

  CALL SCREEN 0100.
