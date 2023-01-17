REPORT ZREPORT01.

* DECLARAÇÃO
data : it_mara TYPE TABLE OF mara,
       is_mara TYPE mara,
       is_mara_final TYPE mara,
       it_mara_final TYPE TABLE OF mara.


* SELEÇÃO DOS DADOS
SELECT *
from mara
into TABLE it_mara.

* LEITURA E TRATAMENTO DOS DADOS
LOOP AT it_mara INTO is_mara.

    is_mara_final-MATNR = is_mara-MATNR.
    is_mara_final-ERNAM = is_mara-ERNAM.
    is_mara_final-MTART = is_mara-ERNAM.
    is_mara_final-MATKL = is_mara-MATKL.

    APPEND is_mara_final TO it_mara_final.

ENDLOOP.

*APRESENTAR OS DADOS NA TELA
CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
 EXPORTING
   I_CALLBACK_PROGRAM                = 'SY-REPID'
   I_STRUCTURE_NAME                  = 'MARA'

  TABLES
    T_OUTTAB                          = it_mara_final
* EXCEPTIONS
*   PROGRAM_ERROR                     = 1
*   OTHERS                            = 2
          .
IF SY-SUBRC <> 0.
* Implement suitable error handling here
ENDIF.