*&---------------------------------------------------------------------*
*& Include          ZBK_EGT_0030_FRM
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form DISPLAY_ALV
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM display_alv .
*  CREATE OBJECT go_cont
*    EXPORTING
*      container_name = 'CC_ALV'.                 " Name of the Screen CustCtrl Name to Link Container To

*  CREATE OBJECT go_alv
*    EXPORTING
*      i_parent = go_cont.                  " Parent Container

  IF go_alv IS INITIAL.
    CREATE OBJECT go_alv
      EXPORTING
        i_parent = cl_gui_container=>screen0.

    PERFORM set_dropdown.
    " Parent Container
    CALL METHOD go_alv->set_table_for_first_display
      EXPORTING
*       i_buffer_active =
*       i_bypassing_buffer            =
*       i_consistency_check           =
*       i_structure_name              = 'SCARR'
*       is_variant      =
*       i_save          =
*       i_default       = 'X'
        is_layout       = gs_layout
*       is_print        =
*       it_special_groups             =
*       it_toolbar_excluding          =
*       it_hyperlink    =
*       it_alv_graphics =
*       it_except_qinfo =
*       ir_salv_adapter =
      CHANGING
        it_outtab       = gt_scarr[]
        it_fieldcatalog = gt_fcatt
*       it_sort         =
*       it_filter       =
*    EXCEPTIONS
*       invalid_parameter_combination = 1
*       program_error   = 2
*       too_many_lines  = 3
*       others          = 4
      .

    "Yalnızca entera basinca degisiklikleri algilar.
*  CALL METHOD go_alv->register_edit_event
*    EXPORTING
*      i_event_id = cl_gui_alv_grid=>mc_evt_enter.

    "Herhangi bir degisiklik yapilir yapilmaz olur.
    CALL METHOD go_alv->register_edit_event
      EXPORTING
        i_event_id = cl_gui_alv_grid=>mc_evt_modified.

  ELSE.
    CALL METHOD go_alv->refresh_table_display.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form GET_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_data .
  SELECT * FROM scarr INTO CORRESPONDING FIELDS OF TABLE gt_scarr.

  LOOP AT gt_scarr ASSIGNING <gfs_scarr>.
    CASE <gfs_scarr>-currcode.
      WHEN 'EUR'.
        <gfs_scarr>-dd_handle = '3'.
      WHEN 'USD'.
        <gfs_scarr>-dd_handle = '4'.
      WHEN 'JPY'.
        <gfs_scarr>-dd_handle = '5'.
    ENDCASE.
  ENDLOOP.
*LOOP AT gt_scarr ASSIGNING <gfs_scarr>.
*  <gfs_scarr>-durum = '@04@'.
*ENDLOOP.
*  LOOP AT gt_scarr ASSIGNING <gfs_scarr>.
*    CASE <gfs_scarr>-currcode.
*      WHEN 'USD'.
*        <gfs_scarr>-line_color = 'C710'.
*      WHEN 'JPY'.
*        <gfs_scarr>-line_color = 'C501'.
*        WHEN 'EUR'.
*          CLEAR: gs_cell_color.
*          gs_cell_color-fname = 'URL'.
*          gs_cell_color-color-col = '3'.
*          gs_cell_color-color-int = '1'.
*          gs_cell_color-color-inv = '0'.
*          APPEND gs_cell_color to <gfs_scarr>-cell_color.
*    ENDCASE.
*  ENDLOOP.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_FCAT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_fcat .

  CLEAR: gs_fcatt.
  gs_fcatt-fieldname = 'DURUM'.
  gs_fcatt-scrtext_s = 'Durum'.
  gs_fcatt-scrtext_s = 'Durum'.
  gs_fcatt-scrtext_s = 'Durum'.
*gs_fcatt-col_pos = 3.
*gs_fcatt-edit = abap_true.
*gs_fcatt-key = abap_true.
  APPEND gs_fcatt TO gt_fcatt.


  CLEAR: gs_fcatt.
  gs_fcatt-fieldname = 'CARRID'.
  gs_fcatt-scrtext_s = 'Hava. K.'.
  gs_fcatt-scrtext_s = 'Havayolu K.'.
  gs_fcatt-scrtext_s = 'Havayolu Kodu'.
*gs_fcatt-col_pos = 2.
*gs_fcatt-key = abap_true.
  APPEND gs_fcatt TO gt_fcatt.

  CLEAR: gs_fcatt.
  gs_fcatt-fieldname = 'CARRNAME'.
  gs_fcatt-scrtext_s = 'Hava. A'.
  gs_fcatt-scrtext_s = 'Havayolu A'.
  gs_fcatt-scrtext_s = 'Havayolu Adı'.
*gs_fcatt-col_pos = 3.
*gs_fcatt-edit = abap_true.
  APPEND gs_fcatt TO gt_fcatt.

  CLEAR: gs_fcatt.
  gs_fcatt-fieldname = 'CURRCODE'.
  gs_fcatt-scrtext_s = 'Havayolu Y. PB'.
  gs_fcatt-scrtext_s = 'Havayolu Yerel PB'.
  gs_fcatt-scrtext_s = 'Havayolu Yerel Para Birimi'.
  gs_fcatt-hotspot = abap_true.
*gs_fcatt-col_pos = 4.
  APPEND gs_fcatt TO gt_fcatt.

  CLEAR: gs_fcatt.
  gs_fcatt-fieldname = 'URL'.
  gs_fcatt-scrtext_s = 'Hava. URL'.
  gs_fcatt-scrtext_s = 'Havayolu URL'.
  gs_fcatt-scrtext_s = 'Havayolu URL'.
*gs_fcatt-col_pos = 1. "Kolon sirasini ifade eder.
*gs_fcatt-col_opt = abap_true. "icerige gore uzunlugunu optimize eder.
*gs_fcatt-no_out = abap_true.
*gs_fcatt-outputlen = 100. "ekranda kac karakterli bir alan gostermeyi istersek o sekilde gösteriyor.
*gs_fcatt-ref_table = 'SCARR'. "scarr tablosundan url data elementini referans aldı.
*gs_fcatt-ref_field = 'URL'.
  APPEND gs_fcatt TO gt_fcatt.

  CLEAR: gs_fcatt.
  gs_fcatt-fieldname = 'COST'.
  gs_fcatt-scrtext_s = 'FIYAT'.
  gs_fcatt-scrtext_s = 'FIYAT'.
  gs_fcatt-scrtext_s = 'FIYAT'.
  gs_fcatt-edit      = abap_true.
  APPEND gs_fcatt TO gt_fcatt.

  CLEAR: gs_fcatt.
  gs_fcatt-fieldname = 'LOCATION'.
  gs_fcatt-scrtext_s = 'Lokasyon'.
  gs_fcatt-scrtext_s = 'Lokasyon'.
  gs_fcatt-scrtext_s = 'Lokasyon'.
  gs_fcatt-edit      = abap_true.
  gs_fcatt-drdn_hndl = 1.
  APPEND gs_fcatt TO gt_fcatt.

  CLEAR: gs_fcatt.
  gs_fcatt-fieldname = 'seat1'.
  gs_fcatt-scrtext_s = 'Koltuk Harf'.
  gs_fcatt-scrtext_s = 'Koltuk Harf'.
  gs_fcatt-scrtext_s = 'Koltuk Harf'.
  gs_fcatt-edit      = abap_true.
  gs_fcatt-drdn_hndl = 2.
  APPEND gs_fcatt TO gt_fcatt.

  CLEAR: gs_fcatt.
  gs_fcatt-fieldname = 'SEATP'.
  gs_fcatt-scrtext_s = 'Koltuk pos.'.
  gs_fcatt-scrtext_s = 'Koltuk pos.'.
  gs_fcatt-scrtext_s = 'Koltuk pos.'.
  gs_fcatt-edit      = abap_true.
  gs_fcatt-drdn_field = 'DD_HANDLE'.
  APPEND gs_fcatt TO gt_fcatt.


*  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
*    EXPORTING
*      i_structure_name       = 'SCARR'
**     I_STRUCTURE_NAME       = 'ZBK_EGT_0030_S'
**     I_INTERNAL_TABNAME     = 'GT_SCARR'
*    CHANGING
*      ct_fieldcat            = gt_fcatt
*    EXCEPTIONS
*      inconsistent_interface = 1
*      program_error          = 2
*      OTHERS                 = 3.
*
*  READ TABLE gt_fcatt ASSIGNING <gfs_fc> WITH KEY fieldname = 'MESS'.
*
*  IF sy-subrc EQ 0.
*    <gfs_fc>-edit = abap_true.
*  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_LAYOUT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_layout .
  CLEAR: gs_layout.
  gs_layout-cwidth_opt = abap_true. "Tum kolonlarin genislik optimizasyonu yapilmis olacak.
*  gs_layout-edit = abap_true. "Bu ise tum alanlari editlenebilir yapar.
  gs_layout-no_toolbar = abap_true. "Toolbar'i yok eder. "ALV yazisinin ustunde olan butonlar.
*  gs_layout-zebra = abap_true.
*  gs_layout-info_fname = 'LINE_COLOR'.
*  gs_layout-ctab_fname = 'CELL_COLOR'.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form GET_TOTAL_SUM
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_total_sum .
  DATA: lv_ttl_sum TYPE int4,
        lv_lines   TYPE int4,
        lv_avr     TYPE int4.

  LOOP AT gt_scarr INTO gs_scarr.
    lv_ttl_sum = lv_ttl_sum + gs_scarr-cost.
  ENDLOOP.

  DESCRIBE TABLE gt_scarr LINES lv_lines.
  lv_avr = lv_ttl_sum / lv_lines.

  LOOP AT gt_scarr ASSIGNING <gfs_scarr>.
    IF <gfs_scarr>-cost > lv_avr.
      <gfs_scarr>-durum = '@0A@'.
    ELSEIF <gfs_scarr>-cost < lv_avr.
      <gfs_scarr>-durum = '@08@'.
    ELSE.
      <gfs_scarr>-durum = '@09@'.
    ENDIF.
  ENDLOOP.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_DROPDOWN
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_dropdown .
  DATA: lt_dropdown TYPE lvc_t_drop,
        ls_dropdown TYPE lvc_s_drop.

  CLEAR: ls_dropdown.
  ls_dropdown-handle = 1.
  ls_dropdown-value = 'Yurtiçi'.
  APPEND ls_dropdown TO lt_dropdown.

  CLEAR: ls_dropdown.
  ls_dropdown-handle = 1.
  ls_dropdown-value = 'Yurtdışı'.
  APPEND ls_dropdown TO lt_dropdown.

  CLEAR: ls_dropdown.
  ls_dropdown-handle = 2.
  ls_dropdown-value = 'A'.
  APPEND ls_dropdown TO lt_dropdown.

  CLEAR: ls_dropdown.
  ls_dropdown-handle = 2.
  ls_dropdown-value = 'B'.
  APPEND ls_dropdown TO lt_dropdown.

  CLEAR: ls_dropdown.
  ls_dropdown-handle = 2.
  ls_dropdown-value = 'C'.
  APPEND ls_dropdown TO lt_dropdown.

  CLEAR: ls_dropdown.
  ls_dropdown-handle = 2.
  ls_dropdown-value = 'D'.
  APPEND ls_dropdown TO lt_dropdown.

  CLEAR: ls_dropdown.
  ls_dropdown-handle = 2.
  ls_dropdown-value = 'E'.
  APPEND ls_dropdown TO lt_dropdown.

  CLEAR: ls_dropdown.
  ls_dropdown-handle = 2.
  ls_dropdown-value = 'F'.
  APPEND ls_dropdown TO lt_dropdown.

  CLEAR: ls_dropdown.
  ls_dropdown-handle = 3.
  ls_dropdown-value = 'Ön'.
  APPEND ls_dropdown TO lt_dropdown.

  CLEAR: ls_dropdown.
  ls_dropdown-handle = 3.
  ls_dropdown-value = 'Kanar'.
  APPEND ls_dropdown TO lt_dropdown.

  CLEAR: ls_dropdown.
  ls_dropdown-handle = 3.
  ls_dropdown-value = 'Arka'.
  APPEND ls_dropdown TO lt_dropdown.

  CLEAR: ls_dropdown.
  ls_dropdown-handle = 4.
  ls_dropdown-value = 'Ön'.
  APPEND ls_dropdown TO lt_dropdown.

  CLEAR: ls_dropdown.
  ls_dropdown-handle = 4.
  ls_dropdown-value = 'Arka'.
  APPEND ls_dropdown TO lt_dropdown.

  CLEAR: ls_dropdown.
  ls_dropdown-handle = 4.
  ls_dropdown-value = 'Kanat'.
  APPEND ls_dropdown TO lt_dropdown.

  go_alv->set_drop_down_table(
    EXPORTING
      it_drop_down       = lt_dropdown
  ).
ENDFORM.
