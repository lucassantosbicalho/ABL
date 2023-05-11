
/*------------------------------------------------------------------------
    File        : generateAnagrams.p
    Purpose     : gerar anagramas a partir de uma palavra
    Author(s)   : Lucas Bicalho
    Created     : Thu May 11 13:36:31 BRT 2023
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

DEFINE VARIABLE lcAnagram AS LONGCHAR NO-UNDO.
/* ********************  Preprocessor Definitions  ******************** */

/* ************************  Function Prototypes ********************** */


FUNCTION anagramGenarator RETURNS LONGCHAR 
    (INPUT cWord AS CHARACTER) FORWARD.

FUNCTION cutLetterAtWord RETURNS CHARACTER 
    (INPUT cWord AS CHARACTER, 
     INPUT iPositionToKill AS INTEGER) FORWARD.

/* ***************************  Main Block  *************************** */

lcAnagram = anagramGenarator('abc').

MESSAGE "Qtd anagramas: "NUM-ENTRIES(lcAnagram) SKIP(1) STRING(lcAnagram)
VIEW-AS ALERT-BOX. 

/* ************************  Function Implementations ***************** */


FUNCTION anagramGenarator RETURNS LONGCHAR 
    (INPUT cWord AS CHARACTER):
/*------------------------------------------------------------------------------
 Purpose: Gerar anagramas. Retornar em uma string separada por virgulas
 Notes:   
         Esse e um exemplo classico que eu vi na faculdade nas materias de probabilidade do curso de Estatistica.
         A forma mais elegante que gostei era a de percorrer as letras da palavra, 
         omitir uma letra do loop em questao, gerar uma lista de novas palavras permutadas com as demais letras, 
         e gerar o anagrama final concatenando a letra omitida para cada nova palavra permutada gerada.
         Colocando esta logica em uma funcao e a chamando de forma recursiva.
         
 Exemplo: Input: abc - Output: "abc, acb, bac, bca, cab, cba"
------------------------------------------------------------------------------*/    
        DEFINE VARIABLE lcAnagrams  AS LONGCHAR  NO-UNDO.
        DEFINE VARIABLE cHoldLetter AS CHARACTER NO-UNDO.
        DEFINE VARIABLE cRemaining  AS CHARACTER NO-UNDO.
        DEFINE VARIABLE i           AS INTEGER   NO-UNDO.
        DEFINE VARIABLE j           AS INTEGER   NO-UNDO.
        DEFINE VARIABLE preAnagram  AS CHARACTER NO-UNDO.
        
        IF LENGTH(cWord) = 1 THEN RETURN cWord.
        
        blkD:
        DO i = 1 TO LENGTH(cWord):
            // Reter uma letra
            cHoldLetter = SUBSTRING(cWord, i, 1).
            cRemaining = cutLetterAtWord(cWord, i).
            // Chamar a funcao de forma recursiva e armazenar resultado
            preAnagram = anagramGenarator(cRemaining).
            // Para cada elemento de preAnagram, concatenar cHoldLetter + preAnagram para gerar um anagrama.
            blkD2:
            DO j = 1 TO NUM-ENTRIES(preAnagram):
                lcAnagrams = lcAnagrams + "," + cHoldLetter + ENTRY(j, preAnagram).
            END.
        END.
        
        RETURN TRIM(lcAnagrams, ",").
        
END FUNCTION.

FUNCTION cutLetterAtWord RETURNS CHARACTER 
    (INPUT cWord AS CHARACTER, 
     INPUT iPositionToKill AS INTEGER):
/*------------------------------------------------------------------------------
 Purpose: Remover letra em posicao especifica da palavra
 Notes:
------------------------------------------------------------------------------*/    
    
        DEFINE VARIABLE i           AS INTEGER   NO-UNDO.
        DEFINE VARIABLE j           AS INTEGER   NO-UNDO.
        DEFINE VARIABLE cRemaining  AS CHARACTER NO-UNDO.
        
        i = iPositionToKill.
        
        IF i > LENGTH(cWord) THEN RETURN cWord.
        IF i = 0 THEN RETURN cWord.
        
        // Obter restante da palavra, sem a letra cHoldLetter
        // Tratando indice j para obter cRemaining (resto da palavra)
        IF i = 1 THEN j = 1.
        ELSE IF i = LENGTH(cWord) THEN j = 0.
        ELSE j = i - 1.
        
        IF i = 1 THEN cRemaining = SUBSTRING(cWord, i + 1).
        ELSE IF i = LENGTH(cWord) THEN cRemaining = SUBSTRING(cWord, 1, LENGTH(cWord) - 1).
        ELSE DO:
            cRemaining = SUBSTRING(cWord, 1, j) + SUBSTRING(cWord, i + 1).
        END.
        
        RETURN cRemaining.
        
END FUNCTION.