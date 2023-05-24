*&---------------------------------------------------------------------*
*& Include          ZBK_EGT_0030_TOP
*&-------------------------------------------------------------------
TYPE-POOLS icon.

TABLES: scarr.

DATA: go_alv TYPE REF TO cl_gui_alv_grid.
*      go_cont type ref to cl_gui_custom_container.
"cl_gui_alv_grid bir class ve ondan bir obje olusturuldu.


*DATA: BEGIN OF gt_scarr OCCURS 0,
*        carrid   TYPE scarr-carrid,
*        carrname TYPE scarr-carrname,
*        currcode TYPE scarr-currcode,
*        url      TYPE scarr-url,
*      END OF gt_scarr.

TYPES: BEGIN OF gty_scarr,
         durum    TYPE icon_d,
         carrid   TYPE  s_carr_id,
         carrname TYPE  s_carrname,
         currcode TYPE s_currcode,
         url      TYPE  s_carrurl,
         cost     TYPE int4,
         seat1    TYPE char1,
         location TYPE char20,
         seatp type char10,
         dd_handle type int4, "bu ekranda gözükmeyecek.
*         mess       TYPE  char200,
*         line_color TYPE char4,"variable
*         cell_color TYPE lvc_t_scol, "table
       END OF gty_scarr.

DATA: gs_cell_color TYPE lvc_s_scol.

DATA: gt_scarr  TYPE TABLE OF gty_scarr,
      gs_scarr  TYPE gty_scarr, "bunun type'nda structure olusturuldu
      gt_fcatt  TYPE lvc_t_fcat,
      gs_fcatt  TYPE lvc_s_fcat,
      gs_layout TYPE lvc_s_layo.

FIELD-SYMBOLS: <gfs_fc>    TYPE lvc_s_fcat,
               <gfs_scarr> TYPE gty_scarr.
