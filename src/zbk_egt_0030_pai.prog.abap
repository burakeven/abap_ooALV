*&---------------------------------------------------------------------*
*& Include          ZBK_EGT_0030_PAI
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN '&BACK'.
      SET SCREEN 0.
    WHEN '&SAVE'.
      PERFORM get_total_sum.
  ENDCASE.
ENDMODULE.
