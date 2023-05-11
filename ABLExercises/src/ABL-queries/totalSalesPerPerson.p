
/*------------------------------------------------------------------------
    File        : totalSalesPerPerson.p
    Description : Retorna o valor total das vendas de cada vendedor. Se o vendedor não vendeu nada, mostre zero.
    Author(s)   : Lucas Bicalho
    Created     : Thu May 11 17:23:04 BRT 2023
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */
DEFINE TEMP-TABLE ttSalesStats NO-UNDO
        FIELD SalespersonID   AS CHARACTER
        FIELD Salesperson     AS CHARACTER FORMAT "x(30)"
        FIELD TotalSales      AS DECIMAL   FORMAT "->>>,>>>,>>>,>99.99"
        INDEX idx IS PRIMARY IS UNIQUE SalespersonID.

    DEFINE VARIABLE dValue AS INTEGER     NO-UNDO.

    FOR EACH Salesperson NO-LOCK
        BREAK BY Salesperson.ID:
        
        IF FIRST-OF (Salesperson.ID) THEN DO:
            dValue = 0.
            CREATE ttSalesStats.
            ASSIGN ttSalesStats.SalespersonID = Salesperson.ID
                   ttSalesStats.Salesperson   = Salesperson.Name.
        END.
        
        FOR EACH Orders NO-LOCK 
            WHERE Orders.salesperson_id = Salesperson.ID,
                BREAK BY Orders.salesperson_id:
            
            ACCUMULATE Orders.Amount (TOTAL). // Acumula total por representante  
            
            IF LAST-OF (Orders.salesperson_id) THEN DO:
                dValue = (ACCUM TOTAL Orders.Amount).
                
                FIND FIRST ttSalesStats EXCLUSIVE-LOCK
                WHERE ttSalesStats.SalespersonID = Orders.salesperson_id
                NO-ERROR.
                
                ASSIGN ttSalesStats.TotalSales = dValue.        
                
                RELEASE ttSalesStats.
            END.
        END.
    END.  

    FOR EACH ttSalesStats NO-LOCK 
        BY ttSalesStats.TotalSales:
        DISPLAY ttSalesStats.Salesperson
                ttSalesStats.TotalSales.
    END.