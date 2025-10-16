USE sakila;
SELECT *
FROM staff
;

SELECT city.city_id, city.city
FROM city
;

SELECT *
FROM customer
WHERE customer.active = 1
;

SELECT *
FROM payment
WHERE payment.payment_date LIKE '2005-07%'
;

SELECT *
FROM rental
ORDER BY rental.rental_date DESC
LIMIT 15
;

SELECT customer.last_name, customer.first_name
FROM customer
ORDER by customer.last_name ASC
LIMIT 20
;

INSERT INTO language (language.name)
VALUES ("Friedelees")
;

INSERT INTO language (language.name)
VALUES ("Nepalees"),
	("Baskisch")
;

SELECT concat(customer.first_name,' ',customer.last_name), city.city
FROM customer
LEFT JOIN address USING (address_id)
LEFT JOIN city on address.city_id = city.city_id
;

SELECT concat(staff.first_name,' ',staff.last_name) as manager,  address.address as adres_van_de_store
FROM store
LEFT JOIN staff on store.manager_staff_id = staff.staff_id
LEFT JOIN address on store.address_id = address.address_id
;

SELECT store.store_id, count(rental.rental_id) as aantal_rentals_2005
FROM store
LEFT JOIN staff on store.manager_staff_id = staff.staff_id
LEFT JOIN rental on staff.staff_id = rental.staff_id
GROUP BY store.store_id
ORDER by aantal_rentals_2005 DESC
;

SELECT concat(customer.first_name,' ',customer.last_name) as klant, SUM(payment.amount) AS totale_betaalde_bedrag
FROM customer
left JOIN payment using (customer_id)
GROUP BY klant
HAVING totale_betaalde_bedrag > 100
ORDER BY totale_betaalde_bedrag DESC
;

DROP VIEW aantal_klanten_per_city;
CREATE VIEW aantal_klanten_per_city
AS
SELECT city.city, count(customer.customer_id) as customer_count
FROM city
LEFT JOIN address on city.city_id = address.city_id
LEFT JOIN customer on address.address_id = customer.address_id
GROUP BY city.city_id
ORDER BY customer_count DESC
;

DROP PROCEDURE IF EXISTS count_customer_films;
DELIMITER //
CREATE PROCEDURE count_customer_films(OUT aantal_films INT)
BEGIN
SELECT concat(customer.first_name, customer.last_name) as klant, COUNT(rental.rental_id) as aantal
FROM customer
LEFT JOIN rental USING (customer_id)
END //
DELIMITER ;

CREATE DATABASE IF NOT EXISTS db_developerprojects
	CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci ;

USE DATABASE db_developerprojects;

CREATE TABLE developer (
	developer_id INT(10) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL
);

CREATE TABLE project (
    project_id INT(10) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE project_developer (
	developer_id INT(10) UNSIGNED PRIMARY KEY,
    project_id INT(10) UNSIGNED PRIMARY KEY,
    role VARCHAR(50) NOT NULL,
    PRIMARY KEY (developer_id) REFERENCES developer(developer_id)
    	ON DELETE RESTRICT
    	ON UPDATE RESTRICT,
    PRIMARY KEY (project_id) REFERENCES project(project_id)
    	ON DELETE RESTRICT
    	ON UPDATE RESTRICT
);