*======================================================================
*
*                                HRST
*
*======================================================================
* Author      : Fábrica ABAP
* Analist     : Aluizio Silva
* Date        : 03/08/2023
*----------------------------------------------------------------------
* Project     : Projeto
* Report      : zal01_create_xlsx_tablez
* Finality    : Criar um arquivo xlsx através de uma Z table
*----------------------------------------------------------------------
* Changes History
*----------------------------------------------------------------------
* Date         | Author         | Finality
* 04/08/2023   | Ajunior        | Create xlsx
*======================================================================*
*&---------------------------------------------------------------------*
*& Report ZAL01_CREATE_XLSX_TABLEZ
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zal01_create_xlsx_tablez.

INCLUDE: zal01_create_xlsx_tablez_top,
         zal01_create_xlsx_tablez_scr,
         zal01_create_xlsx_tablez_f01.


AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.
  PERFORM f_select_file        USING p_file
                               CHANGING p_file.

START-OF-SELECTION.

perform f_monta_dados.
