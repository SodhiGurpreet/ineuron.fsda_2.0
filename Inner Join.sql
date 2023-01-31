USE warehouse TEST_WAREHOUSE;

USE database TEST_DATABASE;

create or replace table cows_one (cnum int, breeds varchar(20));

insert into cows_one values (2, 'Jersey');
insert into cows_one values (3, 'Brown Swiss');
insert into cows_one values (4, 'Ayrshire');


create or replace table cows_two (cnum int, cbreeds varchar(20));

insert into cows_two values (1, 'Holstein');
insert into cows_two values (2, 'Guernsey');
insert into cows_two values (3, 'Angas');
insert into cows_two values (4, 'Mou');

select * from cows_two;

select x.*, y.cbreeds
from cows_one as x
inner join cows_two as y on x.cnum_1 = y.cnum_2;
---------------------------------------------------------------------------------------------------------------------

select x.*, y.BREEDS
from cows_two as x
left outer join cows_one as y on x.cnum = y.cnum;
--------------------------------------------------------------------------------------------------------------------------

create or replace table GS_Owner
(
 OwnerId int NOT NULL PRIMARY KEY,
 Name VARCHAR(50),
 Surname STRING,
 Streetaddress VARCHAR(50),
 City STRING,
 State CHAR(4),
 Statefull STRING,
 Zipcode Int
);

select * from GS_Owner;


create or replace table GS_Pets
(
 PetId VARCHAR(10) NOT NULL PRIMARY KEY,
 Name VARCHAR(20),
 Kind STRING,
 Gender CHAR(7),
 Age INTEGER,
 OwnerId INTEGER NOT NULL REFERENCES GS_Owner
);

select * from GS_Pets ;

----------------MASTER TABLE OF ONLY OWNERS HAVING PETS-------------------------------------------------------------
Create or replace table GS_OWNER_PETS AS

select o.Name as Owner_Name,o.OwnerId, p.Name as PET_NAME,kind,Gender
from GS_Owner as o
inner join GS_Pets as p on o.OwnerId = p.OwnerId;

SELECT * FROM GS_OWNER_PETS;
---------------------------------------------------------------------------------------------------------------------
 
 
Create or replace table GS_PETS_OWNER AS

select p.name as pet,p.PetId, o.name as owner, o.OwnerId
from GS_Pets as p left outer join GS_Owner as o on p.OwnerId = o.OwnerId;

select * from GS_PETS_OWNER;

------------------------------------------------------------------------------------------------------------------

