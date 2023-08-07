*&---------------------------------------------------------------------*
*&  Include           ZAL01_CREATE_XLSX_TABLEZ_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&  FORM f_select_file
*&---------------------------------------------------------------------*
FORM f_select_file  USING    p_in_file
                    CHANGING p_out_file.

  CALL FUNCTION 'WS_FILENAME_GET' " FUNÇÃO UTILIZADA PARA LISTAR O CAMINHO DO ARQUIVO NO DIRETÓRIO
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

  CALL FUNCTION 'SAP_CONVERT_TO_XLS_FORMAT' " FUNÇÃO QUE CONVERTE O ARQUIVO SELECIONADO EM XLSX
    EXPORTING
      i_field_seperator = '#'
      i_filename        = p_file
    TABLES
      i_tab_sap_data    = gt_arquivo[]
    EXCEPTIONS
      conversion_failed = 1
      OTHERS            = 2.

  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  F_MONTA_DADOS
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_monta_dados .

  DATA: lt_arquivo TYPE TABLE OF zeqa_tabela_cad,
        lv_rowid   TYPE sy-tabix.

  SELECT *
    FROM zeqa_tabela_cad                             " SELECIONANDO OS DADOS DA TABELA Z
    INTO CORRESPONDING FIELDS OF TABLE @lt_arquivo.  " UTILIZANDO APENAS OS CAMPOS CORRESPONDENTES A ESTRUTURA UTILIZADA


  "CRIANDO UM CABEÇALHO PARA O ARQUIVO QUE SERÁ CRIADO
  gt_arquivo[] = VALUE #( ( mandt = 'MANDT' cnpj = 'CNPJ' cpf = 'CPF' nome = 'NOME' nome_pai = 'NOME PAI' nome_mae = 'NOME MÃE' email = 'E-MAIL' endereco = 'ENDEREÇO' cidade = 'CIDADE' estado = 'UF' dt_nascimento = 'DATA NASC' dependentes = 'DEPENDENTES'
dependentes_2 = 'DEPENDENTES' ) ).

  LOOP AT lt_arquivo ASSIGNING FIELD-SYMBOL(<fs_arquivo>).
    APPEND <fs_arquivo> TO gt_arquivo. " Adiciona cada linha de lt_arquivo em gt_arquivo

  ENDLOOP.

  PERFORM f_convert. " CHAMADA DA FUNÇÃO QUE CONVERTE OS DADOS DA ESTRUTURA EM UM ARQUIVO XLSX.

ENDFORM.
