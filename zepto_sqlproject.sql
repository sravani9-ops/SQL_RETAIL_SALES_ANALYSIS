-- Adding the primary key for the table as the table doesn't consist any primary key.
ALTER TABLE zepto_v2
ADD product_id INT IDENTITY(1,1) PRIMARY KEY;

--checking for no:of rows consist in table
select
count(*) as total_rows
from zepto_v2

--checking for nulls in table
select*from zepto_v2
select*from zepto_v2
where Category is null
or name is null
or mrp is null
or discountPercent is null
or availableQuantity is null
or discountedSellingPrice is null
or weightInGms is null
or outOfStock is null
or quantity is null

---exploring all the product categories in table.
select
category
from zepto_v2
group by category
order by category

-- checking the products in or outofstock
-- Products that are out of stock
SELECT 
count(*)as outofstock
FROM zepto_v2
WHERE outOfStock = 1;

-- Products that are in stock
SELECT 
count(*)as instock
FROM zepto_v2
WHERE outOfStock = 0;

--checking product names which are repeated
select*from zepto_v2
select
name,
count(product_id)
from zepto_v2
group by name
having count(name)>1
order by count(product_id) desc

--checking product price might be zero.
select
* from zepto_v2
where mrp='0' or discountedSellingPrice='0'
delete from zepto_v2
where product_id='3607'

--converting paisa to rupee.
update zepto_v2
set mrp=mrp/100.0,
discountedSellingPrice=discountedSellingPrice/100.0;

--bussiness questions
--find the top 10 best-value product based on discount percentage./products with heighest discount price
select
top(10)
name,
mrp,
max(discountPercent) as max_discounted_percentage
from zepto_v2
group by name,mrp

order by max_discounted_percentage desc

--what are the products with high mrp but out of stock
select
name,
max(mrp) as heighest_price,
outofstock from zepto_v2
where outofstock='1'
group by name,outOfStock
order by max(mrp) desc

--calculate the estimated revenue for each category.

 select
category,
sum(discountedSellingPrice*availableQuantity) as total_revenue
from zepto_v2
group by Category
order by total_revenue desc

--find the products where mrp is graater than rs.500 and discount is less than 10%
select
name,
mrp,
discountpercent
from zepto_v2
where mrp>500 and discountpercent<10
order by mrp desc,discountPercent desc
--identify the top  5 categories offering the heighest average discount
select*from zepto_v2

select top 5  
category,
avg(discountpercent)as highest_Average_discount
from zepto_v2
group by Category
order by  highest_Average_discount desc


--find the price per gram for products above 100g and sort by best value
SELECT
    name,
    weightInGms,
    discountedSellingPrice,
    ROUND(CAST(discountedSellingPrice AS FLOAT) / weightInGms, 2) AS price_per_gm
FROM zepto_v2
WHERE weightInGms > 100
ORDER BY price_per_gm ASC;

--group the products into categories like low,medium anad high
select 
distinct name,
weightingms,
case 
when weightInGms between '100' and '1000' then 'Low'
when weightingms between '1001' and'5000' then 'medium'
when weightingms between '5001' and '10000' then 'high'
else 'others'
end as grouping
from zepto_v2
order by weightInGms 

--what is the total inventory weight per category.
SELECT
    category,
    SUM(CAST(weightInGms AS BIGINT) * CAST(availableQuantity AS BIGINT)) AS weight_for_category
FROM zepto_v2
GROUP BY category
order by weight_for_category
