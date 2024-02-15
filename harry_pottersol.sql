create database harry_potter;
use harry_potter;

select * 
from wands;

select *
from wands_property;

/*Tasks that we'll perform in this case: 
1. We'll create a view as step1 with the following columns:
ID | Age | Coins_Needed | Power

This view should have the data sorted in descending order by 
Power first and then by Age in desc order. Idally, it should 
show 14 rows. 

2. Then, we'll only show the wand which takes the least coins_needed
among the same Power and the same age wands.
*/

select w.ID, wp.age, w.coins_needed, w.power
from wands w inner join wands_property wp on w.code = wp.code
where is_evil = 0
order by w.power desc, wp.age desc, w.coins_needed asc;

create view step1 as ( select w.ID, wp.age, w.coins_needed, w.power
from wands w inner join wands_property wp on w.code = wp.code
where is_evil = 0
order by w.power desc, wp.age desc, w.coins_needed asc);

-- Step2: Only show those wands that require the minimum coins_needed
-- among the wands that have same power and age.

select *
from step1 as a 
where not exists (
		select * from step1 as b
        where b.power = a.power and b.age = a.age and 
				b.coins_needed < a.coins_needed);

