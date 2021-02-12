SELECT * FROM credit_card_classification.credit_card_data order by customer_number desc;
#inspecting data to check import 
ALTER TABLE credit_card_data
DROP COLUMN Q4_Balance;
#dropped column
SELECT * FROM credit_card_classification.credit_card_data
where Customer_Number>17990 ; #returned last customer id as 18000
#checked drop 
select count(Customer_Number) as rows_count from credit_card_data;  #returned 17976 rows
# We noticed that there are 24 rows missing because they have no bank account apparently or inactive
# as they do not weight much we decided just to drop them 
# We have altered the table columns name to standardize header removing symbol and all into lower case

#Now we will try to find the unique values in some of the categorical columns:
#- What are the unique values in the column `Offer_accepted`?
#- What are the unique values in the column `Reward`?
#- What are the unique values in the column `mailer_type`?
#- What are the unique values in the column `credit_cards_held`?
#- What are the unique values in the column `household_size`?
SELECT DISTINCT offer_accepted from credit_card_classification.credit_card_data; # no,yes
SELECT DISTINCT reward from credit_card_classification.credit_card_data; #Air Miles, Cash Back, Points
SELECT DISTINCT mailer_type from credit_card_classification.credit_card_data; #Letter, Postcard
SELECT DISTINCT n_credit_cards_held from credit_card_classification.credit_card_data; #1,2,3,4
SELECT DISTINCT household_size from credit_card_classification.credit_card_data 
order by household_size desc;  # 1-9

#Arrange the data in a decreasing order by the average_balance of the house. 
#Return only the customer_number of the top 10 customers with the highest average_balances in your data.


SELECT customer_number, average_balance FROM credit_card_classification.credit_card_data order by average_balance desc limit 10;

#What is the average balance of all the customers in your data?
SELECT round(AVG(average_balance),2) AS "Rounded Avg."
FROM credit_card_classification.credit_card_data;

#10.1
SELECT average_balance, income_level
FROM credit_card_classification.credit_card_data group by income_level; # 1160.75, 147.25, 278.5

#10.2
select n_bank_accounts_open, round(avg(average_balance),2) AS "Avg Balance of Balance" from credit_card_classification.credit_card_data
GROUP BY n_bank_accounts_open;


#10.3
select credit_rating, round(avg(average_balance),2) AS "Avg_Balance_of_Balance" from credit_card_classification.credit_card_data
GROUP BY credit_rating;

#10.4
select n_credit_cards_held, round(avg(n_bank_accounts_open),2) as number_of_bank_accounts_open from credit_card_classification.credit_card_data
GROUP BY n_credit_cards_held
Order by n_credit_cards_held;
#no correlation 

#Your managers are only interested in the customers with the following properties:
#- Credit rating medium or high
#- Credit cards held 2 or less
#- Owns their own home
#- Household size 3 or more
#For the rest of the things, they are not too concerned. Write a simple query to find what are the options available
#for them? Can you filter the customers who accepted the offers here?

select * from credit_card_data
where credit_rating in ('Medium', 'High') 
	and offer_accepted ="Yes"
    and n_credit_cards_held < 3 
	and own_your_home='Yes' 
	and household_size > 2;


select customer_number, average_balance from credit_card_data
where  average_balance <(select round(avg(average_balance),2) from credit_card_data)
order by average_balance desc;

# CTE view 
with Customers__Balance_View1 as (
select customer_number, average_balance from credit_card_data
where  average_balance <(select round(avg(average_balance),2) from credit_card_data)
order by average_balance desc)
select * from Customers__Balance_View1;

# with permanent view
drop view if exists Customers__Balance_View1;
create view Customers__Balance_View1 as 
(
select customer_number, average_balance from credit_card_data
where  average_balance <(select round(avg(average_balance),2) from credit_card_data)
order by average_balance desc); 

#14. What is the number of people who accepted the offer vs number of people who did not?

SELECT  offer_accepted, count(customer_number) as number_customers from credit_card_classification.credit_card_data
group by offer_accepted;

#15

select (select round(avg(average_balance),2) from credit_card_data
where credit_rating = 'High')as high_rating_avg_balance,(select round(avg(average_balance),2) from credit_card_data
where credit_rating = 'Low') as low_rating_avg_balance,(round((select round(avg(average_balance),2) from credit_card_data
where credit_rating = 'High')-(select round(avg(average_balance),2) from credit_card_data
where credit_rating = 'Low'),2)) as difference from credit_card_data
limit 1;


#16
SELECT  mailer_type, count(customer_number) as number_customers from credit_card_classification.credit_card_data
group by mailer_type;


#17. Provide the details of the customer that is the 11th least `Q1_balance` in your database.

with q1_balance_rank as 
    ( SELECT *,
             dense_RANK() OVER (ORDER BY q1_balance  asc) AS Ranks
      FROM credit_card_data)
select * from q1_balance_rank 
where Ranks = 11









