*&---------------------------------------------------------------------*
*& Include          ZBK_EGT_0032_TOP
*&---------------------------------------------------------------------*
DATA: go_alv TYPE REF TO cl_gui_alv_grid,
      go_alv2 type ref to cl_gui_alv_grid,
      go_cast type ref to cl_gui_custom_container.

*      go_cont type ref to cl_gui_custom_container.
"cl_gui_alv_grid bir class ve ondan bir obje olusturuldu.

DATA: go_splitter type ref to cl_gui_splitter_container,
      go_gui1 type ref to cl_gui_container, "splitter'n bir hucresini
"secerek ona göre bu hucreyi go_gui'e atacagim.
      go_gui2 type ref to cl_gui_container.

data: gt_scarr type table of scarr,
      gt_sflight type table of sflight,
      gt_fcatt type lvc_t_fcat,
      gt_fcatt2 type lvc_t_fcat,
      gs_fcat type lvc_s_fcat,
      gs_fcatt2 type lvc_s_fcat,
      gs_layout type lvc_s_layo.

*DATA: BEGIN OF gt_scarr OCCURS 0,
*        carrid   TYPE scarr-carrid,
*        carrname TYPE scarr-carrname,
*        currcode TYPE scarr-currcode,
*        url      TYPE scarr-url,
*      END OF gt_scarr.

*TYPES: BEGIN OF gty_scarr,
*         durum     TYPE icon_d,
*         carrid    TYPE  s_carr_id,
*         carrname  TYPE  s_carrname,
*         currcode  TYPE s_currcode,
*         url       TYPE  s_carrurl,
*       END OF gty_scarr.

*DATA: gs_cellstyle TYPE lvc_s_styl.
*
*DATA: gt_scarr  TYPE TABLE OF gty_scarr,
*      gs_scarr  TYPE gty_scarr, "bunun type'nda structure olusturuldu
*      gt_sflight type TABLE OF sflight,
*      gt_fcatt  TYPE lvc_t_fcat,
*      gt_fcatt2  TYPE lvc_t_fcat,
*      gs_fcatt2 type lvc_s_fcat,
*      gs_fcatt  TYPE lvc_s_fcat,
*      gs_layout TYPE lvc_s_layo.
*
*FIELD-SYMBOLS: <gfs_fc>    TYPE lvc_s_fcat,
*               <gfs_fc2> type lvc_s_fcat,
*               <gfs_scarr> TYPE gty_scarr.
