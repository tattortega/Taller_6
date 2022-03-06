-- ------------------------------------------------------------------
-- Query of products sold by type of document and document number.
-- ------------------------------------------------------------------
SELECT type_document.type_doc_name as 'Tipo de documento', 
customer.cust_number_document as 'Número de Documento', product.prod_name as 'Producto' 
FROM product 
JOIN product_has_invoice ON product_has_invoice.product_has_invoice_id = product.prod_id 
JOIN invoice ON invoice.inv_id = product_has_invoice.invoice_inv_id
JOIN customer ON customer.cust_id = invoice.customer_cust_id
JOIN type_document ON type_document.type_doc_id = customer.type_document_type_doc_id
WHERE type_document_type_doc_id = 1
AND cust_number_document = '1090486380';


-- ------------------------------------------------------------------------------
-- Query products by name, which should show who or who have been their suppliers.
-- ------------------------------------------------------------------------------
SELECT prod_name as 'Producto', sup_name as 'Proveedor' 
FROM supplier 
JOIN product ON product.supplier_sup_id = supplier.sup_id
WHERE prod_name = 'Club Colombia Roja Lata 330ml';


-- -----------------------------------------------------------------------------------------------
-- Query to see which product has been the most sold and in what quantities from highest to lowest.
-- -----------------------------------------------------------------------------------------------
SELECT product.prod_name as 'Producto', SUM(product_has_invoice.product_has_invoice_quantity) as 'Mayor Venta' 
FROM product_has_invoice
JOIN product ON product.prod_id = product_has_invoice.product_prod_id
GROUP BY product_has_invoice.product_prod_id
ORDER BY SUM(product_has_invoice.product_has_invoice_quantity) DESC;
