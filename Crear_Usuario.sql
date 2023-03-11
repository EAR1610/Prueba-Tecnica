--Modificar la session actual para crear nuevos usuarios
alter session set "_ORACLE_SCRIPT"= true;
--Creamos el usuario edixonPT y establecemos su contraseña
create user edixonPT identified by "root";
--OTormgamos permisos para conectarse a Oracle
grant "CONNECT" To edixonPT