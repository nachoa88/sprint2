-- Llista quants productes de tipus “Begudes” s'han venut en una determinada localitat.
SELECT COUNT(*) as 'quantity', c.locality FROM product p INNER JOIN `order` o ON p.order_id = o.id INNER JOIN `client` c ON o.client_id = c.id WHERE p.product_type = 'begudes' AND c.locality = 'Barcelona' GROUP BY c.locality;

-- Llista quantes comandes ha efectuat un determinat empleat/da.
SELECT COUNT(*) as 'quantity', w.id FROM worker w INNER JOIN delivery_order d ON w.id = d.worker_id INNER JOIN `order` o ON d.order_id = o.id WHERE w.id = 2 ORDER BY w.id;