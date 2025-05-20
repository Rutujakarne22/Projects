use onlinebookstore;

select*from orders;
select*from customers;
select*from books;

-- Basic Queries
# 1) Retrieve all books in the "Fiction" genre
select * from books where genre ="Fiction";

#2) Find books published after the year 1950
select*from books where Published_Year>1950;

#3) List all customers from the Canada
select*from customers where country='canada';

#4) Show orders placed in November 2023
select *from orders where 
order_date between '2023-11-1' and '2023-11-30';

#5) Retrieve the total stock of books available
select sum(stock) as total_stock from books;

#6) Find the details of the most expensive book
select * from books 
order by price desc limit 1;

#7)Show all customers who ordered more than 1 quantity of a book
select * from orders where quantity>1;

#8)Retrieve all orders where the total amount exceeds $20
select*from orders where Total_Amount>20;

#9) List all genres available in the Books table
select distinct(genre) from books ;

#10) Find the book with the lowest stock
select *from books order by stock limit 1;

#11) Calculate the total revenue generated from all orders
select sum(Total_Amount) as Total_Revenue from orders;

-- Advanced Queries

#1) Retrieve the total number of books sold for each genre
select b.Genre ,sum(o.quantity) as total_no_books
from books as b
join orders as o
on b.book_id=o.Book_ID
group by b.genre;

#2) Find the average price of books in the "Fantasy" genre
select avg(price) as Average_Price
from books
where Genre="Fantasy";

#3) List customers who have placed at least 2 orders
SELECT c.name,o.Customer_ID,count(o.Order_ID) as order_count 
from orders as o
join customers as c
on o.Customer_ID= c.Customer_ID
group by o.Customer_ID,c.name
having count(o.Order_ID)>=2;

#4) Find the most frequently ordered book
SELECT o.Book_ID,b.title,count(o.order_id) as frequently_order_book
from orders as o
join books as b
on o.Book_ID=b.Book_ID
group by o.Book_ID,b.title
order by count(o.order_id) desc limit 1;

#5) Show the top 3 most expensive books of 'Fantasy' Genre
select * from books where genre= 'Fantasy' order by price
desc limit 3;

#6) Retrieve the total quantity of books sold by each author
select b.author,sum(o.quantity) as total_books_sold
from orders as o
join books as b
on b.Book_ID=o.Book_ID
group by b.author;

#7) List the cities where customers who spent over $30 are located
select distinct c.city,o.Total_amount 
from customers as c
join orders as o
on c.Customer_ID=o.Customer_ID
where o.Total_Amount>30;

#8) Find the customer who spent the most on orders
select c.customer_id,c.name, sum(o.total_amount) as total_spend
from customers as c
join orders as o
on c.Customer_ID=o.Customer_ID
group by c.customer_id,c.name
order by sum(o.total_amount) desc limit 1;

#9) Calculate the stock remaining after fulfilling all orders

select b.book_id,b.title,b.stock ,coalesce(sum(o.quantity),0) as order_quantity,
b.stock-coalesce(sum(o.quantity),0) as remaining_quantity
from books as b
left join orders as o
on b.Book_ID=o.Book_ID
group by b.book_id,b.title,b.stock ;


