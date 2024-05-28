-- drop database proyecto;
create database if not exists proyecto;
use proyecto;


drop table if exists pelicula cascade;
create table pelicula 
(
  id_peli integer auto_increment not null primary key,
  titulo_distribucion varchar(50),
  titulo_espa varchar(50),
  fecha_estreno_arg date,
  genero varchar(50),
  idioma_original varchar(50),
  calificacion enum('todo_publico','+13años','+15años','+18años'),
  titulo_original varchar(50),
  duracion time,
  anio_produccion integer,
  url_web varchar(50),
  resumen varchar(100)
);


drop table if exists pais_peli cascade;
create table pais_peli
(
  id_peli integer not null,
  pais_origen varchar(50) not null,
  constraint fkpais_peli foreign key(id_peli) references pelicula(id_peli) ON DELETE CASCADE,
  constraint pkpais_peli primary key (id_peli,pais_origen)
);


drop table if exists cine cascade;
create table cine
(
	nombre_cine varchar(50) not null primary key,
  direccion varchar(50),
  telefono integer,
  check(telefono > 0)
);


drop table if exists sala cascade;
create table sala 
(
  numero_sala integer auto_increment not null primary key,
  cant_butacas integer,
  nombre_cine varchar(50),
  constraint fksala foreign key (nombre_cine) references cine (nombre_cine) ON DELETE CASCADE,
  check (cant_butacas > 0)
);


drop table if exists funcion cascade;
create table funcion 
(
  codigo integer not null primary key,
  h_inicio time,
  fecha date,
  id_peli integer,
  numero_sala integer,
  constraint fk_funcion1 foreign key (id_peli) references pelicula (id_peli)ON DELETE CASCADE,
  constraint fk_funcion2 foreign key (numero_sala) references sala (numero_sala)ON DELETE CASCADE,
  check (codigo > 0)
);



drop table if exists persona cascade;
create table persona
(
	nombre varchar(50) not null primary key,
  nacionalidad varchar(50)
);


drop table if exists director cascade;
create table director
(
	nombre_persona_dir varchar(50) not null primary key,
  cant_dir integer,
  constraint fknombre_persona_dir foreign key(nombre_persona_dir) references persona(nombre)ON DELETE CASCADE,
  check (cant_dir > 0)
  
);


drop table if exists actor cascade;
create table actor
(
	nombre_persona_act varchar(50) not null primary key,
  cant_act integer,
  constraint fknombre_persona_act foreign key(nombre_persona_act) references persona(nombre)ON DELETE CASCADE,
  check (cant_act > 0)
);



drop table if exists dirigio cascade;
create table dirigio
(
	nombre_persona_dir varchar(50) not null,
  id_peli integer not null,
  constraint fkid_dir foreign key (id_peli) references pelicula (id_peli)ON DELETE CASCADE,
  constraint fkdirigio foreign key (nombre_persona_dir) references director (nombre_persona_dir)ON DELETE CASCADE,
  constraint pkdirigio primary key (nombre_persona_dir,id_peli)
);



drop table if exists protagonizo cascade;
create table protagonizo
(
	nombre_persona_act varchar(50) not null,
  id_peli integer not null,
  constraint fkid_prota foreign key (id_peli) references pelicula (id_peli)ON DELETE CASCADE,
  constraint fkprotagonizo foreign key (nombre_persona_act) references actor (nombre_persona_act)ON DELETE CASCADE,
  constraint pkprotagonizo primary key (nombre_persona_act,id_peli)
);


drop table if exists actor_reparto cascade;
create table actor_reparto
(
	nombre_persona_act varchar(50) not null,
  id_peli integer not null,
  constraint fkid_act_rep foreign key (id_peli) references pelicula (id_peli)ON DELETE CASCADE,
  constraint fkactor_reparto foreign key (nombre_persona_act) references actor (nombre_persona_act)ON DELETE CASCADE,
  constraint pkactor_reparto primary key (nombre_persona_act,id_peli)
);

drop table if exists auditoria;
create table auditoria (
	id_peli	integer,
  fecha_realizacion date,
	hora_realizacion time,
	f_estreno	date,
	usuario text,

	constraint pkauditoria primary key (id_peli, fecha_realizacion, hora_realizacion),
	constraint fkauditoria_pelicula foreign key (id_peli) references pelicula (id_peli) on delete cascade on update cascade
);

Delimiter $$
create trigger triggerMayuscula
before insert on pelicula for each row
    Begin 
        set new.titulo_original = UPPER(new.titulo_original);
    end $$


Delimiter $$
create trigger infoauditoria
after update on pelicula
for each row
begin
    if new.fecha_estreno_arg <> old.fecha_estreno_arg then
        insert into auditoria (id_peli, fecha_realizacion, hora_realizacion, f_estreno, usuario)
        values (old.id_peli, now(), now(), new.fecha_estreno_arg, user());
    end if;
end $$



