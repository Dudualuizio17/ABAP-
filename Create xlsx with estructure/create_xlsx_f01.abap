*&---------------------------------------------------------------------*
*&  Include           ZAL01_CREATE_XLSX_F01
*&---------------------------------------------------------------------*


*&---------------------------------------------------------------------*
*&  FORM f_select_file
*&---------------------------------------------------------------------*
FORM f_select_file  USING    p_in_file
                    CHANGING p_out_file.

  CALL FUNCTION 'WS_FILENAME_GET' " Função para listar o caminho do arquivo no diretório C:
    EXPORTING
      def_filename     = p_in_file
      def_path         = 'C:\'
      mode             = 'S'
      title            = 'SELECÇÃO DE ARQUIVOS'
    IMPORTING
      filename         = p_out_file
*     RC               =
    EXCEPTIONS
      inv_winsys       = 1
      no_batch         = 2
      selection_cancel = 3
      selection_error  = 4
      OTHERS           = 5.
  .
  IF sy-subrc <> 0.

  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  F_CONVERT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_convert .

  CALL FUNCTION 'SAP_CONVERT_TO_XLS_FORMAT' "Função que converte os dados da IT em Arquivo Xlsx.
      EXPORTING
        i_field_seperator = '#'
        i_filename        = p_file
      TABLES
        i_tab_sap_data    = lt_dados[]
      EXCEPTIONS
        conversion_failed = 1
        OTHERS            = 2.

    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.

ENDFORM.
