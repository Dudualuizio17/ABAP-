*&---------------------------------------------------------------------*
*&  Include           ZAL01_CREATE_XLSX_TABLEZ_TOP
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*&  TABLES
*&---------------------------------------------------------------------*
TABLES: zeqa_tabela_cad.

*&---------------------------------------------------------------------*
*&  ESTRUTURA UTILIZADA PARA CRIAR O ARQUIVO
*&---------------------------------------------------------------------*
TYPES: BEGIN OF ty_arquivo,
         mandt         TYPE zeqa_tabela_cad-mandt,
         cnpj          TYPE zeqa_tabela_cad-cnpj,
         cpf           TYPE zeqa_tabela_cad-cpf,
         nome          TYPE zeqa_tabela_cad-nome,
         nome_pai      TYPE zeqa_tabela_cad-nome_pai,
         nome_mae      TYPE zeqa_tabela_cad-nome_mae,
         email         TYPE zeqa_tabela_cad-email,
         endereco      TYPE zeqa_tabela_cad-endereco,
         cidade        TYPE zeqa_tabela_cad-cidade,
         estado        TYPE zeqa_tabela_cad-estado,
         dt_nascimento TYPE zeqa_tabela_cad-dt_nascimento,
         dependentes   TYPE zeqa_tabela_cad-dependentes,
         dependentes_2 TYPE zeqa_tabela_cad-dependentes_2,
       END OF ty_arquivo.

*&---------------------------------------------------------------------*
*&  Global Tables
*&---------------------------------------------------------------------*
DATA: gt_arquivo TYPE TABLE OF ty_arquivo.

*&---------------------------------------------------------------------*
*&  Work Areas
*&---------------------------------------------------------------------*
DATA: gwa_arquivo TYPE ty_arquivo.
