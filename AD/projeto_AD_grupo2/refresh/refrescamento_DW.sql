use datawarehouse;

SET SQL_SAFE_UPDATES = 0;


-- Só é inserido se o registo é novo ou se foi modificado

-- DIM_CUSTOMER -- select * from datawarehouse.dim_customer

INSERT INTO datawarehouse.dim_customer (id_c, company, name, job_title, last_update) 
	SELECT area_ar.dim_customer.id_c, area_ar.dim_customer.company, area_ar.dim_customer.name, area_ar.dim_customer.job_title, now()
    FROM area_ar.dim_customer 
		LEFT JOIN datawarehouse.dim_customer ON area_ar.dim_customer.id_c = datawarehouse.dim_customer.id_c and area_ar.dim_customer.company = datawarehouse.dim_customer.company 
											and area_ar.dim_customer.name = datawarehouse.dim_customer.name and area_ar.dim_customer.job_title = datawarehouse.dim_customer.job_title 
						WHERE datawarehouse.dim_customer.id_c IS NULL;


-- DIM_EMPLOYEE

INSERT INTO datawarehouse.dim_employee (id_e, name, company, job_title, last_update) 
	SELECT area_ar.dim_employee.id, area_ar.dim_employee.name, area_ar.dim_employee.company, area_ar.dim_employee.job_title, now()
    FROM area_ar.dim_employee 
		LEFT JOIN datawarehouse.dim_employee ON area_ar.dim_employee.id_e = datawarehouse.dim_employee.id_e and area_ar.dim_employee.company = datawarehouse.dim_employee.company 
											and area_ar.dim_employee.name = datawarehouse.dim_employee.name and area_ar.dim_employee.job_title = datawarehouse.dim_employee.job_title 
						WHERE datawarehouse.dim_employee.id_e IS NULL ;

-- DIM_LOCAL -- select * from datawarehouse.dim_local

INSERT INTO datawarehouse.dim_local (city, state, country, last_update) 
	SELECT area_ar.dim_local.city, area_ar.dim_local.state, area_ar.dim_local.country, now()
    FROM area_ar.dim_local 
		LEFT JOIN datawarehouse.dim_local ON area_ar.dim_local.city = datawarehouse.dim_local.city and area_ar.dim_local.state = datawarehouse.dim_local.state
										 and area_ar.dim_local.country = datawarehouse.dim_local.country
						WHERE datawarehouse.dim_local.id IS NULL ;

-- DIM_PRODUCT -- select * from datawarehouse.dim_product

INSERT INTO datawarehouse.dim_product (id_p, name, category_name, standard_cost, discontinued, last_update) 
	SELECT area_ar.dim_product.id_p, area_ar.dim_product.name, area_ar.dim_product.category_name, area_ar.dim_product.standard_cost, area_ar.dim_product.discontinued, now()
    FROM area_ar.dim_product 
		LEFT JOIN datawarehouse.dim_product ON area_ar.dim_product.id_p = datawarehouse.dim_product.id_p and area_ar.dim_product.name = datawarehouse.dim_product.name
										   and area_ar.dim_product.category_name = datawarehouse.dim_product.category_name and area_ar.dim_product.standard_cost = datawarehouse.dim_product.standard_cost
                                           and area_ar.dim_product.discontinued = datawarehouse.dim_product.discontinued
						WHERE datawarehouse.dim_product.id IS NULL ;

-- DIM_SHIPPER -- select * from datawarehouse.dim_shipper

INSERT INTO datawarehouse.dim_shipper (id_sh, name, last_update) 
	SELECT area_ar.dim_shipper.id_sh, area_ar.dim_shipper.name, now()
    FROM area_ar.dim_shipper
		LEFT JOIN datawarehouse.dim_shipper ON area_ar.dim_shipper.id_sh = datawarehouse.dim_shipper.id_sh and area_ar.dim_shipper.name = datawarehouse.dim_shipper.name
						WHERE datawarehouse.dim_shipper.id IS NULL ;

-- DIM_SUPPLIER -- select * from datawarehouse.dim_supplier

INSERT INTO datawarehouse.dim_supplier (id_su, company, last_update) 
	SELECT area_ar.dim_supplier.id_su, area_ar.dim_supplier.company, now()
    FROM area_ar.dim_supplier
		LEFT JOIN datawarehouse.dim_supplier ON area_ar.dim_supplier.id_su = datawarehouse.dim_supplier.id_su and area_ar.dim_supplier.company = datawarehouse.dim_supplier.company
						WHERE datawarehouse.dim_supplier.id IS NULL ;

-- SALES_FACT -- select * from datawarehouse.sales_fact

INSERT INTO datawarehouse.sales_fact (order_id, quantity, total_price, discount, preparation_time, last_update, dim_product_id, dim_shipper_id,
									  dim_supplier_id, dim_employee_id, dim_customer_id, order_date, shipped_date, payment_date, customer_local) 
    SELECT area_ar.sales_fact.order_id, area_ar.sales_fact.quantity, area_ar.sales_fact.total_price, area_ar.sales_fact.discount, area_ar.sales_fact.preparation_time,
		   now(), area_ar.sales_fact.dim_product_id, area_ar.sales_fact.dim_shipper_id, area_ar.sales_fact.dim_supplier_id, area_ar.sales_fact.dim_employee_id,
           area_ar.sales_fact.dim_customer_id, area_ar.sales_fact.order_date, area_ar.sales_fact.shipped_date, area_ar.sales_fact.payment_date, area_ar.sales_fact.customer_local
    FROM area_ar.sales_fact    
		LEFT JOIN datawarehouse.sales_fact ON area_ar.sales_fact.order_id = datawarehouse.sales_fact.order_id and area_ar.sales_fact.quantity = datawarehouse.sales_fact.quantity and
												  area_ar.sales_fact.total_price = datawarehouse.sales_fact.total_price and area_ar.sales_fact.discount = datawarehouse.sales_fact.discount and
												  area_ar.sales_fact.preparation_time = datawarehouse.sales_fact.preparation_time
							WHERE datawarehouse.sales_fact.order_id IS NULL ;

-- ####################################################################################################################################################################################

-- TRIGGER CUSTOMER
-- drop trigger datawarehouse.customers_after_insert;


DELIMITER //

CREATE TRIGGER customers_after_insert
AFTER INSERT
   ON datawarehouse.dim_customer FOR EACH ROW

BEGIN

   UPDATE datawarehouse.sales_fact
	INNER JOIN datawarehouse.dim_customer ON datawarehouse.sales_fact.dim_customer_id = datawarehouse.dim_customer.id and 
											 datawarehouse.dim_customer.id_c = new.id_c		
        SET datawarehouse.sales_fact.dim_customer_id = new.id;
        
END; //

DELIMITER ;						

-- TRIGGER EMPLOYEE -- select * from datawarehouse.sales_fact

-- drop trigger datawarehouse.employee_after_insert;

DELIMITER //

CREATE TRIGGER employee_after_insert
AFTER INSERT
   ON datawarehouse.dim_employee FOR EACH ROW

BEGIN

   UPDATE datawarehouse.sales_fact
	INNER JOIN datawarehouse.dim_employee ON 
    datawarehouse.sales_fact.dim_employee_id = datawarehouse.dim_employee.id and 
    datawarehouse.dim_employee.id_e = new.id_e and datawarehouse.dim_employee.id_e = new.id_e
		
        SET datawarehouse.sales_fact.dim_employee_id = new.id;
        

END; //

DELIMITER ;		

-- TRIGGER PRODUCT
-- drop trigger product_after_insert;

DELIMITER //

CREATE TRIGGER product_after_insert
AFTER INSERT
   ON datawarehouse.dim_product FOR EACH ROW

BEGIN

   UPDATE datawarehouse.sales_fact
	INNER JOIN datawarehouse.dim_product ON 
    datawarehouse.sales_fact.dim_product_id = datawarehouse.dim_product.id and 
    datawarehouse.dim_product.id_p = new.id_p and datawarehouse.dim_product.id_p = new.id_p
		
        SET datawarehouse.sales_fact.dim_product_id = new.id;
        
END; //

DELIMITER ;		

-- TRIGGER SHIPPER
-- drop trigger shipper_after_insert;

DELIMITER //

CREATE TRIGGER shipper_after_insert
AFTER INSERT
   ON datawarehouse.dim_shipper FOR EACH ROW

BEGIN

   UPDATE datawarehouse.sales_fact
	INNER JOIN datawarehouse.dim_shipper ON 
    datawarehouse.sales_fact.dim_shipper_id = datawarehouse.dim_shipper.id and 
    datawarehouse.dim_shipper.id_sh = new.id_sh and datawarehouse.dim_shipper.id_sh = new.id_sh
		
        SET datawarehouse.sales_fact.dim_shipper_id = new.id;

END; //

DELIMITER ;	

-- TRIGGER SUPPLIER
-- drop trigger supplier_after_insert;

DELIMITER //

CREATE TRIGGER supplier_after_insert
AFTER INSERT
   ON datawarehouse.dim_supplier FOR EACH ROW

BEGIN

   UPDATE datawarehouse.sales_fact
	INNER JOIN datawarehouse.dim_supplier ON 
    datawarehouse.sales_fact.dim_supplier_id = datawarehouse.dim_supplier.id and 
    datawarehouse.dim_supplier.id_su = new.id_su and datawarehouse.dim_supplier.id_su = new.id_su
		
        SET datawarehouse.sales_fact.dim_supplier_id = new.id;

END; //

DELIMITER ;	

-- TRIGGER SALES_FACT

-- drop trigger sales_before_insert;

DELIMITER //

CREATE TRIGGER sales_before_insert
BEFORE INSERT
   ON datawarehouse.sales_fact FOR EACH ROW

BEGIN

    SET new.dim_customer_id = (select datawarehouse.dim_customer.id from datawarehouse.dim_customer inner join area_ar.dim_customer on datawarehouse.dim_customer.id_c = area_ar.dim_customer.id_c and area_ar.dim_customer.id = new.dim_customer_id ORDER BY id DESC LIMIT 1);

 	SET new.dim_product_id = (select datawarehouse.dim_product.id from datawarehouse.dim_product inner join area_ar.dim_product on datawarehouse.dim_product.id_p = area_ar.dim_product.id_p and area_ar.dim_product.id = new.dim_product_id ORDER BY id DESC LIMIT 1);

	SET new.dim_shipper_id = (select datawarehouse.dim_shipper.id from datawarehouse.dim_shipper inner join area_ar.dim_shipper on datawarehouse.dim_shipper.id_sh = area_ar.dim_shipper.id_sh and area_ar.dim_shipper.id = new.dim_shipper_id ORDER BY id DESC LIMIT 1);

	SET new.dim_supplier_id = (select datawarehouse.dim_supplier.id from datawarehouse.dim_supplier inner join area_ar.dim_supplier on datawarehouse.dim_supplier.id_su = area_ar.dim_supplier.id_su and area_ar.dim_supplier.id = new.dim_supplier_id ORDER BY id DESC LIMIT 1);

	SET new.dim_employee_id = (select datawarehouse.dim_employee.id from datawarehouse.dim_employee inner join area_ar.dim_employee on datawarehouse.dim_employee.id_e = area_ar.dim_employee.id_e and area_ar.dim_employee.id = new.dim_employee_id ORDER BY id DESC LIMIT 1);
    
END; //

DELIMITER ;	

-- ####################################################################################################################################################################################
-- Inserts novos na base de dados

-- Teste sales_fact

update northwind.order_details set quantity = 6666 where order_id = 31;

-- Teste customer
INSERT INTO northwind.customers (`id`, `company`, `last_name`, `first_name`, `email_address`, `job_title`, `business_phone`, `home_phone`, `mobile_phone`, `fax_number`, `address`, `city`, `state_province`, `zip_postal_code`, `country_region`, `web_page`, `notes`, `attachments`) 
VALUES (600, 'Company D', 'Costa', 'Luis', NULL, 'Owner', '(123)554-0100', NULL, NULL, '(123)555-0101', '123 1st Street', 'Seattle', 'WA', '99999', 'USA', NULL, NULL, '');

update northwind.customers set company = "Nova Empresa" where id =6;

-- Teste employee
INSERT INTO northwind.employees (`id`, `company`, `last_name`, `first_name`, `email_address`, `job_title`, `business_phone`, `home_phone`, `mobile_phone`, `fax_number`, `address`, `city`, `state_province`, `zip_postal_code`, `country_region`, `web_page`, `notes`, `attachments`) 
VALUES (591, 'Northwind Traders', 'Cunha', 'Gil', 'nancy@northwindtraders.com', 'Sales Representative', '(123)555-0100', '(123)555-0102', NULL, '(123)555-0103', '123 1st Avenue', 'Seattle', 'WA', '99999', 'USA', '#http://northwindtraders.com#', NULL, '');

update northwind.employees set company = "Mais uma empresa" where id =3;

-- Teste product
INSERT INTO northwind.products (`supplier_ids`, `id`, `product_code`, `product_name`, `description`, `standard_cost`, `list_price`, `reorder_level`, `target_level`, `quantity_per_unit`, `discontinued`, `minimum_reorder_quantity`, `category`, `attachments`) 
VALUES ('4', 600, 'CHA-1', 'Cha de Camomila', NULL, 13.5, 18, 10, 40, '10 boxes x 20 bags', 0, 10, 'Beverages', '');

update northwind.products set product_name = "Agua das Pedras" where id =1;

-- Teste supplier
INSERT INTO northwind.suppliers (`id`, `company`, `last_name`, `first_name`, `email_address`, `job_title`, `business_phone`, `home_phone`, `mobile_phone`, `fax_number`, `address`, `city`, `state_province`, `zip_postal_code`, `country_region`, `web_page`, `notes`, `attachments`) 
VALUES (600, 'Supplier A', 'UltimoNome', 'Marisa', NULL, 'Sales Manager', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '');

update northwind.suppliers set company = "Engenheiros do Conhecimento e Associados" where id =2;

-- Teste shipper
INSERT INTO northwind.shippers (`id`, `company`, `last_name`, `first_name`, `email_address`, `job_title`, `business_phone`, `home_phone`, `mobile_phone`, `fax_number`, `address`, `city`, `state_province`, `zip_postal_code`, `country_region`, `web_page`, `notes`, `attachments`) 
VALUES (600, 'Shipping Company A', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '123 Any Street', 'Memphis', 'TN', '99999', 'USA', NULL, NULL, '');

update northwind.shippers set company = "Empresa teste" where id =1;