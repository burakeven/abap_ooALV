*&---------------------------------------------------------------------*
*& Include          ZBK_EGT_0033_TOP
*&---------------------------------------------------------------------*

"------GLOBAL OBJECTS---------*

TYPES: BEGIN OF gty_scarr,
         delete type char10,
         carrid   TYPE s_carr_id,
         carrname TYPE s_carrname,
         currcode TYPE s_currcode,
         url       TYPE  s_carrurl,

  END OF gty_scarr.

         data:    go_alv TYPE ref TO cl_gui_alv_grid,
         go_cast  TYPE REF TO cl_gui_custom_container.

DATA: gt_scarr   TYPE TABLE OF gty_scarr,
      gs_scarr   TYPE gty_scarr,
      "gt_sflight TYPE TABLE OF sflight,
      gt_fcatt   TYPE lvc_t_fcat,
      "gt_fcatt2  TYPE lvc_t_fcat,
      gs_fcat    TYPE lvc_s_fcat,
      "gs_fcatt2  TYPE lvc_s_fcat,
      gs_layout  TYPE lvc_s_layo.

data: gt_excluding TYPE UI_FUNCTIONS,
      gv_excluding type UI_FUNC,
      gt_sort TYPE LVC_T_SORT,
      gs_sort type LVC_S_SORT,
      gt_filter TYPE LVC_T_FILT,
      gs_filter type LVC_S_FILT.

data: gs_variant TYPE DISVARIANT,
      gs_variant_temp type disvariant.

DATA: go_spli TYPE REF TO cl_gui_splitter_container,
      go_sub1 TYPE REF TO cl_gui_container,
      go_sub2 TYPE REF TO cl_gui_container.

*DATA: go_docu TYPE REF TO cl_dd_document.
*
FIELD-SYMBOLS: "<gfs_fcat>  TYPe,
               <gfs_scarr> TYPE gty_scarr.

CLASS cl_event_receiver DEFINITION DEFERRED.

DATA: go_event_receiver TYPE REF TO cl_event_receiver.

PARAMETERS: p_vari type disvariant-variant.
