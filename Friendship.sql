/*Crea una base de datos llamada "amigos" y luego importe friends.sql. Esto creará dos nuevas tablas: usuarios y amistades.
Usando el siguiente ERD como referencia, escribe una consulta SQL que devuelva una lista de usuarios junto con los nombres de sus amigos.*/
SELECT users.first_name as first_name, users.last_name as last_name, user2.first_name as friend_first_name, user2.last_name as friend_last_name
FROM users 
LEFT JOIN friendships ON users.id=friendships.user_id
LEFT JOIN users as user2 ON  user2.id=friendships.friend_id
WHERE user2.first_name IS NOT NULL;

/*Ejercicio Adicional
También escriba las consultas SQL necesarias para realizar las siguientes tareas:*/

/*1-Devuelva a todos los usuarios que son amigos de Kermit, asegúrese de que sus nombres se muestren en los resultados.*/
SELECT users.first_name as first_name, users.last_name as last_name, user2.first_name as friend_first_name, user2.last_name as friend_last_name
FROM users 
LEFT JOIN friendships ON users.id=friendships.user_id
LEFT JOIN users as user2 ON  user2.id=friendships.friend_id 
WHERE users.first_name = 'Kermit' OR user2.first_name = 'Kermit';

/*2-Devuelve el recuento de todas las amistades.*/
SELECT users.first_name as nombre, COUNT(*) AS amistades
FROM users 
LEFT JOIN friendships ON users.id=friendships.user_id
LEFT JOIN users as user2 ON  user2.id=friendships.friend_id 
WHERE user2.first_name IS NOT NULL
GROUP BY users.first_name;

/*3-Descubre quién tiene más amigos y devuelve el recuento de sus amigos.*/
SELECT users.first_name as tiene_mas_amigos, COUNT(*) AS amistades
FROM users 
LEFT JOIN friendships ON users.id=friendships.user_id
LEFT JOIN users as user2 ON  user2.id=friendships.friend_id 
WHERE user2.first_name IS NOT NULL
GROUP BY users.first_name
LIMIT 1;

/*4-Crea un nuevo usuario y hazlos amigos de Eli Byers, Kermit The Frog y Marky Mark.*/
INSERT INTO users (first_name, last_name, created_at) 
VALUES('Julio', 'Fuentes', Now());

INSERT INTO friendships (user_id, friend_id, created_at) 
VALUES(6,2 , Now());

INSERT INTO friendships (user_id, friend_id, created_at) 
VALUES(6,4 , Now());

INSERT INTO friendships (user_id, friend_id, created_at) 
VALUES(6,5 , Now());

/*5-Devuelve a los amigos de Eli en orden alfabético.*/
SELECT users.first_name as first_name, users.last_name as last_name, user2.first_name as friend_first_name, user2.last_name as friend_last_name
FROM users 
LEFT JOIN friendships ON users.id=friendships.user_id
LEFT JOIN users as user2 ON  user2.id=friendships.friend_id 
WHERE users.first_name = 'Eli'
ORDER BY friend_first_name;

/*6-Eliminar a Marky Mark de los amigos de Eli.*/
DELETE FROM friendships WHERE user_id=2 AND friend_id=5;

/*7-Devuelve todas las amistades, mostrando solo el nombre y apellido de ambos amigos*/
SELECT users.first_name as first_name, users.last_name as last_name, user2.first_name as friend_first_name, user2.last_name as friend_last_name
FROM users 
LEFT JOIN friendships ON users.id=friendships.user_id
LEFT JOIN users as user2 ON  user2.id=friendships.friend_id
WHERE user2.first_name IS NOT NULL; 