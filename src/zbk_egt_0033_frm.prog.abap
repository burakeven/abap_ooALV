*&---------------------------------------------------------------------*
*& Include          ZBK_EGT_0033_FRM
*&---------------------------------------------------------------------*
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

*    LOOP AT gt_scarr ASSIGNING <gfs_scarr>.
*      <gfs_scarr>-delete = '@11@'.
*    ENDLOOP.
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
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name = 'SCARR'
    CHANGING
      ct_fieldcat      = gt_fcatt.

*  CLEAR: gs_fcat.
*  gs_fcat-fieldname = 'DELETE'.
*  gs_fcat-scrtext_s = 'Sil'.
*  gs_fcat-scrtext_s = 'Sil'.
*  gs_fcat-scrtext_s = 'Sil'.
*  gs_fcat-style = cl_gui_alv_grid=>mc_style_button.
*  gs_fcat-icon = abap_true.
*  APPEND gs_fcat to gt_fcatt.

*  LOOP AT gt_fcatt ASSIGNING <gfs_fcat>.
*    IF <gfs_fcat>-fieldname EQ 'CARRNAME'.
*      <gfs_fcat>-edit = abap_true.
**      <gfs_fcat>-f4availabl = abap_true.
*      <gfs_fcat>-style = cl_gui_alv_grid=>mc_style_f4.
*    ENDIF.
*  ENDLOOP.

*  LOOP AT gt_fcatt ASSIGNING <gfs_fcat>. "DATA CHANGED ICIN
*    IF <gfs_fcat>-fieldname EQ 'CARRNAME' OR
*      <gfs_fcat>-fieldname EQ 'URL'.
*      <gfs_fcat>-edit = abap_true.
*    ENDIF.

*  ENDLOOP.

*  LOOP AT gt_fcatt ASSIGNING <gfs_fcat>.
*    IF  <gfs_fcat>-fieldname eq 'CARRID' OR
*      <gfs_fcat>-fieldname eq 'CARRNAME'.
*      <gfs_fcat>-hotspot = abap_true.
*    ENDIF.
*  ENDLOOP.
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
*  gs_layout-no_toolbar = abap_true. "Toolbar'i yok eder. "ALV yazisinin ustunde olan butonlar.
*  gs_layout-stylefname = 'CELLSTYLE'.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form DISPLAY_ALV
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM display_alv .
  CREATE OBJECT go_cast
    EXPORTING
      container_name = 'CC_ALV'.



*  CREATE OBJECT go_spli
*    EXPORTING
*      parent  = go_cast            " Parent Container
*      rows    = 2                   " Number of Rows to be displayed
*      columns = 1.                  " Number of Columns to be Displayed
*
*  CALL METHOD go_spli->get_container "BU ALAN TOPOFPAGE OLACAK
*    EXPORTING
*      row       = 1                 " Row
*      column    = 1                 " Column
*    RECEIVING
*      container = go_sub1.                 " Container
*
*  CALL METHOD go_spli->get_container "BU ALAN verigosterim OLACAK
*    EXPORTING
*      row       = 2                 " Row
*      column    = 1                 " Column
*    RECEIVING
*      container = go_sub2.                 " Container
*
**  CALL METHOD go_spli->set_row_height
**    EXPORTING
**      id     = 1                 " Row ID
**      height = 15.                 " Height
*
*  CREATE OBJECT go_docu
*    EXPORTING
*      style = 'ALV_GRID'        " Adjusting to the Style of a Particular GUI Environment
**     background_color =                  " Color ID
**     bds_stylesheet   =                  " Use BDS Style Sheet
**     no_margins       =                  " 'X': Document Created Without Free Margins
  .

  CREATE OBJECT go_alv
    EXPORTING
      i_parent = go_cast.

  CREATE OBJECT go_event_receiver.

*  set HANDLER go_event_receiver->handle_hotspot_click for go_alv. "GRIDE ASSIGN EDILDI.
*  SET HANDLER go_event_receiver->handle_top_of_page FOR go_alv.
  SET HANDLER go_event_receiver->handle_toolbar FOR go_alv. "koymak istenen butonlar ekrana gelir
  SET HANDLER go_event_receiver->handle_user_command FOR go_alv. "koyulan butonun user commandiyle yakalanmis olacak.

*PERFORM register_f4.

  CALL METHOD go_alv->set_table_for_first_display
    EXPORTING
      is_layout       = gs_layout
    CHANGING
      it_outtab       = gt_scarr                 " Output Table
      it_fieldcatalog = gt_fcatt.                 " Field Catalog

*  CALL METHOD go_alv->register_edit_event
*    EXPORTING
*      i_event_id = cl_gui_alv_grid=>mc_evt_modified.                 " Event ID
*
*  CALL METHOD go_alv->list_processing_events
*    EXPORTING
*      i_event_name = 'TOP_OF_PAGE'                 " Event Name List Processing
*      i_dyndoc_id  = go_docu.                 " Dynamic Document
ENDFORM.
*&---------------------------------------------------------------------*
*& Form REGISTER_F4
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM register_f4 . "seachelp oldugunu, kullanilabilir oldugunu yazmamiz gerekiyor.

  data: lt_f4 type lvc_t_f4,
        ls_f4 type lvc_s_f4.

  clear: ls_f4.
  ls_f4-fieldname = 'CARRNAME'.
  ls_f4-register = abap_true.
  APPEND ls_f4 to lt_f4.


call method go_alv->register_f4_for_fields
  EXPORTING
    it_f4 = lt_f4 " F4 Fields
  .
ENDFORM.
