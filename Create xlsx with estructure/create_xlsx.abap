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
* Report      : ZAL01_CREATE_XLSX
* Finality    : Criar um arquivo xlsx através de uma internal table
*----------------------------------------------------------------------
* Changes History
*----------------------------------------------------------------------
* Date         | Author         | Finality
* 04/08/2023   | Ajunior        | Create xlsx
*======================================================================*
*&---------------------------------------------------------------------*
*& Report ZAL01_CREATE_XLSX
*&---------------------------------------------------------------------*

REPORT zal01_create_xlsx.

INCLUDE: zal01_create_xlsx_top,
         zal01_create_xlsx_scr,
         zal01_create_xlsx_f01.


AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.
  PERFORM f_select_file        USING p_file
                               CHANGING p_file.

START-OF-SELECTION.

PERFORM: f_convert.
