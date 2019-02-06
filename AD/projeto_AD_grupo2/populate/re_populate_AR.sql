use area_ar;


SET SQL_SAFE_UPDATES = 0;

delete from sales_fact;

delete from dim_customer;
delete from dim_employee;
delete from dim_local;
delete from dim_product;
delete from dim_shipper;
delete from dim_supplier;

ALTER TABLE sales_fact AUTO_INCREMENT = 1;
ALTER TABLE dim_customer AUTO_INCREMENT = 1;
ALTER TABLE dim_employee AUTO_INCREMENT = 1;
ALTER TABLE dim_local AUTO_INCREMENT = 1;
ALTER TABLE dim_product AUTO_INCREMENT = 1;
ALTER TABLE dim_shipper AUTO_INCREMENT = 1;
ALTER TABLE dim_supplier AUTO_INCREMENT = 1;



-- DIM_CUSTOMER
INSERT INTO dim_customer (id_c, company, name, job_title, last_update) SELECT id, COALESCE(company,'Desconhecido'), COALESCE(concat(first_name," ",last_name),'Desconhecido'), COALESCE(job_title,'Desconhecido'), now() FROM northwind.customers;
INSERT INTO dim_customer (id, id_c, company, name, job_title, last_update) VALUES (-1, -1, 'Desconhecido', 'Desconhecido','Desconhecido','1975-01-01 00:00:00');

-- DIM_EMPLOYEE
INSERT INTO dim_employee (id_e, company, name, job_title, last_update) SELECT id, COALESCE(company,'Desconhecido'), COALESCE(concat(first_name," ",last_name),'Desconhecido'), COALESCE(job_title,'Desconhecido'), now() FROM northwind.employees;
INSERT INTO dim_employee (id, id_e, company, name, job_title, last_update) VALUES (-1, -1, 'Desconhecido', 'Desconhecido','Desconhecido','1975-01-01 00:00:00');


-- DIM_LOCAL
INSERT INTO dim_local (city, state, country, last_update) SELECT DISTINCT COALESCE(city,'Desconhecido'), COALESCE(state_province,'Desconhecido'), COALESCE(country_region,'Desconhecido'), now() FROM northwind.customers; 
INSERT INTO dim_local (id, city, state, country, last_update) VALUES (-1, 'Desconhecido', 'Desconhecido', 'Desconhecido', '1975-01-01 00:00:00' );

-- DIM_PRODUCT
INSERT INTO dim_product (id_p, name, category_name, standard_cost, discontinued, last_update) 
				SELECT id, COALESCE(product_name,'Desconhecido'), COALESCE(category,'Desconhecido'), COALESCE(standard_cost,0), COALESCE(discontinued,0), now() FROM  northwind.products;

-- DIM_SHIPPER
INSERT INTO dim_shipper (id_sh, name, last_update) SELECT id, COALESCE(company,'Desconhecido'), now() FROM northwind.shippers;
INSERT INTO dim_shipper (id, id_sh, name, last_update) VALUES (-1, -1, 'Desconhecido', '1975-01-01 00:00:00');

-- DIM_SUPPLIER
INSERT INTO dim_supplier (id_su, company, last_update) SELECT id, COALESCE(company,'Desconhecido'), now() FROM northwind.suppliers;
INSERT INTO dim_supplier (id, id_su, company, last_update) VALUES (-1, -1, 'Desconhecido', '1975-01-01 00:00:00');


-- SALES_FACT
INSERT INTO sales_fact (order_id, quantity, total_price, discount, preparation_time, last_update, dim_product_id, dim_shipper_id, dim_supplier_id, dim_employee_id, 
			dim_customer_id, order_date, shipped_date, payment_date, customer_local)
						SELECT order_id, quantity, quantity * unit_price as total_price, discount, COALESCE(DATEDIFF(shipped_date,order_date),-1) as prep_time, now(), 
                        (select dim_product.id from dim_product where dim_product.id_p = product_id),
						COALESCE((select dim_shipper.id from dim_shipper where dim_shipper.id_sh = shipper_id),-1), 
                        (select dim_supplier.id from dim_supplier where dim_supplier.id_su = SUBSTRING_INDEX(supplier_ids, ";", 1)), 
                        (select dim_employee.id from dim_employee where dim_employee.id_e = employee_id), 
                        (select dim_customer.id from dim_customer where dim_customer.id_c = customer_id), 
                        (select dim_time.id from dim_time where date = date(order_date)) as order_date, 
                        COALESCE((select dim_time.id from dim_time where date = date(shipped_date)),-1) as shipped_date,
						COALESCE((select dim_time.id from dim_time where date = date(paid_date)),-1) as payment_date,
						COALESCE((select dim_local.id where dim_local.id = northwind.customers.id),-1) as customer_local
							FROM northwind.order_details inner join northwind.orders on northwind.order_details.order_id = northwind.orders.id
														 inner join northwind.products on northwind.order_details.product_id = northwind.products.id
														 inner join northwind.customers on northwind.orders.customer_id = northwind.customers.id
														 inner join dim_local on dim_local.city = northwind.customers.city;
