
/*------------------------------------------------------------------------
    File        : sortLettersInWord.p
    Purpose     : Ordenar letras de um conjunto de letras
    Description : Dado um conjunto de letras dispostas em uma variável character, coloque-as em ordem alfabética sem o uso de temp-tables e arrays.
                  Exemplo: Input: joana - Output: aajno
    Author(s)   : Lucas Bicalho
    Created     : Thu May 11 12:53:41 BRT 2023
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

/* ********************  Preprocessor Definitions  ******************** */

DEFINE VARIABLE ipWord       AS CHARACTER NO-UNDO.
DEFINE VARIABLE ipWordSorted AS CHARACTER NO-UNDO.
DEFINE VARIABLE l1           AS CHARACTER NO-UNDO.
DEFINE VARIABLE l2           AS CHARACTER NO-UNDO.
DEFINE VARIABLE cLetter      AS CHARACTER NO-UNDO.
DEFINE VARIABLE i            AS INTEGER   NO-UNDO.
DEFINE VARIABLE j            AS INTEGER   NO-UNDO.


/* ***************************  Main Block  *************************** */


ipWord       = 'joana'.
ipWordSorted = ipWord.

blkD:
DO i = 1 TO LENGTH(ipWordSorted):
    blkD2:
    DO j = (i + 1) TO LENGTH (ipWordSorted):
       l1 = SUBSTRING (ipWordSorted, i, 1).
       l2 = SUBSTRING (ipWordSorted, j, 1).
       
       IF ASC(l2) < ASC(l1) THEN DO:
           cLetter = l1.
           OVERLAY(ipWordSorted, i, 1) = l2.
           OVERLAY(ipWordSorted, j, 1) = cLetter.
       END.
    END.
END.

MESSAGE ipWord SKIP ipWordSorted
VIEW-AS ALERT-BOX.