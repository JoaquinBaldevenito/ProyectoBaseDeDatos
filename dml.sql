-- Inserciones en la tabla pelicula
INSERT INTO pelicula (titulo_distribucion, titulo_espa, fecha_estreno_arg, genero, idioma_original, calificacion, titulo_original, duracion, anio_produccion, url_web, resumen)
VALUES
('Inception', 'El origen', '2010-07-22', 'Ciencia ficción', 'Inglés', '+13años', 'Inception', '02:28:00', 2010, 'https://inceptionmovie.warnerbros.com/', 'Una película sobre sueños dentro de sueños.'),
('Titanic', 'Titanic', '1998-01-16', 'Drama', 'Inglés', '+15años', 'Titanic', '03:14:00', 1997, 'https://www.titanicmovie.com/', 'Un trágico romance en el Titanic.');


-- Inserciones en la tabla pais_peli
INSERT INTO pais_peli (id_peli, pais_origen)
VALUES
(1, 'USA'),
(1, 'UK'),
(2, 'USA');


-- Inserciones en la tabla cine
INSERT INTO cine (nombre_cine, direccion, telefono)
VALUES
('Cineplex', 'Avenida Siempre Viva 742', 123456789),
('Cinema City', 'Calle Falsa 123', 987654321);


-- Inserciones en la tabla sala
INSERT INTO sala (numero_sala, cant_butacas, nombre_cine)
VALUES
(1, 200, 'Cineplex'),
(2, 150, 'Cineplex'),
(3, 180, 'Cinema City');


-- Inserciones en la tabla funcion
INSERT INTO funcion (codigo, h_inicio, fecha, id_peli, numero_sala)
VALUES
(1, '18:00:00', '2024-05-20', 1, 1),
(2, '21:00:00', '2024-05-20', 2, 2),
(3, '15:00:00', '2024-05-21', 1, 1);


-- Inserciones en la tabla persona
INSERT INTO persona (nombre, nacionalidad)
VALUES
('Christopher Nolan', 'UK'),
('Leonardo DiCaprio', 'USA'),
('Kate Winslet', 'UK'),
('James Cameron', 'Canada');


-- Inserciones en la tabla director
INSERT INTO director (nombre_persona_dir, cant_dir)
VALUES
('Christopher Nolan', 10),
('James Cameron', 8);


-- Inserciones en la tabla actor
INSERT INTO actor (nombre_persona_act, cant_act)
VALUES
('Leonardo DiCaprio', 30),
('Kate Winslet', 25);


-- Inserciones en la tabla dirigio
INSERT INTO dirigio (nombre_persona_dir, id_peli)
VALUES
('Christopher Nolan', 1),
('James Cameron', 2);


-- Inserciones en la tabla protagonizo
INSERT INTO protagonizo (nombre_persona_act, id_peli)
VALUES
('Leonardo DiCaprio', 1),
('Kate Winslet', 2);


-- Inserciones en la tabla actor_reparto
INSERT INTO actor_reparto (nombre_persona_act, id_peli)
VALUES
('Kate Winslet', 1),
('Leonardo DiCaprio', 2);
