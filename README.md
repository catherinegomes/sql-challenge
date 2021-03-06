## SQL and MySQLWorkbench 5.7

**The goals of the sql-challenge are to:**
* Create a localhost connection to a MySQL server and successfully connect to it.
* Create, use, and populate a MySQL database with data.
* Create, populate, and select data from a MySQL table.
* Import large CSV datasets into MySQL Workbench using the import wizard.
* Use MySQL to select specific rows/columns of data out from a table.
* Understand the different kinds of joins and how to use them to create new tables in MySQL.
* Solidify the foundations of writing basic- to intermediate-level MySQL statements.
    <br/>

    *-- Sakila db available in [Instructions](Instructions/Installation.md) --*

    **USE sakila;**
<br/>   

* 1a Display the first and last names of all actors from the table `actor`.

    **SELECT first_name, last_name FROM actor;**
<br/>

* 1b. Display the first and last name of each actor in a single column in upper case letters. Name the column `Actor Name`.

    **SELECT CONCAT(first_name, ' ', last_name)** 
    **AS 'Actor Name' FROM actor;**
<br/>

* 2a. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you use to obtain this information?

    **SELECT actor_id, first_name, last_name FROM actor**

    **WHERE first_name = 'Joe';**
<br/>

* 2b. Find all actors whose last name contain the letters `GEN`:

    **SELECT * FROM actor**

    **WHERE last_name LIKE '%gen%';**
<br/>

* 2c. Find all actors whose last names contain the letters `LI`. This time, order the rows by last name and first name, in that order:

    **SELECT * FROM actor**

    **WHERE last_name LIKE '%li%'**

    **ORDER BY last_name, first_name;**
<br/>

* 2d. Using `IN`, display the `country_id` and `country` columns of the following countries: Afghanistan, Bangladesh, and China:

    **SELECT country_id, country FROM country**

    **WHERE country IN ('Afghanistan', 'Bangladesh', 'China');**
<br/>

* 3a. You want to keep a description of each actor. You don't think you will be performing queries on a description, so create a column in the table `actor` named `description` and use the data type `BLOB` (Make sure to research the type `BLOB` as the difference between it and `VARCHAR` are significant).

    **ALTER TABLE actor ADD column description BLOB;**
<br/>

* 3b. Very quickly you realize that entering descriptions for each actor is too much effort. Delete the `description` column.

    **ALTER TABLE actor DROP COLUMN description;**
<br/>

* 4a. List the last names of actors, as well as how many actors have that last name.

    **SELECT last_name, count(last_name) FROM actor**

    **GROUP BY last_name;**
<br/>

* 4b. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors.

    **SELECT last_name, count(last_name) FROM actor**

    **GROUP BY last_name**

    **HAVING count(last_name) > 2;**
<br/>

* 4c. The actor `HARPO WILLIAMS` was accidentally entered in the `actor` table as `GROUCHO WILLIAMS`. Write a query to fix the record.

    **SET SQL_SAFE_UPDATES = 0;**

    **UPDATE actor**

    **SET first_name = 'HARPO'**

    **WHERE first_name = 'GROUCHO' AND last_name = 'WILLIAMS';**

    **SET SQL_SAFE_UPDATES = 1;**
<br/>

* 4d. Perhaps we were too hasty in changing `GROUCHO` to `HARPO`. It turns out that `GROUCHO` was the correct name after all! In a single query, if the first name of the actor is currently `HARPO`, change it to `GROUCHO`.

    *-- Remove safety to permit update --*

    **SET SQL_SAFE_UPDATES = 0;**

    **UPDATE actor**

    **SET first_name = 'GROUCHO'**

    **WHERE first_name = 'HARPO' AND last_name = 'WILLIAMS';**

    *-- Turn safety back on --*

    **SET SQL_SAFE_UPDATES = 1;**
<br/>

* 5a. You cannot locate the schema of the `address` table. Which query would you use to re-create it?
* Hint: [https://dev.mysql.com/doc/refman/5.7/en/show-create-table.html](https://dev.mysql.com/doc/refman/5.7/en/show-create-table.html)

    **SHOW CREATE TABLE address;**

    **DESCRIBE sakila.address;**
<br/>

* 6a. Use `JOIN` to display the first and last names, as well as the address, of each staff member. Use the tables `staff` and `address`:

    **SELECT s.first_name, s.last_name, a.address**

    **FROM staff s LEFT JOIN address a ON s.address_id = a.address_id;**
<br/>
 
* 6b. Use `JOIN` to display the total amount rung up by each staff member in August of 2005. Use tables `staff` and `payment`.

    **SELECT s.first_name, s.last_name, SUM(p.amount) AS 'Total Amount'**

    **FROM staff s JOIN payment p  ON s.staff_id = p.staff_id**

    **WHERE p.payment_date LIKE '2005-08%'**

    **GROUP BY s.staff_id;**
<br/>

* 6c. List each film and the number of actors who are listed for that film. Use tables `film_actor` and `film`. Use inner join.

    **SELECT title, COUNT(actor_id) FROM film**

    **INNER JOIN film_actor a ON a.film_id = film.film_id**

    **GROUP BY title;**
<br/>

* 6d. How many copies of the film `Hunchback Impossible` exist in the inventory system?

    **SELECT title, count(inventory.film_id) FROM inventory**

    **INNER JOIN film ON inventory.film_id = film.film_id**

    **WHERE title = 'Hunchback Impossible';**
<br/>

* 6e. Using the tables `payment` and `customer` and the `JOIN` command, list the total paid by each customer (alphabetically by last name):

    **SELECT first_name, last_name, sum(payment.amount) FROM customer**

    **INNER JOIN payment ON customer.customer_id = payment.customer_id**

    **GROUP BY payment.customer_id ORDER BY last_name;**
 
![Total amount paid](Images/total_payment.png)
<br/>

* 7a. Use subqueries to display the titles of movies starting with the letters `K` and `Q` whose language is English.

    **SELECT title FROM film**

    **WHERE title LIKE 'K%' OR title LIKE 'Q%';**
<br/>

* 7b. Use subqueries to display all actors who appear in the film `Alone Trip`.

    **SELECT first_name, last_name FROM actor**

    **JOIN film_actor USING(actor_id)**

    **JOIN film USING(film_id)**

    **WHERE title = 'Alone Trip';**
<br/>

* 7c. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. Use joins to retrieve this information.

    **SELECT first_name, last_name, email FROM customer**

    **JOIN address USING (address_id)**

    **JOIN city USING(city_id)**

    **JOIN country USING(country_id)**

    **WHERE country = 'Canada';**
<br/>

* 7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as _family_ films.

    **SELECT title, name FROM film**

    **JOIN film_category USING(film_id)**

    **JOIN category USING(category_id)**

    **WHERE name = 'Family';**
<br/>

* 7e. Display the most frequently rented movies in descending order.

    **SELECT title, COUNT(rental_date) FROM film**

    **JOIN inventory USING(film_id)**

    **JOIN rental USING(inventory_id)**

    **GROUP BY title**

    **ORDER BY COUNT(rental_date) DESC;**
<br/>
 
* 7f. Write a query to display how much business, in dollars, each store brought in.

    **SELECT SUM(amount), store_id FROM payment**

    **JOIN customer USING(customer_id)**

    **JOIN store USING (store_id)**

    **GROUP BY store_id;**
<br/>

* 7g. Write a query to display for each store its store ID, city, and country.

    **SELECT store_id, city, country FROM store**

    **JOIN address USING(address_id)**

    **JOIN city USING (city_id)**

    **JOIN country USING (country_id)**

    **GROUP BY store_id;**
<br/>

* 7h. List the top five genres in gross revenue in descending order. (**Hint**: you may need to use the following tables: category, film_category, inventory, payment, and rental.)

    **SELECT name, SUM(amount) FROM rental**

    **JOIN inventory USING(inventory_id)**

    **JOIN payment USING(rental_id)**

    **JOIN film_category USING(film_id)**

    **JOIN category USING (category_id)**

    **GROUP BY name**

    **ORDER BY SUM(amount) DESC**

    **LIMIT 5;**
<br/>

* 8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. Use the solution from the problem above to create a view. If you haven't solved 7h, you can substitute another query to create a view.

    **CREATE VIEW Top_Five AS** 

    **SELECT name, SUM(amount) FROM rental**

    **JOIN inventory USING(inventory_id)**

    **JOIN payment USING(rental_id)**

    **JOIN film_category USING(film_id)**

    **JOIN category USING (category_id)**

    **GROUP BY name**

    **ORDER BY SUM(amount) DESC**

    **LIMIT 5;**
<br/>

* 8b. How would you display the view that you created in 8a?

    **SELECT * FROM sakila.top_five;**
 <br/>   

* 8c. You find that you no longer need the view `top_five_genres`. Write a query to delete it.

    **DROP VIEW IF EXISTS sakila.top_five;**