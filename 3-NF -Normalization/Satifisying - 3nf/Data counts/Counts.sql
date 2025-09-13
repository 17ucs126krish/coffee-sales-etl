/*
Script: Counts.sql

Purpose:
After normalizing the raw data into 3NF OLTP tables, this script is used to validate data completeness.
*/

--Checking counts of the products

Select count(*) as "Number_of_Products"
from products;

--Checking count of the stores

Select count(*) as "Number_of_Stores"
from stores;

--Checking the count of transactions

Select count(*) as "Number_of_transactions"
from transactions;

--Checking the count of number of items per transaction

Select count(*) as "items_count"
from transaction_items