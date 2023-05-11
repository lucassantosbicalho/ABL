
/*------------------------------------------------------------------------
    File        : customQuery.p
    Description : Retorne os nomes de todos os vendedores que não possuem nenhum pedido na Samsonic.
    Author(s)   : Lucas Bicalho
    Created     : Thu May 11 17:23:57 BRT 2023
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */

FOR EACH Salesperson NO-LOCK,
    EACH Orders NO-LOCK
    WHERE Orders.salesperson_id = Salesperson.ID,
        EACH Customer NO-LOCK
        WHERE Customer.ID <> 4: // Samsonic
        
    DISPLAY Salesperson.NAME FORMAT 'x(30)'.
END. 