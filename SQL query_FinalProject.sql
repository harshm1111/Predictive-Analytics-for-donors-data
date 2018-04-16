use #database
jgough2_FINAL_PROJECT;

#Based on Age group
#used case statements to group people in age categories.
SELECT count(c.CONSTITUENT_ID) as No_of_Donors, round(sum(AMOUNT), 2) as total_money_collected, round(round(sum(AMOUNT), 2) / count(c.CONSTITUENT_ID), 2) AS Average_donations, 
CASE 
WHEN AGE < 20 THEN '19 and below'
WHEN AGE >= 20 and AGE <=29 THEN '20s'
WHEN AGE >= 30 and AGE <=39 THEN '30s'
WHEN AGE >= 40 and AGE <=49 THEN '40s'
WHEN AGE >= 50 and AGE <=59 THEN '50s'
WHEN AGE >= 60 and AGE <=69 THEN '60s'
WHEN AGE >= 70 THEN '70s and above'
END AS Age_group
from CONSTITUENT c JOIN TRANSACTIONS t on c.CONSTITUENT_ID=t.CONSTITUENT_ID
group by Age_group
order by Age_group;


#based on gender
Select GENDER, count(distinct c.CONSTITUENT_ID) as No_of_Donors, 
	   round(sum(AMOUNT), 2) as total_money_collected, 
       round(sum(AMOUNT), 2) / count(c.CONSTITUENT_ID) AS Average_donations
from CONSTITUENT c JOIN TRANSACTIONS t on c.CONSTITUENT_ID=t.CONSTITUENT_ID
group by GENDER;

#based on Marital status
#used case to assign 1 as married and 0 as single/divorcee
Select CASE
WHEN MARRIED = 1 then 'Married'
WHEN MARRIED = 0 then 'Single/divorcee'
END AS 'Marital Status'
, count(distinct c.CONSTITUENT_ID) as No_of_Donors, 
	   round(sum(AMOUNT), 2) as total_money_collected, 
       round(round(sum(AMOUNT),2) / count(c.CONSTITUENT_ID), 2) AS Average_donations
from CONSTITUENT c JOIN TRANSACTIONS t on c.CONSTITUENT_ID=t.CONSTITUENT_ID
group by MARRIED;

#distribution of the donors

Select CITY, STATE,  
       count(distinct c.CONSTITUENT_ID) as 'Total no of Donor', 
       round(sum(AMOUNT),2) as 'Total money collected'
from   CONSTITUENT c JOIN TRANSACTIONS t on c.CONSTITUENT_ID = t.CONSTITUENT_ID
group by CITY
order by sum(AMOUNT) DESC;

#checking to see how many donors/how many donated/how many attended events/how much was collected by the people who attend events

select * from (select count(distinct CONSTITUENT_ID) as 'Total number of donors' from CONSTITUENT) a
cross join
(select count(distinct CONSTITUENT_ID) as 'Total number of people who donated' from TRANSACTIONS) b
cross join
(Select round(sum(AMOUNT),2) as 'Total money collected' from TRANSACTIONS) c
cross join
(select count(distinct CONSTITUENT_ID) as 'No of people who attended events' from EVENT_ATTENDEE) d
cross join
(select count(distinct CONSTITUENT_ID) as 'No of event attendees who donated' from EVENT_ATTENDEE
	   where CONSTITUENT_ID IN (SELECT CONSTITUENT_ID from TRANSACTIONS)) e
cross join
(Select round(sum(AMOUNT),2) as 'Total money collected from event attendees'
 from TRANSACTIONS 
where CONSTITUENT_ID IN (SELECT CONSTITUENT_ID from EVENT_ATTENDEE)) f;






