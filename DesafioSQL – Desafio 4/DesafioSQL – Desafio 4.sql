ALTER PROCEDURE st_Proc0 @MinDate DATE, @MaxDate DATE 
AS  
BEGIN
	
  SELECT CustomerID,   
         ContactName,  
         InsertedDate  
		 ,CASE
			WHEN Info IS NULL THEN 'Info data is missing'
			WHEN Info.value('(/root)[1]', 'varchar(MAX)') = '' THEN 'Info data is missing'
			ELSE 'Info is OK'
		END AS InfoStatus 
  FROM Customers_4  
 WHERE InsertedDate BETWEEN @MinDate AND @MaxDate

END  