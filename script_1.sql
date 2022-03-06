-- -----------------------------------------------------
-- Schema beer_store
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS beer_store DEFAULT CHARACTER SET utf8 ;
USE beer_store ;

-- -----------------------------------------------------
-- Table type_document
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS type_document (
  type_doc_id INT NOT NULL,
  type_doc_name VARCHAR(4) NOT NULL,
  PRIMARY KEY (type_doc_id))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table supplier
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS supplier (
  sup_id INT NOT NULL AUTO_INCREMENT,
  type_document_type_doc_id INT NOT NULL,
  sup_number_document VARCHAR(15) NOT NULL,
  sup_name VARCHAR(45) NOT NULL,
  sup_created_at DATETIME NOT NULL,
  sup_updated_at DATETIME NULL,
  sup_deleted_at DATETIME NULL,
  PRIMARY KEY (sup_id),
  UNIQUE INDEX prov_id_UNIQUE (sup_id ASC) VISIBLE,
  UNIQUE INDEX pro_documento_UNIQUE (sup_number_document ASC, type_document_type_doc_id ASC) VISIBLE,
  INDEX fk_supplier_type_document1_idx (type_document_type_doc_id ASC) VISIBLE,
  CONSTRAINT fk_supplier_type_document1
    FOREIGN KEY (type_document_type_doc_id)
    REFERENCES type_document (type_doc_id)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table product
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS product (
  prod_id INT NOT NULL AUTO_INCREMENT,
  supplier_sup_id INT NOT NULL,
  prod_name VARCHAR(45) NOT NULL,
  prod_price INT NOT NULL,
  prod_created_at DATETIME NOT NULL,
  prod_updated_at DATETIME NULL,
  prod_deleted_at DATETIME NULL,
  PRIMARY KEY (prod_id),
  INDEX fk_product_supplier1_idx (supplier_sup_id ASC) VISIBLE,
  CONSTRAINT fk_product_supplier1
    FOREIGN KEY (supplier_sup_id)
    REFERENCES supplier (sup_id)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table customer
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS customer (
  cust_id INT NOT NULL AUTO_INCREMENT,
  type_document_type_doc_id INT NOT NULL,
  cust_number_document VARCHAR(15) NOT NULL,
  cust_created_at DATETIME NOT NULL,
  cust_updated_at DATETIME NULL,
  cust_deleted_at DATETIME NULL,
  PRIMARY KEY (cust_id),
  UNIQUE INDEX cust_number_documento_UNIQUE (type_document_type_doc_id ASC, cust_number_document ASC) VISIBLE,
  INDEX fk_customer_type_document1_idx (type_document_type_doc_id ASC) VISIBLE,
  CONSTRAINT fk_customer_type_document1
    FOREIGN KEY (type_document_type_doc_id)
    REFERENCES type_document (type_doc_id)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table invoice
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS invoice (
  inv_id INT NOT NULL AUTO_INCREMENT,
  customer_cust_id INT NOT NULL,
  inv_price VARCHAR(45) NOT NULL,
  inv_created_at DATETIME NOT NULL,
  inv_updated_at DATETIME NULL,
  inv_deleted_at DATETIME NULL,
  PRIMARY KEY (inv_id),
  INDEX fk_invoice_customer1_idx (customer_cust_id ASC) VISIBLE,
  CONSTRAINT fk_invoice_customer1
    FOREIGN KEY (customer_cust_id)
    REFERENCES customer (cust_id)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table product_has_invoice
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS product_has_invoice (
  product_has_invoice_id INT NOT NULL AUTO_INCREMENT,
  product_prod_id INT NOT NULL,
  invoice_inv_id INT NOT NULL,
  product_has_invoice_quantity INT NOT NULL,
  INDEX fk_product_has_invoice_invoice1_idx (invoice_inv_id ASC) VISIBLE,
  INDEX fk_product_has_invoice_product1_idx (product_prod_id ASC) VISIBLE,
  PRIMARY KEY (product_has_invoice_id),
  CONSTRAINT fk_product_has_invoice_product1
    FOREIGN KEY (product_prod_id)
    REFERENCES product (prod_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_product_has_invoice_invoice1
    FOREIGN KEY (invoice_inv_id)
    REFERENCES invoice (inv_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Insert data into table type_document
-- -----------------------------------------------------
INSERT INTO type_document(type_doc_id, type_doc_name) 
VALUES (1,'CC'),
(2,'CE'),
(3,'TI'),
(4,'PP'),
(5, 'NIT');

-- -----------------------------------------------------
-- Insert data into table customer
-- -----------------------------------------------------
INSERT INTO customer(type_document_type_doc_id, cust_number_document, cust_created_at)
VALUES (1, '1090486380', NOW()),
(3, '95022814563', NOW()),
(4, '84560002455', NOW()),
(1, '5478526', NOW()),
(1, '278549630', NOW()),
(2, '78951125', NOW()),
(3, '9948532245', NOW()),
(5, '1145200154', NOW()),
(4, '456328521', NOW()),
(2, '8545300145', NOW());

-- -----------------------------------------------------
-- Insert data into table supplier
-- -----------------------------------------------------
INSERT INTO supplier (type_document_type_doc_id, sup_number_document, sup_name, sup_created_at)
VALUES (5, '554122536-4', 'Cerveceria del Valle S.A.', NOW()),
(5, '78542236-7', 'Cerveceria Union S.A.', NOW()),
(5, '21002453-9', 'Malteria Tropical S.A.', NOW()),
(5, '853185628-8', 'Sociedad Portuaria Bavaria', NOW()),
(5, '00421896-5', 'Kopps Commercial S.A.S', NOW());

-- -----------------------------------------------------
-- Insert data into table invoice
-- -----------------------------------------------------
INSERT INTO invoice (customer_cust_id, inv_price, inv_created_at)
VALUES (1, '485000', NOW()),
(2, '1254000', NOW()),
(3, '75920', NOW()),
(4, '6532992', NOW()),
(5, '1245854', NOW()),
(6, '638745', NOW()),
(7, '895402', NOW()),
(8, '2745930', NOW()),
(9, '4782012', NOW()),
(10, '1247962', NOW());

-- -----------------------------------------------------
-- Insert data into product
-- -----------------------------------------------------
INSERT INTO product (supplier_sup_id, prod_name, prod_price, prod_created_at)
VALUES (1, 'Aguila Lata 330ml', '2400', NOW()),
(3, 'Club Colombia Negra Lata 330ml', '2600', NOW()),
(5, 'Corona Botella 355ml', '4000', NOW()),
(1, 'Bekcs Botella 275ml', '2100', NOW()),
(3, 'Budweiser Botella 275ml', '2200', NOW()),
(2, 'La Cotidiana Lata 269ml', '2500', NOW()),
(2, 'Stella Artois Lata 269ml', '3100', NOW()),
(5, 'Michelob Ultra Botella 365ml', '3500', NOW()),
(4, 'Club Colombia Roja Lata 330ml', '2500', NOW()),
(4, 'Coronita Botella 210ml', '2400', NOW());
-- -----------------------------------------------------
-- Insert data into table product_has_invoice
-- -----------------------------------------------------
INSERT INTO product_has_invoice (product_prod_id, invoice_inv_id, product_has_invoice_quantity)
VALUES (1,1,2),
(5,2,1),
(3,3,3),
(8,4,1),
(2,2,4),
(4,5,2),
(9,1,3),
(1,2,1),
(10,2,2),
(5,3,5);

-- -----------------------------------------------------
-- Two logical deletions of sales made.
-- -----------------------------------------------------
UPDATE invoice
SET inv_deleted_at = NOW()
WHERE inv_id = 1;

UPDATE invoice
SET inv_deleted_at = NOW()
WHERE inv_id = 2;

-- -----------------------------------------------------
-- Two physical deletions of sales made.
-- -----------------------------------------------------
DELETE 
FROM invoice
WHERE inv_id = 3;

DELETE 
FROM invoice
WHERE inv_id = 4;

-- -----------------------------------------------------
-- Modify three products in your name and the supplier providing them
-- -----------------------------------------------------
UPDATE product
SET prod_name = 'Costeña Lata 350ml', supplier_sup_id = 4, prod_updated_at = NOW()
WHERE prod_id = 1;

UPDATE product
SET prod_name = 'Poker Lata 350ml', supplier_sup_id = 2, prod_updated_at = NOW()
WHERE prod_id = 2;

UPDATE product
SET prod_name = 'Pilsen Botella 350ml', supplier_sup_id = 1, prod_updated_at = NOW()
WHERE prod_id = 3;

