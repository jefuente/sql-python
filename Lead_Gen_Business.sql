/*Consultas*/
/*1. ¿Qué consulta ejecutaría para obtener los ingresos totales para marzo de 2012?*/
SELECT 
	MONTHNAME(charged_datetime) AS Mes, SUM(amount) AS Ingresos_totales
FROM
    billing 
WHERE
    charged_datetime BETWEEN '2012-03-01' AND '2012-03-31';
/*2. ¿Qué consulta ejecutaría para obtener los ingresos totales recaudados del cliente con una identificación de 2?*/
SELECT 
	client_id,SUM(amount) AS Ingresos_totales
FROM
    billing 
WHERE
    client_id=2;
/*3. ¿Qué consulta ejecutaría para obtener todos los sitios que posee client = 10?*/
SELECT 
     s.domain_name AS Sitio_web, c.client_id
FROM
    clients c
        JOIN
    sites s ON c.client_id = s.client_id
WHERE
    c.client_id=10
GROUP BY s.domain_name;

/*4. ¿Qué consulta ejecutaría para obtener el número total de sitios creados por mes por año para el cliente con una identificación de 1?
 ¿Qué pasa con el cliente = 20?*/
SELECT 
    c.client_id, COUNT(s.domain_name) AS Numero_de_websites, MONTHNAME(created_datetime)AS Mes_creado, YEAR(created_datetime) AS Año_creado
FROM
    clients c
        JOIN
    sites s ON c.client_id = s.client_id
WHERE
    c.client_id=1
GROUP BY YEAR(created_datetime), MONTH(created_datetime) 
ORDER BY c.client_id, created_datetime; 

SELECT 
    c.client_id, COUNT(s.domain_name) AS Numero_de_websites, MONTHNAME(created_datetime)AS Mes_creado, YEAR(created_datetime) AS Año_creado
FROM
    clients c
        JOIN
    sites s ON c.client_id = s.client_id
WHERE
    c.client_id=20
GROUP BY YEAR(created_datetime), MONTH(created_datetime) 
ORDER BY c.client_id, created_datetime; 

/*5. ¿Qué consulta ejecutaría para obtener el número total de clientes potenciales generados para cada uno de los sitios entre
 el 1 de enero de 2011 y el 15 de febrero de 2011?*/
SELECT 
    s.domain_name AS website, COUNT(leads_id) AS number_of_leads, DATE_FORMAT(registered_datetime, "%M %D, %Y") AS date_generated
FROM
    leads l
        JOIN
    sites s ON s.site_id = l.site_id
WHERE
    registered_datetime BETWEEN '2011-01-01' AND '2011-02-15'
GROUP BY s.domain_name
ORDER BY s.site_id;

/*6. ¿Qué consulta ejecutaría para obtener una lista de nombres de clientes y el número total de clientes potenciales que hemos generado
 para cada uno de nuestros clientes entre el 1 de enero de 2011 y el 31 de diciembre de 2011?*/
SELECT 
    CONCAT_WS(' ', c.first_name, c.last_name) AS client_name, COUNT(l.leads_id) AS number_of_leads
FROM
    clients c
        JOIN
    sites s ON c.client_id = s.client_id
        JOIN
    leads l ON s.site_id = l.site_id
WHERE
    l.registered_datetime BETWEEN '2011-01-01' AND '2011-12-31'
GROUP BY c.client_id;

/*7. ¿Qué consulta ejecutaría para obtener una lista de nombres de clientes y el número total de clientes potenciales que hemos generado
 para cada cliente cada mes entre los meses 1 y 6 del año 2011?*/
SELECT 
    CONCAT_WS(' ', c.first_name, c.last_name) AS client_name, COUNT(l.leads_id) AS number_of_leads, MONTHNAME(registered_datetime) AS month_generated
FROM
    clients c
        JOIN
    sites s ON c.client_id = s.client_id
        JOIN
    leads l ON s.site_id = l.site_id
WHERE
    l.registered_datetime BETWEEN '2011-01-01' AND '2011-06-31'
GROUP BY  YEAR(registered_datetime), MONTH(registered_datetime),c.client_id;

/*8. ¿Qué consulta ejecutaría para obtener una lista de nombres de clientes y el número total de clientes potenciales que hemos generado
 para cada uno de los sitios de nuestros clientes entre el 1 de enero de 2011 y el 31 de diciembre de 2011? Solicite esta consulta por 
 ID de cliente. Presente una segunda consulta que muestre todos los clientes, los nombres del sitio y el número total de clientes potenciales
 generados en cada sitio en todo momento.*/
SELECT 
    CONCAT_WS(' ', c.first_name, c.last_name) AS client_name, s.domain_name AS website, COUNT(l.leads_id) AS number_of_leads, DATE_FORMAT(registered_datetime, "%M %D, %Y") AS date_generated
FROM
    clients c
        JOIN
    sites s ON c.client_id = s.client_id
        JOIN
    leads l ON s.site_id = l.site_id
WHERE
    l.registered_datetime BETWEEN '2011-01-01' AND '2011-12-31'
GROUP BY c.client_id, s.domain_name;

SELECT 
    CONCAT_WS(' ', c.first_name, c.last_name) AS client_name, s.domain_name AS website , COUNT(l.leads_id) AS number_of_leads
FROM
    clients c
        JOIN
    sites s ON c.client_id = s.client_id
        JOIN
    leads l ON s.site_id = l.site_id
GROUP BY c.client_id, s.domain_name;
/*9. Escriba una sola consulta que recupere los ingresos totales recaudados de cada cliente para cada mes del año. 
Pídalo por ID de cliente.*/
SELECT 
    CONCAT_WS(' ', c.first_name, c.last_name) AS Nombre_cliente, SUM(b.amount) AS Total_ingresos, MONTHNAME(b.charged_datetime)AS Mes_recaudado, YEAR(b.charged_datetime) AS Año_recaudado
FROM
    clients c
        JOIN
	billing b ON c.client_id = b.client_id
GROUP BY c.client_id, YEAR(b.charged_datetime),MONTH(b.charged_datetime);

/*10. Escriba una sola consulta que recupere todos los sitios que posee cada cliente.
 Agrupe los resultados para que cada fila muestre un nuevo cliente. Se volverá más claro cuando agregue un nuevo campo llamado 'sitios'
 que tiene todos los sitios que posee el cliente. (SUGERENCIA: use GROUP_CONCAT)*/
 SELECT 
    CONCAT_WS(' ', c.first_name, c.last_name) AS Nombre_cliente, GROUP_CONCAT(domain_name) AS Sitios
FROM
    clients c
        JOIN
    sites s ON c.client_id = s.client_id
GROUP BY c.client_id;
 
 
 