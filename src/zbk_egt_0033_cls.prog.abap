*&---------------------------------------------------------------------*
*& Include          ZBK_EGT_0033_CLS
*&---------------------------------------------------------------------*

CLASS cl_event_receiver DEFINITION.
  PUBLIC SECTION.

    "object oriented alv = cl_gui_alv

*    METHODS handle_top_of_page "burada yazmis olunan isim degil, for event kisminda yazan ONEMLIDIR!
*        FOR EVENT top_of_page OF cl_gui_alv_grid "asil onemli olan bu kisimdir!!
*      IMPORTING
*        e_dyndoc_id
*        table_index.

    METHODS handle_hotspot_click "hücrenin tiklanabilir
        FOR EVENT hotspot_click OF cl_gui_alv_grid
      IMPORTING
        e_row_id
        e_column_id.

    METHODS handle_double_click "satirin double tiklanma ozelligi
        FOR EVENT double_click OF cl_gui_alv_grid
      IMPORTING
        e_row
        e_column
        es_row_no.

    METHODS handle_data_changed "yapilan degisikligin loglanmasi BU ONEMLI
        FOR EVENT data_changed OF cl_gui_alv_grid
      IMPORTING
        er_data_changed
        e_onf4
        e_onf4_before
        e_onf4_after
        e_ucomm.

    METHODS handle_onf4 "SEARCHELP ekleme
        FOR EVENT onf4 OF cl_gui_alv_grid
      IMPORTING
        e_fieldname
        e_fieldvalue
        es_row_no
        er_event_data
        et_bad_cells
        e_display.
    METHODS handle_button_click
        FOR EVENT button_click OF cl_gui_alv_grid
      IMPORTING
        es_col_id
        es_row_no.
    METHODS handle_toolbar
    FOR EVENT toolbar of cl_gui_alv_grid
    IMPORTING
      e_object
      e_interactive.
    METHODS handle_user_command
    FOR EVENT user_command OF cl_gui_alv_grid
    IMPORTING
      e_ucomm.
ENDCLASS.

CLASS cl_event_receiver IMPLEMENTATION.
*  METHOD handle_top_of_page.
*    DATA: lv_text TYPE sdydo_text_element.
*    lv_text = 'FLIGHT DETAILS'.
*    CALL METHOD go_docu->add_text
*      EXPORTING
*        text      = lv_text                 " Single Text, Up To 255 Characters Long
*        sap_style = cl_dd_document=>heading. " Recommended Styles
*    CALL METHOD go_docu->new_line.
*    CLEAR: lv_text.
*    CONCATENATE 'USER': sy-uname INTO lv_text SEPARATED BY space.
*    CALL METHOD go_docu->add_text
*      EXPORTING
*        text         = lv_text                 " Single Text, Up To 255 Characters Long
*        sap_color    = cl_dd_document=>list_positive " Not Release 99
*        sap_fontsize = cl_dd_document=>medium. " Recommended Font Sizes
*    .
*
*    CALL METHOD go_docu->display_document
*      EXPORTING
*        parent = go_sub1.                " Contain Object Already Exists
*    .
*  ENDMETHOD.
  METHOD handle_hotspot_click.
*    data: lv_mess type char200.
*
*    READ TABLE gt_scarr INTO gs_scarr INDEX e_row_id-index.
*
*    "database seviyesinde bir islemden sonra sy-subrc okumakta fayda var.
*    IF sy-subrc eq 0.
*       CASE e_column_id-fieldname.
*         WHEN 'CARRID'.
*          CONCATENATE 'Tıklanan kolon'
*                      e_column_id-fieldname
*                      'değeri'
*                      gs_scarr-carrid
*                      INTO lv_mess
*                      SEPARATED BY space.
*          MESSAGE lv_mess type 'I'.
*          WHEN 'CARRNAME'.
*            CONCATENATE 'Tıklanan kolon'
*                      e_column_id-fieldname
*                      'değeri'
*                      gs_scarr-carrname
*                      INTO lv_mess
*                      SEPARATED BY space.
*          MESSAGE lv_mess type 'I'.
*       ENDCASE.
*    ENDIF.
  ENDMETHOD.
  METHOD handle_double_click.
*    data: lv_mess type char200.
*    READ TABLE gt_scarr INTO gs_scarr INDEX e_row-index.
*    IF sy-subrc eq 0.
*        CONCATENATE 'Tiklanan kolon'
*                    e_column-fieldname
*                    ', satirin degeri'
*                    gs_scarr
*                    INTO lv_mess
*                    SEPARATED BY space.
*        MESSAGE lv_mess type 'I'.
*    ENDIF.
  ENDMETHOD.
  METHOD handle_data_changed.
*    DATA: ls_modi TYPE lvc_s_modi,
*          lv_mess TYPE char200.
*
*    LOOP AT er_data_changed->mt_good_cells INTO ls_modi.
*      READ TABLE gt_scarr INTO gs_scarr INDEX ls_modi-row_id.
*      IF sy-subrc EQ 0.
*        CASE ls_modi-fieldname.
*          WHEN 'CARRNAME'.
*            CONCATENATE ls_modi-fieldname
*                          '=> eski deger'
*                          gs_scarr-carrname
*                          ', yeni deger'
*                          ls_modi-value
*                          INTO lv_mess
*                          SEPARATED BY space.
*            MESSAGE lv_mess TYPE 'I'.
*          WHEN 'URL'.
*            CONCATENATE ls_modi-fieldname
*                          '=> eski deger'
*                          gs_scarr-url
*                          ', yeni deger'
*                          ls_modi-value
*                          INTO lv_mess
*                          SEPARATED BY space.
*            MESSAGE lv_mess TYPE 'I'.
*          WHEN OTHERS.
*        ENDCASE.
*      ENDIF.
*    ENDLOOP.
  ENDMETHOD.
  METHOD handle_onf4.
*    TYPES: BEGIN OF lty_value_tab,
*             carrname TYPE s_carrname,
*           END OF lty_value_tab.
*
*    DATA: lt_value_tab TYPE TABLE OF lty_value_tab,
*          ls_value_tab TYPE lty_value_tab.
*
*    DATA: lt_return_tab TYPE TABLE OF ddshretval,
*          ls_return_tab TYPE ddshretval.
*
*    CLEAR: ls_value_tab.
*    ls_value_tab-carrname = 'Ucus 1'.
*    APPEND ls_value_tab TO lt_value_tab.
*
*    CLEAR: ls_value_tab.
*
*    ls_value_tab-carrname = 'Ucus 2'.
*    APPEND ls_value_tab TO lt_value_tab.
*
*    CLEAR: ls_value_tab.
*    ls_value_tab-carrname = 'Ucus 3'.
*    APPEND ls_value_tab TO lt_value_tab.
*
*
*
*    CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
*      EXPORTING
*        retfield     = 'CARRNAME'
*        window_title = 'Carrname F4' "acilan searchelp basliginda yazilmasi istenen yazi
*        value_org    = 'S' "defaultta S olacak.
*      TABLES
*        value_tab    = lt_value_tab "Ekranda gorulmesin istedigim bir internal table, dinamik bir table, n kolonlu
*        return_tab   = lt_return_tab. "yakalamak icin return tab acmak gerekiyor
*
*
*READ TABLE lt_return_tab INTO ls_return_tab WITH KEY fieldname = 'F0001'.
*IF sy-subrc eq 0.
*READ TABLE gt_scarr ASSIGNING <gfs_scarr> INDEX es_row_no-row_id.
*  IF sy-subrc eq 0.
*      <gfs_scarr>-carrname = ls_return_tab-fieldval.
*
*      go_alv->refresh_table_display( ).
*  ENDIF.
*ENDIF.
*
*er_event_data->m_event_handled = 'X'.
  ENDMETHOD.

  METHOD handle_button_click.
*    DATA: lv_mess TYPE char200.
*
*    READ TABLE gt_scarr INTO gs_scarr INDEX es_row_no-row_id.
*    IF sy-subrc EQ 0.
*      CASE es_col_id-fieldname.
*        WHEN 'DELETE'.
*          CONCATENATE es_col_id-fieldname
*                      ','
*                      gs_scarr
*                      INTO lv_mess
*                      SEPARATED BY space.
*          MESSAGE lv_mess TYPE 'I'.
*      ENDCASE.
*    ENDIF.

  ENDMETHOD.

  METHOD handle_toolbar.
*      data: ls_toolbar type stb_button.
*
*      clear: ls_toolbar.
*      ls_toolbar-function = '&DEL'.
*      ls_toolbar-text = 'Silme'.
*      ls_toolbar-icon = '@11@'.
*      ls_toolbar-quickinfo = 'Silme islemi'. "mouse ile ustune gelindiginde yazilmasi istenen tanim
*      ls_toolbar-disabled = abap_false.
*
*      append ls_toolbar to e_object->mt_toolbar.
*
*
*      clear: ls_toolbar.
*      ls_toolbar-function = '&DIS'.
*      ls_toolbar-text = 'Goruntule'.
*      ls_toolbar-icon = '@10@'.
*      ls_toolbar-quickinfo = 'Goruntuleme Islemi'. "mouse ile ustune gelindiginde yazilmasi istenen tanim
*      ls_toolbar-disabled = abap_false.
*
*      append ls_toolbar to e_object->mt_toolbar.
  ENDMETHOD.
  METHOD handle_user_command.
*CASE e_ucomm.
*  WHEN '&DEL'.
*    MESSAGE 'Silme islemi' type 'I'.
*  WHEN '&DIS'.
*    MESSAGE 'Display islemi' type 'I'.
*  WHEN OTHERS.
*ENDCASE.
  ENDMETHOD.
ENDCLASS.
