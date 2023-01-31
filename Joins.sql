USE warehouse TEST_WAREHOUSE;

USE database TEST_DATABASE;

create or replace table GS_Broker
(
 BrokerID INTEGER not null primary key,
 BrokerCode string,
 BrokerFullName VARCHAR(30),
 DistributionNetwork VARCHAR(30),
 DistributionChannel VARCHAR(30),
 CommissionScheme string
);

select * from GS_Broker;
------------------------------------------------------------------------------------------------------------------------

create or replace table GS_Product
(
  ProductID STRING not null primary key,
  ProductCategory VARCHAR(50),
  ProductSubCategory VARCHAR(50),
  Product string
);

select * from GS_Product;

----------------------------------------------------------------------------------------------------------------

create or replace table GS_Region
(
 Region_id INTEGER NOT NULL PRIMARY KEY,
 Region_Name VARCHAR,
 county VARCHAR,
 state_code VARCHAR(30),
 state VARCHAR(30),
 type VARCHAR(30),
 latitude int,
 longitude int,
 area_code int,
 population int,
 households int,
 median_income int,
 land_area int,
 water_area int,
 time_zone VARCHAR(60)
);

select * from GS_Region;

------------------------------------------------------------------------------------------------------------------


create or replace table GS_Customer
(
 CustomerID INTEGER NOT NULL PRIMARY KEY,
 LastName VARCHAR(60),
 FirstName VARCHAR(60),
 BirthDate string,
 Gender VARCHAR(40),
 ParticipantType VARCHAR(60),
 RegionID INTEGER,
 MaritalStatus VARCHAR(60)
);

select * from GS_Customer;

-----------------------------------------------------------------------------------------------------------------
create or replace table GS_StateCode
(
 State_Code VARCHAR(10) NOT NULL PRIMARY KEY,
 State VARCHAR(40),
 Region VARCHAR(40)
);


select * from GS_StateCode;

---------------------------------------------------------------------------------------------------------------

create or replace table GS_Priorities
(
 ID VARCHAR(10) NOT NULL PRIMARY KEY,
 Description VARCHAR(10) 
);

select * from GS_Priorities;

--------------------------------------------------------------------------------------------------------------

create or replace table GS_Statuses
(
 ID VARCHAR(10) NOT NULL PRIMARY KEY,
 Description VARCHAR(60) 
);

select * from GS_Statuses;

----------------------------------------------------------------------------------------------------------------


create or replace table GS_Categories
(
 ID INTEGER NOT NULL PRIMARY KEY,
 Description VARCHAR,
 Active Integer
);

select * from GS_Categories;

---------------------------------------------------------------------------------------------------------------
create or replace table GS_Sources
(
 ID INTEGER NOT NULL PRIMARY KEY,
 Description VARCHAR
);

select * from GS_Sources;

-------------------------------------------------------------------------------------------------------------
create or replace table GS_Types
(
 ID INTEGER NOT NULL PRIMARY KEY,
 Description VARCHAR
);

select * from GS_Types;
---------------------------------------------------------------------------------------------------------
create or replace table GS_Complain_data
(
 ID INTEGER NOT NULL PRIMARY KEY,
 ComplainDate string,
 CompletionDate string,
 CustomerID integer,
  BrokerID integer,
  ProductID integer,
  ComplainPriorityID integer,
  ComplainTypeID integer,
  ComplainSourceID integer,
  ComplainCategoryID integer,
  ComplainStatusID integer,
  AdministratorID string,
  ClientSatisfaction VARCHAR(60),
  ExpectedReimbursement integer
);
  
select * from GS_Complain_data;

------------------------------------------------------------------------------------------------------------

create or replace table GS_History_data
(
 ID INTEGER NOT NULL PRIMARY KEY,
 ComplaintID INTEGER,
 ComplaintStatusID INTEGER,
 StatusDate string
);


select * from GS_History_data;

---------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE TABLE GS_CUST_MASTER AS
SELECT COM.ID,COM.ComplainDate,COM.CompletionDate,CUS.FirstName,CUS.LastName,CUS.Gender,BR.BrokerFullName,
BR.CommissionScheme,SC.State_Code,REG.state,PRO.Product,CAT.Description AS CATDESC,ST.Description AS STDESC,
PRIOR.Description AS PRIORDESC,TY.Description AS TYDESC,SOU.Description AS SOUDESC

--------------select COM.*,CUS.*,REG.*,BR.*,CAT.*,SC.*,PRIOR.*,PRO.*,SOU.*,ST.*,TY.*
from GS_Complain_data AS COM
LEFT OUTER JOIN GS_Customer AS CUS ON COM.CustomerID = CUS.CustomerID
LEFT OUTER JOIN GS_History_data AS HD ON COM.ID = HD.ID
LEFT OUTER JOIN GS_Region AS REG ON CUS.RegionID = REG.Region_id
LEFT OUTER JOIN GS_StateCode AS SC ON REG.state_code = SC.state_code
LEFT OUTER JOIN GS_Broker AS BR ON COM.BrokerID = BR.BrokerID
LEFT OUTER JOIN GS_Categories AS CAT ON COM.ComplainCategoryID = CAT.ID
LEFT OUTER JOIN GS_Priorities AS PRIOR ON COM.ComplainPriorityID = PRIOR.ID
LEFT OUTER JOIN GS_Product AS PRO ON COM.ProductID = PRO.ProductID
LEFT OUTER JOIN GS_Sources AS SOU ON COM.ComplainSourceID = SOU.ID
LEFT OUTER JOIN GS_Statuses AS ST ON COM.ComplainStatusID = ST.ID
LEFT OUTER JOIN GS_Types AS TY ON COM.ComplainTypeID = TY.ID;

select * from GS_CUST_MASTER;

select count(distinct id) from GS_CUST_MASTER;

select distinct * from GS_CUST_MASTER;;

DESCRIBE TABLE GS_CUST_MASTER;

