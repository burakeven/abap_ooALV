*&---------------------------------------------------------------------*
*& Include          ZBK_EGT_0033_PBO
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
 SET PF-STATUS '0100'.
 SET TITLEBAR 'xxx'.

 PERFORM display_alv.
ENDMODULE.