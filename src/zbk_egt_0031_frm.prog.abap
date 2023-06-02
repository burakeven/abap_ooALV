*&---------------------------------------------------------------------*
*& Include          ZBK_EGT_0031_FRM
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

  DATA: lv_numc   TYPE n LENGTH 8,
        lv_numc_c TYPE char8.

  SELECT * FROM scarr INTO CORRESPONDING FIELDS OF TABLE gt_scarr.

*  LOOP AT gt_scarr ASSIGNING <gfs_scarr>.
*    IF <gfs_scarr>-currcode <> 'EUR'. "EURO DEGILSE
*     CLEAR gs_cellstyle.
*     gs_cellstyle-fieldname = 'URL'.
*     gs_cellstyle-style = cl_gui_alv_grid=>mc_style_disabled. "EDIT KAPATMA
*     APPEND gs_cellstyle TO <gfs_scarr>-cellstyle.
*    ENDIF.
*  ENDLOOP.

PERFORM hanasyntax.

  LOOP AT gt_scarr ASSIGNING <gfs_scarr>.
    lv_numc = lv_numc_c + 1.
    lv_numc_c = lv_numc.
    gs_cellstyle-fieldname = 'URL'.
    gs_cellstyle-style = lv_numc_c. "EDIT KAPATMA
    APPEND gs_cellstyle TO <gfs_scarr>-cellstyle.

    <gfs_scarr>-styleval = lv_numc_c.
  ENDLOOP.
  "Loop icerisinin aciklamasi
  "
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
  APPEND gs_fcatt TO gt_fcatt.

  CLEAR: gs_fcatt.
  gs_fcatt-fieldname = 'STYLEVAL'.
  gs_fcatt-scrtext_s = 'Style'.
  gs_fcatt-scrtext_s = 'Style'.
  gs_fcatt-scrtext_s = 'Style'.
  APPEND gs_fcatt TO gt_fcatt.
*  gs_fcatt-edit = abap_true.
*gs_fcatt-col_pos = 1. "Kolon sirasini ifade eder.
*gs_fcatt-col_opt = abap_true. "icerige gore uzunlugunu optimize eder.
*gs_fcatt-no_out = abap_true.
*gs_fcatt-outputlen = 100. "ekranda kac karakterli bir alan gostermeyi istersek o sekilde gösteriyor.
*gs_fcatt-ref_table = 'SCARR'. "scarr tablosundan url data elementini referans aldı.
*gs_fcatt-ref_field = 'URL'.
*  APPEND gs_fcatt TO gt_fcatt.
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
  gs_layout-stylefname = 'CELLSTYLE'.
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
*  CREATE OBJECT go_cont
*    EXPORTING
*      container_name = 'CC_ALV'.                 " Name of the Screen CustCtrl Name to Link Container To

*  CREATE OBJECT go_alv
*    EXPORTING
*      i_parent = go_cont.                  " Parent Container

  CREATE OBJECT go_alv
    EXPORTING
      i_parent = cl_gui_container=>screen0.

  " Parent Container
  CALL METHOD go_alv->set_table_for_first_display
    EXPORTING
*     i_buffer_active =
*     i_bypassing_buffer            =
*     i_consistency_check           =
*     i_structure_name              = 'SCARR'
*     is_variant      =
*     i_save          =
*     i_default       = 'X'
      is_layout       = gs_layout
*     is_print        =
*     it_special_groups             =
*     it_toolbar_excluding          =
*     it_hyperlink    =
*     it_alv_graphics =
*     it_except_qinfo =
*     ir_salv_adapter =
    CHANGING
      it_outtab       = gt_scarr[]
      it_fieldcatalog = gt_fcatt
*     it_sort         =
*     it_filter       =
*    EXCEPTIONS
*     invalid_parameter_combination = 1
*     program_error   = 2
*     too_many_lines  = 3
*     others          = 4
    .
ENDFORM.
*&---------------------------------------------------------------------*
*& Form HANASYNTAX
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM hanasyntax .
DATA(gt_scarr_tmp) = gt_scarr.
APPEND LINES OF gt_scarr_tmp TO gt_scarr.
APPEND LINES OF gt_scarr_tmp TO gt_scarr. "18 satir birden yukseltti.
ENDFORM.
