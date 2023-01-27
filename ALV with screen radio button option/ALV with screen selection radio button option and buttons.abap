REPORT ZTESTEALV.

TYPE-POOLS: slis.

TABLES: EKKO.

SELECTION-SCREEN BEGIN OF BLOCK bl1 WITH FRAME TITLE text-001.
  PARAMETERS: p_basic TYPE char1 RADIOBUTTON GROUP gr1,
              p_compl TYPE char1 RADIOBUTTON GROUP gr1 DEFAULT 'X'.
SELECTION-SCREEN END OF BLOCK bl1.

DATA: it_ekko           TYPE TABLE OF ekko,
      lo_grid_100       TYPE REF TO cl_gui_alv_grid,
      lo_container_100  TYPE REF TO cl_gui_custom_container,
      lt_fieldcat       TYPE lvc_t_fcat,
      ls_layout         TYPE lvc_s_layo,
      lv_okcode_100     Type sy-ucomm, "Variavel da tela 100 criada para receber os clicks que forem feitos na tela"
      lt_tool_bar       TYPE ui_functions, "Variavel para armazenar os botões que serão removidos do grid"
      ls_variant        TYPE disvariant.

START-OF-SELECTION.
  PERFORM f_obtem_dados.

FORM f_obtem_dados.

  SELECT *
    INTO TABLE it_ekko[]
    FROM ekko.

     IF p_basic EQ 'X'.
       PERFORM f_visualizar_alv_basico.
     ELSE.
      PERFORM visualizar_dados_alv_compl.
     ENDIF.

ENDFORM.

FORM visualizar_dados_alv_compl.

 IF it_ekko[] IS NOT INITIAL.
   CALL SCREEN 100.
   ELSE.
   MESSAGE 'DADOS NÃO LOCALIZADOS' TYPE 'S' DISPLAY LIKE 'W'. " Colocando uma msgm do tipo S= sucesso, como W= Warning para não mudar de tela.
   ENDIF.

ENDFORM.


FORM f_visualizar_alv_basico.

    DATA: lt_fieldcat_basico TYPE slis_t_fieldcat_alv,
          ls_layout_basico    TYPE slis_layout_alv.

    CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
        i_structure_name        = 'EKKO'
    CHANGING
        ct_fieldcat             = lt_fieldcat_basico[].

    ls_layout_basico-colwidth_optimize = 'X'.
    ls_layout_basico-zebra             = 'X'.

    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
  EXPORTING
    is_layout     = ls_layout_basico
    it_fieldcat   = lt_fieldcat_basico[]
  TABLES
    t_outtab      = it_ekko[]  "Tabela interna de saída. (Sua tabela de dados)
  EXCEPTIONS
    program_error = 1
    OTHERS        = 2.


ENDFORM.

INCLUDE ztestealv_user_command_0100i02. "COMANDOS PAI AFTER INPUT"

INCLUDE ztestealv_status_0100o01. "COMANDOS PBO BOTÕES"


*&---------------------------------------------------------------------*
*&      Module  M_SHOW_GRID_100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE M_SHOW_GRID_100 OUTPUT.

    FREE: lt_fieldcat[].

    ls_layout-cwidth_opt     = 'X'.
    ls_variant-report        = 'sy-repid'.

    PERFORM f_build_grid.
    PERFORM f_remove_alv_buttons.

ENDMODULE.


FORM f_build_grid.

   "MONTA CATÁLOGO DE CAMPOS"
    PERFORM f_build_fieldcat USING:
          'EBELN' 'EBELN' 'EKKO' '' CHANGING lt_fieldcat[],
          'BUKRS' 'BUKRS' 'EKKO' '' CHANGING lt_fieldcat[],
          'BSART' 'BSART' 'EKKO' '' CHANGING lt_fieldcat[],
          'STATU' 'STATU' 'EKKO' '' CHANGING lt_fieldcat[],
          'ERNAM' 'ERNAM' 'EKKO' '' CHANGING lt_fieldcat[],
          'LIFNR' 'LIFNR' 'EKKO' '' CHANGING lt_fieldcat[],
          'SPRAS' 'SPRAS' 'EKKO' '' CHANGING lt_fieldcat[],
          'WAERS' 'WAERS' 'EKKO' '' CHANGING lt_fieldcat[],
          'AEDAT' 'AEDAT' 'EKKO' '' CHANGING lt_fieldcat[].

    "INSTANCIA O OBJ DO ALV"
    IF lo_grid_100 IS INITIAL.
       CREATE OBJECT lo_grid_100
        EXPORTING
          i_parent = cl_gui_custom_container=>default_screen .

          lo_grid_100->set_ready_for_input( 1 )."PROPRIEDADE PARA SELECIONAR MAIS DE UMA LINHA"

      "CHAMA O ALV NA TELA"
      lo_grid_100->set_table_for_first_display(
      EXPORTING
        it_toolbar_excluding = lt_tool_bar[]
        is_variant           = ls_variant
        is_layout            = ls_layout
        i_save               = 'A'
      CHANGING
        it_fieldcatalog   = lt_fieldcat[]
        it_outtab         = it_EKKO[]
        ).
      "COLOCANDO UM TITULO PERSONALIZADO"
      lo_grid_100->set_gridtitle('Documento de Compras').
      ELSE.
        "ATUALIZA A TELA CASO HAJA ALTERAÇÃO NOS DADOS DA TABELA"
        lo_grid_100->refresh_table_display( ).
      ENDIF.

ENDFORM.
FORM f_remove_alv_buttons.

  "COLOCAR A LISTA DE BOTÕES A SEREM EXCLUÍDOS"

ENDFORM.


FORM f_build_fieldcat USING VALUE(p_fieldname) TYPE c
                            VALUE(p_field)     TYPE c
                            VALUE(p_table)     TYPE c
                            VALUE(p_coltext)   TYPE c

                        CHANGING t_fieldcat    TYPE lvc_t_fcat.

  DATA: ls_fieldcat LIKE LINE OF t_fieldcat[].
        ls_fieldcat-fieldname = p_fieldname.
        ls_fieldcat-ref_field = p_field.
        ls_fieldcat-ref_table = p_table.
        ls_fieldcat-coltext   = p_coltext.
        APPEND ls_fieldcat TO t_fieldcat[].

ENDFORM.