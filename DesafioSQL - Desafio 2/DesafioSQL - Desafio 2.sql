--VERIFICAR A COLLATION DA TABELA 
SELECT 
  NAME, COLLATION_NAME 
FROM 
  SYS.COLUMNS 
WHERE 
  OBJECT_ID = OBJECT_ID('[CUSTOMERSBIG]')


-- ALTERANDO A COLLATION
ALTER TABLE CUSTOMERSBIG 
ALTER COLUMN CKEY VARCHAR(250) COLLATE  SQL_LATIN1_GENERAL_CP1_CI_AI


--RECRIANDO O ÍNDICE
CREATE NONCLUSTERED INDEX [IXCKEY] ON [DBO].[CUSTOMERSBIG]
(
	[CKEY] ASC
)
INCLUDE([COMPANYNAME],[CONTACTNAME],[INSERTEDDATE]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  


--ALTERANDO A PROCEDURE
ALTER PROCEDURE st_Proc0 @cKey VARCHAR(250)  
AS  
BEGIN  
	SELECT 
		 cKey,
		 CustomerID ,
         CompanyName ,
         ContactName,  
         InsertedDate 
         --cKey,  
         Col1  
    FROM CustomersBig 
   WHERE cKey  = @cKey /* Busca pelo valor original */  
      --OR cKey = LOWER(@cKey) /* Busca pelo valor em maiúsculo */  
      --OR cKey = UPPER(@cKey) /* Busca pelo valor em minúsculo */  
   OPTION(RECOMPILE, MAXDOP 1) /* RECOMPILE - Não pode ser removido devido a problema de parameter sniffing */  

END  

