Create warehouse TEST_WAREHOUSE;
Create database TEST_DATABASE;
USE database TEST_DATABASE;


Create or replace table SALES_DATA
(order_id varchar(60),
order_date varchar(60) primary key,
ship_date varchar(60),
ship_mode varchar(60),
customer_name varchar(60),
segment varchar(60),
state varchar(60),
country	varchar(60),
market varchar(60),
region varchar(60),
product_id varchar(60),	
category varchar (60),
sub_category varchar(60),	
product_name varchar,	
sales number(10,0),
quantity varchar(60),	
discount varchar(60),
profit varchar(60),
shipping_cost varchar(60),	
order_priority varchar(60),
year int);

DESCRIBE TABLE SALES_DATA;

Select * from SALES_DATA;

-----2. Change the Primary key to Order Id Column.

ALTER TABLE SALES_DATA DROP PRIMARY KEY;

Alter TABLE SALES_DATA ADD PRIMARY KEY (order_id);

---3. Check the data type for Order date and Ship date and mention in what data type it should be?

--Already YYYY-MM-DD data type uploaded

---4. Create a new column called order_extract and extract the number after the last ‘–‘from Order ID column.
 
select ORDER_ID, substring(ORDER_ID,9,9) as ORDER_EXTRACT from SALES_DATA;

---5. Create a new column called Discount Flag and categorize it based on discount. Use ‘Yes’ if the discount is greater than zero else ‘No’.

select *,
        CASE
            WHEN DISCOUNT >0 THEN 'YES'     
            ELSE 'NO'
        END AS Discount_Flag
FROM SALES_DATA;

---6. Create a new column called process days and calculate how many days it takes for each order id to process from the order to its shipment.
ALTER TABLE SALES_DATA add process_days int;

update SALES_DATA set process_days = datediff('day',DATE(ORDER_DATE),DATE(SHIP_DATE));

select datediff('day',DATE(ORDER_DATE),DATE(SHIP_DATE)) from SALES_DATA;

---7. Create a new column called Rating and then based on the Process dates give rating like given below.

---a. If process days less than or equal to 3days then rating should be 5
---b. If process days are greater than 3 and less than or equal to 6 then ratingshould be 4
---c. If process days are greater than 6 and less than or equal to 10 then rating should be 3
---d. If process days are greater than 10 then the rating should be 2.

ALTER TABLE SALES_DATA add RATING int;

update SALES_DATA set RATING =         
        CASE
            WHEN process_days <= '3' THEN '5'
                        WHEN process_days <= '6' and process_days > '3' THEN '4'
                        WHEN process_days <= '10' and process_days > '6' THEN '3'
                        ELSE '2'
            END
