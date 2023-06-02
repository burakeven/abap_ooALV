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

  SELECT * FROM sflight
     INTO CORRESPONDING FIELDS OF TABLE gt_sflight.
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
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name = 'SFLIGHT'
    CHANGING
      ct_fieldcat      = gt_fcatt2.
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

  CREATE OBJECT go_splitter
    EXPORTING
      parent  = go_cast "Hangi objeyi split edeceksek verilecek alan.
      rows    = 1        "verilen go_cast'i kaca bolsun? 2 dersen iki satırlı container yapar.
      columns = 2.        "İki ayrı container için 2 sütun

  CALL METHOD go_splitter->get_container
    EXPORTING
      row       = 1                 " Row
      column    = 1                 " Column
    RECEIVING
      container = go_gui1.           " Container

    CALL METHOD go_splitter->get_container
    EXPORTING
      row       = 1                 " Row
      column    = 2                 " Column
    RECEIVING
      container = go_gui2.

  CREATE OBJECT go_alv
    EXPORTING
      i_parent = go_gui1.

  CREATE OBJECT go_alv2
    EXPORTING
      i_parent = go_gui2.

  CALL METHOD go_alv->set_table_for_first_display
    EXPORTING
      is_layout       = gs_layout
    CHANGING
      it_outtab       = gt_scarr                 " Output Table
      it_fieldcatalog = gt_fcatt.

  CALL METHOD go_alv2->set_table_for_first_display
    EXPORTING
      is_layout       = gs_layout
    CHANGING
      it_outtab       = gt_sflight                 " Output Table
      it_fieldcatalog = gt_fcatt2.

*  CREATE OBJECT go_cast
*    EXPORTING
*      container_name = 'CC_ALV'.
*
*  CREATE OBJECT go_alv
*    EXPORTING
*      i_parent = go_cast.
*
*  CREATE OBJECT go_cast2
*    EXPORTING
*      container_name = 'CC_ALV2'.
*
*  CREATE OBJECT go_alv2
*    EXPORTING
*      i_parent = go_cast2.
*
*  CALL METHOD go_alv->set_table_for_first_display
*    EXPORTING
*      is_layout       = gs_layout
*    CHANGING
*      it_outtab       = gt_scarr                 " Output Table
*      it_fieldcatalog = gt_fcatt.                 " Field Catalog
*
*  CALL METHOD go_alv2->set_table_for_first_display
*    EXPORTING
*      is_layout       = gs_layout                 " Layout
*    CHANGING
*      it_outtab       = gt_sflight                 " Output Table
*      it_fieldcatalog = gt_fcatt2.                " Field Catalog
ENDFORM.
