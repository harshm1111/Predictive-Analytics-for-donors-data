use #database
jgough2_FINAL_PROJECT;

#did not use this dataset
select a.*, b.*
from (select *
from CONSTITUENT)a 
left join 
(SELECT CONSTITUENT_ID, 
SUM(AMOUNT) as 'Total Amount donated'
FROM TRANSACTIONS 
GROUP BY CONSTITUENT_ID)b
on a.CONSTITUENT_ID=b.CONSTITUENT_ID;

#this is the data set USED. We got No of events attended and amount donated as a
#single line item for each constitent_id. So all our attributes are in the same row.
#we used left join so as to keep everything that is in the constituent table and add only
#those items from TRANSACTIONS and EVENT_ATTENDEE that matches a Constituent_id
select a.*, b.*, c.*
from (select *
from CONSTITUENT)a 
left join 
(select CONSTITUENT_ID, count(EVENT_ATTENDEE_ID) as 'No of events attended' from EVENT_ATTENDEE
group by CONSTITUENT_ID)b
on a.CONSTITUENT_ID=b.CONSTITUENT_ID
left join (SELECT CONSTITUENT_ID, 
SUM(AMOUNT) as 'Total Amount donated'
FROM TRANSACTIONS 
GROUP BY CONSTITUENT_ID)c
on a.CONSTITUENT_ID=c.CONSTITUENT_ID;
