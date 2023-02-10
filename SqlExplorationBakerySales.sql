/*Exploring BakerySales Dataset in RDBMS Model,  P.S Dataset*/

/* Revenue Price Difference between the two years operated*/
select ddt.Year,
sum(dtpt.PriceFreq) as totalmonthsrevenue
from dbo.ticketpurchase_table as dtpt
left join dbo.Date_table as ddt
on dtpt.Orderdate = ddt.Date
group by ddt.Year;

/* Revenue Price Difference between months, sum of 2021 and 2022 in the specific month*/
select MonthName,
sum(dtpt.PriceFreq) as totalmonthsrevenue
from dbo.ticketpurchase_table as dtpt
left join dbo.Date_table as ddt
on dtpt.Orderdate = ddt.Date
group by MonthName;


/* Revenue Price Difference in 3rd Quarter(Summer surge) between 2021 and 2022*/
with thirdquarter as
(select ddt.[MonthName] as monthname, ddt.Year as specificyear,
sum(dtpt.PriceFreq) as totalmonthsrevenue
from dbo.ticketpurchase_table as dtpt
left join dbo.Date_table as ddt
on dtpt.Orderdate = ddt.Date
where [MonthName] in ('July', 'August', 'September')
group by ddt.[MonthName], ddt.Year)

select monthname, specificyear, totalmonthsrevenue
from thirdquarter
order by monthname desc;


/* Top 5 Most demanded articles*/
with topfive as
(select ddt.article,
SUM(dtpt.quantity) as totaldemand
from [dbo].[ticketpurchase_table] as dtpt
left join [dbo].[Article_table] as ddt
on dtpt.article = ddt.article
group by ddt.article)

select top 5 article, totaldemand
from topfive
order by totaldemand desc;

/* Top 5 demanded articles between 2021 and 2022*/
with topfive as
(select dat.article, ddt.Year as years,
SUM(dtpt.quantity) as totaldemand
from [dbo].[ticketpurchase_table] as dtpt
left join [dbo].[Article_table] as dat
on dtpt.article = dat.article
right join [dbo].[Date_table] as ddt
on dtpt.orderdate =ddt.date
group by dat.article, ddt.Year)

select top 10 article, years, totaldemand
from topfive
order by 3 desc;

/* Top 5 demanded articles in 3rd Quarter in summer between 2021 and 2022*/
with topfive as
(select dat.article, ddt.Year as years,
SUM(dtpt.quantity) as totaldemand
from [dbo].[ticketpurchase_table] as dtpt
left join [dbo].[Article_table] as dat
on dtpt.article = dat.article
right join [dbo].[Date_table] as ddt
on dtpt.orderdate =ddt.date
where ddt.MonthName in ('June', 'July')
group by dat.article, ddt.Year)

select top 10 article, years, totaldemand
from topfive
order by 3 desc;



/* Sum of Top 5 demanded articles sold by day*/
select dtpt.Orderdate,
SUM (case 
when dtpt.article = 'TRADITIONAL BAGUETTE' then 1 else 0 end) as baguette,
SUM (case 
when dtpt.article = 'SANT' then 1 else 0 end) as croissant,
SUM (case 
when dtpt.article = 'PAIN AU CHOCOLAT' then 1 else 0 end) as chocolate,
SUM (case 
when dtpt.article = 'COUPE' then 1 else 0 end) as coupe,
SUM (case 
when dtpt.article = 'BANETTE' then 1 else 0 end) as banette
from dbo.ticketpurchase_table as dtpt
group by dtpt.Orderdate
order by 1;


/* Highest quantity sold per day*/
select ddt.Date,
MAX(dtpt.quantity) as maxsolddaily,
MAX(dtpt.pricefreq) as highestrevenue
from dbo.ticketpurchase_table as dtpt
join dbo.Date_table as ddt
on dtpt.Orderdate = ddt.Date
group by ddt.Date
order by 2 desc;

/*Highest Revenue earned per day*/
select ddt.Date,
MAX(dtpt.quantity) as maxsolddaily,
MAX(dtpt.pricefreq) as highestrevenue
from dbo.ticketpurchase_table as dtpt
join dbo.Date_table as ddt
on dtpt.Orderdate = ddt.Date
group by ddt.Date
order by 3 desc;

/*Maximum quantity and total revenue earned per day during summer surge 2021*/
select ddt.Date,
MAX(dtpt.quantity) as maxsolddaily,
sum(dtpt.pricefreq) as totalrevenue,
DATENAME(MM, ddt.Date) AS month_name
from dbo.ticketpurchase_table as dtpt
join dbo.Date_table as ddt
on dtpt.Orderdate = ddt.Date
where Date between '2021-07-01' and '2021-09-01'
group by ddt.Date
order by 1;

/*Maximum quantity and total revenue earned per day during summer surge 2022*/
select ddt.Date,
MAX(dtpt.quantity) as maxsolddaily,
sum(dtpt.pricefreq) as totalrevenue,
DATENAME(MM, ddt.Date) AS month_name
from dbo.ticketpurchase_table as dtpt
join dbo.Date_table as ddt
on dtpt.Orderdate = ddt.Date
where Date between '2022-07-01' and '2022-09-01'
group by ddt.Date
order by 1;




--Average quantity sold during summer surge 2021 and 2022
select orderdate, 
AVG(quantity) as averagequantitysold,
VAR(quantity) as variance,
ddt.Year as specificyear
from dbo.ticketpurchase_table as dtpt
left join dbo.Date_table as ddt
on dtpt.Orderdate = ddt.Date
where [MonthName] in ('July', 'August', 'September')
group by orderdate, ddt.Year
order by 3 desc






