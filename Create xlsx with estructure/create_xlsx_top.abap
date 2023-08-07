*&---------------------------------------------------------------------*
*&  Include           ZAL01_CREATE_XLSX_TOP
*&---------------------------------------------------------------------*

*Estrutura do Arquivo
TYPES: BEGIN OF ty_data,
         nome(30)  TYPE c,
         cpf(20)   TYPE c,
         ender(20) TYPE c,
         tele(20)  TYPE c,
         email(30) TYPE c,
       END OF ty_data.

DATA: lt_dados TYPE STANDARD TABLE OF ty_data.

*Inserindo dados na tabela interna
lt_dados[] = VALUE #( ( nome = 'NOME' cpf = 'CPF' ender = 'ENDEREÇO' tele = 'TELEFONE' email = 'E-MAIL') "CABEÇALHO
                      ( nome = 'Fulano da Silva'  cpf = '600.456.523-88' ender = 'Rua 10, 85' tele = '123456789' email = 'fulano@gmail.com' )
                      ( nome = 'Ciclano de Souza' cpf = '600.456.523-88' ender = 'Rua 10, 85' tele = '123456789' email = 'fulano@gmail.com' )
                      ( nome = 'Beltrano Gonzaga' cpf = '600.456.523-88' ender = 'Rua 10, 85' tele = '123456789' email = 'fulano@gmail.com' )
                      ( nome = 'Fulano da Silva'  cpf = '600.456.523-88' ender = 'Rua 10, 85' tele = '123456789' email = 'fulano@gmail.com' ) ).
