use datawarehouse;

-- DIM_CUSTOMER
INSERT INTO dim_customer (id, id_c, company, name, job_title, last_update) SELECT id, id_c, company, name, job_title, last_update FROM area_ar.dim_customer;

-- DIM_EMPLOYEE
INSERT INTO dim_employee (id, id_e, company, name, job_title, last_update) SELECT id, id_e, company, name, job_title, last_update FROM area_ar.dim_employee;

-- DIM_LOCAL
INSERT INTO dim_local (id, city, state, country, last_update) SELECT id, city, state, country, last_update FROM area_ar.dim_local; 

-- DIM_PRODUCT
INSERT INTO dim_product (id, id_p, name, category_name, standard_cost, discontinued, last_update) 
				SELECT id, id_p, name, category_name, standard_cost, discontinued, last_update FROM  area_ar.dim_product;

-- DIM_SHIPPER
INSERT INTO dim_shipper (id, id_sh, name, last_update) SELECT id, id_sh, name, last_update FROM area_ar.dim_shipper;

-- DIM_SUPPLIER
INSERT INTO dim_supplier (id, id_su, company, last_update) SELECT id, id_su, company, now() FROM area_ar.dim_supplier;

-- DIM_TIME
INSERT INTO dim_time(id,date,day,month,year,week_day,week,work_day,holiday) SELECT id,date,day,month,year,week_day,week,work_day,holiday FROM area_ar.dim_time;

-- SALES_FACT
INSERT INTO sales_fact (id, order_id, quantity, total_price, discount, preparation_time, last_update, dim_product_id, dim_shipper_id, dim_supplier_id, dim_employee_id, 
			dim_customer_id, order_date, shipped_date, payment_date, customer_local)
						SELECT id, order_id, quantity, total_price, discount, preparation_time, last_update, dim_product_id, dim_shipper_id, dim_supplier_id, dim_employee_id, 
						dim_customer_id, order_date, shipped_date, payment_date, customer_local
							FROM area_ar.sales_fact;