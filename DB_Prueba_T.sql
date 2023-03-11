
---***** PRIMERA PARTE DE LA PRUEBA TÉCNICA*****
--CREMOS LA TABLA CUENTA
CREATE TABLE Cuenta (
  Codigo_Cuenta NUMBER(10) PRIMARY KEY,
  nombre VARCHAR2(50) NOT NULL
);

--INSERTAMOS VALORES EN LA TABLA CUENTA
INSERT INTO Cuenta(Codigo_Cuenta, nombre)
VALUES(1, '4300000013');

--CREAMOS LA TABLA TIPOMOVIMIENTO
CREATE TABLE TipoMovimiento (
  Codigo_Tipo_Movimiento NUMBER(10) PRIMARY KEY,
  nombre VARCHAR2(50) NOT NULL,
  tipo VARCHAR2(50) NOT NULL
);

--INSERTMAOS VALORES EN LA TABLA TIPOMOVIMIENTO
INSERT INTO TipoMovimiento (Codigo_Tipo_Movimiento, nombre, tipo)
VALUES(2, 'Haber', 'Ingreso');

--CREAMOS LA TABLA RELACION
CREATE TABLE Relacion (
  Codigo_Cuenta NUMBER(10) NOT NULL,
  Codigo_Tipo_Movimiento NUMBER(10) NOT NULL,
  CONSTRAINT pk_relacion PRIMARY KEY (Codigo_Cuenta, Codigo_Tipo_Movimiento),
  CONSTRAINT fk_cuenta FOREIGN KEY (Codigo_Cuenta) REFERENCES Cuenta(Codigo_Cuenta),
  CONSTRAINT fk_tipo_movimiento FOREIGN KEY (Codigo_Tipo_Movimiento) REFERENCES TipoMovimiento(Codigo_Tipo_Movimiento)
);
--INSERTAMOS VALORES EN LA TABLA RELACION
INSERT INTO Relacion (Codigo_Cuenta, Codigo_Tipo_Movimiento)
VALUES(1, 2);

--CREAMOS LA TABLA MOVIMIENTO
CREATE TABLE Movimiento (
  Codigo_Movimiento NUMBER(10) PRIMARY KEY,
  fecha DATE NOT NULL,
  factura VARCHAR2(50) NOT NULL,
  descripcion VARCHAR2(100),
  comentario VARCHAR2(255),
  subtotal NUMBER(10,2) NOT NULL,
  total NUMBER(10,2) NOT NULL,
  Codigo_Cuenta NUMBER(10) NOT NULL,
  Codigo_Tipo_Movimiento NUMBER(10) NOT NULL,
  CONSTRAINT fk_cuenta_movimiento FOREIGN KEY (Codigo_Cuenta, Codigo_Tipo_Movimiento) REFERENCES Relacion(Codigo_Cuenta, Codigo_Tipo_Movimiento)
);

--INSERTAMOS VALORES EN LA TABLA MOVIMIENTO
INSERT INTO Movimiento(Codigo_Movimiento, fecha, factura, descripcion, comentario, subtotal, total, Codigo_Cuenta, Codigo_Tipo_Movimiento)
VALUES(1, '17/04/2020', 'A-7289', 'ANA TRUJILLO', 'Cobro de ANA TRUJILLO', 605.00, 605.00, 1, 2);

--CREAMOS LA TABLA ASIENTO
CREATE TABLE Asiento (
  Codigo_Asiento NUMBER(10) PRIMARY KEY,
  Codigo_Movimiento NUMBER(10) NOT NULL,
  asiento VARCHAR2(50) NOT NULL,
  CONSTRAINT fk_movimiento FOREIGN KEY (Codigo_Movimiento) REFERENCES Movimiento(Codigo_Movimiento)
);

--INSERTAMOS VALORES EN LA TABLA ASIENTO
INSERT INTO Asiento(Codigo_Asiento, Codigo_Movimiento, asiento)
VALUES(1, 1, 62);

--2. Realice una consulta SQL que le permita obtener el reporte de Libro Diario,
--como el de la imagen anterior.
SELECT Mov.fecha, Asi.asiento, Cu.nombre AS Numero_Cuenta, Mov.descripcion, Mov.factura, Mov.Comentario, Mov.subtotal, Mov.total
FROM Movimiento Mov
INNER JOIN Asiento Asi
ON Asi.Codigo_Movimiento = Mov.Codigo_Movimiento
INNER JOIN Cuenta Cu
ON Cu.Codigo_Cuenta = Mov.Codigo_Cuenta;

--*****SEGUNDA PARTE DE LA PRUEBA TÉCNICA*****

--CREAMOS LA TABLA TIPO listo
CREATE TABLE Tipo(
    Codigo_Tipo INT PRIMARY KEY,
    Nombre_Tipo VARCHAR2(100) NOT NULL
);

--CREAMOS LA TABLA TIPO_INFORMACION listo
CREATE TABLE Tipo_Informacion(
    Codigo_Tipo_Informacion INT PRIMARY KEY,
    Nombre_Tipo_Informacion VARCHAR2(100) NOT NULL
);

--CREAMOS LA TABLA FORMATO_MENSAJE listo
CREATE TABLE Formato_Mensaje(
    Codigo_Formato_Mensaje INT PRIMARY KEY,
    Nombre_Formato_Mensaje VARCHAR2(150) NOT NULL,
    Remitente_Formato_Mensaje VARCHAR2(150) NOT NULL,
    Asunto_Formato_Mensaje VARCHAR2(250) NOT NULL,
    Codigo_Tipo INT NOT NULL,
    Codigo_Tipo_Informacion INT NOT NULL,
    FOREIGN KEY (Codigo_Tipo) REFERENCES Tipo (Codigo_Tipo),
    FOREIGN KEY (Codigo_Tipo_Informacion) REFERENCES Tipo_Informacion (Codigo_Tipo_Informacion)
);

--CREAMOS LA TABLA PROYECTO listo
CREATE TABLE Proyecto(
    Codigo_Proyecto INT PRIMARY KEY,
    Nombre_Proyecto VARCHAR2(100) NOT NULL
);

--CREAMOS LA TABLA PRODUCTO listo
CREATE TABLE Producto (
    Codigo_Producto INT PRIMARY KEY,
    Descripcion_Producto VARCHAR2(100) NOT NULL
);

--CREAMOS LA TABLA PRODUCTO_PROYECTO listo
CREATE TABLE Producto_Proyecto (
    Codigo_Proyecto INT,
    Codigo_Producto INT,
    Primary KEY (Codigo_Proyecto, Codigo_Producto)
);

--CREAMOS LA TABLA Mensaje
CREATE TABLE Mensaje(
  Codigo_Mensaje INT PRIMARY KEY,
  Codigo_Formato_Mensaje REFERENCES Formato_Mensaje(Codigo_Formato_Mensaje),
  Codigo_Proyecto REFERENCES Proyecto (Codigo_Proyecto),
  Codigo_Producto REFERENCES Producto (Codigo_Producto)
);

--PROCEDIMIENTOS ALMACENADOS****
--CREAMOS UNA SECUENCIA PARA INCREMENTAR EL VALOR DE LA LLAVE PRIMARIA DE LA TABLA CIUDAD
CREATE SEQUENCE secuencia_codigo_tipo START WITH 1 INCREMENT BY 1;

--MOSTRAMOS LA SALIDA EN CONSOLA
SET SERVEROUTPUT ON;

--TABLA TIPO
CREATE OR REPLACE PROCEDURE pa_tipo (
    P_Opcion IN INT,
    P_Codigo_Tipo IN INT,
    P_Nombre_Tipo IN VARCHAR2
) AS
    v_Codigo_Tipo Tipo.Codigo_Tipo%TYPE;
    v_Nombre_Tipo Tipo.Nombre_Tipo%TYPE;
BEGIN
    --ESTABLECEMOS UN PUNTO DE CONTROL PARA HACER UN ROLLBACK EN CASO DE QUE SEA NECESARIO
    SAVEPOINT tipos;
    
    IF P_Opcion = 1 THEN
        INSERT INTO Tipo(Codigo_Tipo, Nombre_Tipo)
        VALUES (secuencia_codigo_tipo.NEXTVAL, P_Nombre_Tipo);
        DBMS_OUTPUT.PUT_LINE('El Registro se Inserto correctamente');
        COMMIT;
    ELSIF P_Opcion = 2 THEN
        UPDATE Tipo
        SET Nombre_Tipo = P_Nombre_Tipo
        WHERE Codigo_Tipo = P_Codigo_Tipo;
        DBMS_OUTPUT.PUT_LINE('El Registro se Actualizï¿½ correctamente');
        COMMIT;
    ELSIF P_Opcion = 3 THEN
        DELETE FROM Tipo
        WHERE Codigo_Tipo = P_Codigo_Tipo;
        DBMS_OUTPUT.PUT_LINE('El Registro se Elimininado correctamente');
        COMMIT;
    ELSIF P_Opcion = 4 THEN
        SELECT Codigo_Tipo, Nombre_Tipo INTO v_Codigo_Tipo, v_Nombre_Tipo 
        FROM Tipo
        WHERE Codigo_Tipo = P_Codigo_Tipo;
        DBMS_OUTPUT.PUT_LINE('codigo Tipo: ' || v_Codigo_Tipo || ', Nombre Tipo: ' || v_Nombre_tipo);
    ELSE
      DBMS_OUTPUT.PUT_LINE('Operacionn no valida');
   END IF;
   EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Ha ocurrido un error');
    ROLLBACK TO tipos;
END;
/

--INVOCAMOS AL PROCEDIMIENTO PA_TIPO
EXEC pa_tipo(4, 1, 'Mensaje Estado de Cuenta');

SELECT CODIGO_TIPO ,
NOMBRE_TIPO  FROM Tipo;

--CREAMOS UNA SECUENCIA PARA INCREMENTAR EL VALOR DE LA LLAVE PRIMARIA DE LA TABLA CIUDAD
CREATE SEQUENCE secuencia_codigo_tipo_informacion START WITH 1 INCREMENT BY 1;

--MOSTRAMOS LA SALIDA EN CONSOLA
SET SERVEROUTPUT ON;

--TABLA TIPO_INFORMACION
CREATE OR REPLACE PROCEDURE pa_tipo_informacion(
    P_Opcion IN INT,
    P_Codigo_Tipo_Informacion IN INT,
    P_Nombre_Tipo_Informacion IN VARCHAR2
) AS
    v_Codigo_Tipo_Informacion Tipo_Informacion.Codigo_Tipo_Informacion%TYPE;
    v_Nombre_Tipo_Informacion Tipo_Informacion.Nombre_Tipo_Informacion%TYPE;
BEGIN
    --ESTABLECEMOS UN PUNTO DE CONTROL PARA HACER UN ROLLBACK EN CASO DE QUE SEA NECESARIO
    SAVEPOINT tipos_informaciones;
    
    IF P_Opcion = 1 THEN
        INSERT INTO Tipo_Informacion(Codigo_Tipo_Informacion, Nombre_Tipo_Informacion)
        VALUES (secuencia_codigo_tipo_informacion.NEXTVAL, P_Nombre_Tipo_Informacion);
        DBMS_OUTPUT.PUT_LINE('El Registro se Inserto correctamente');
        COMMIT;
    ELSIF P_Opcion = 2 THEN
        UPDATE Tipo_Informacion
        SET Nombre_Tipo_Informacion = P_Nombre_Tipo_Informacion
        WHERE Codigo_Tipo_Informacion = P_Codigo_Tipo_Informacion;
        DBMS_OUTPUT.PUT_LINE('El Registro se Actualizado correctamente');
        COMMIT;
    ELSIF P_Opcion = 3 THEN
        DELETE FROM Tipo_Informacion
        WHERE Codigo_Tipo_Informacion = P_Codigo_Tipo_Informacion;
        DBMS_OUTPUT.PUT_LINE('El Registro se Eliminado correctamente');
        COMMIT;
    ELSIF P_Opcion = 4 THEN
        SELECT Codigo_Tipo_Informacion, Nombre_Tipo_Informacion INTO v_Codigo_Tipo_Informacion, v_Nombre_Tipo_Informacion 
        FROM Tipo_Informacion
        WHERE Codigo_Tipo_Informacion = P_Codigo_Tipo_Informacion;
        DBMS_OUTPUT.PUT_LINE('Codigo Tipo_Informacion: ' || v_Codigo_Tipo_Informacion || ', Nombre Tipo_Informacion: ' || v_Nombre_Tipo_Informacion);
    ELSE
      DBMS_OUTPUT.PUT_LINE('Operacion no valida');
   END IF;
   EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Ha ocurrido un error');
    ROLLBACK TO tipos_informaciones;
END;
/
--INVOCAMOS PROCEDIMIENTO pa_tipo_informacion
EXEC pa_tipo_informacion (4, 1, 'Mensaje de Promocion');

SELECT CODIGO_TIPO_INFORMACION ,
NOMBRE_TIPO_INFORMACION  FROM Tipo_Informacion;

--CREAMOS UNA SECUENCIA PARA INCREMENTAR EL VALOR DE LA LLAVE PRIMARIA DE LA TABLA CIUDAD
CREATE SEQUENCE secuencia_codigo_formato_mensaje START WITH 1 INCREMENT BY 1;

--MOSTRAMOS LA SALIDA EN CONSOLA
SET SERVEROUTPUT ON;

--TABLA FORMATO_MENSAJE
CREATE OR REPLACE PROCEDURE pa_formato_mensaje (
    P_Opcion IN INT,
    P_Codigo_Formato_Mensaje IN INT,
    P_Nombre_Formato_Mensaje IN VARCHAR2,
    P_Remitente_Formato_Mensaje IN VARCHAR2,
    P_Asunto_Formato_Mensaje IN VARCHAR2,
    P_Codigo_Tipo_Formato_Mensaje IN INT,
    P_Codigo_Tipo_Informacion_Formato_Mensaje IN INT
) AS
    v_Codigo_Formato_Mensaje                    Formato_Mensaje.Codigo_Formato_Mensaje%TYPE;
    v_Nombre_Formato_Mensaje                    Formato_Mensaje.Nombre_Formato_Mensaje%TYPE;
    v_Remitente_Formato_Mensaje                 Formato_Mensaje.Remitente_Formato_Mensaje%TYPE;
    v_Asunto_Formato_Mensaje                    Formato_Mensaje.Asunto_Formato_Mensaje%TYPE;
    v_Codigo_Tipo_Formato_Mensaje               Formato_Mensaje.Codigo_Tipo%TYPE;
    v_Codigo_Tipo_Informacion_Formato_Mensaje   Formato_Mensaje.Codigo_Tipo_Informacion%TYPE;
BEGIN
    --ESTABLECEMOS UN PUNTO DE CONTROL PARA HACER UN ROLLBACK EN CASO DE QUE SEA NECESARIO
    SAVEPOINT formato_mensajes;
    
    IF P_Opcion = 1 THEN
        INSERT INTO Formato_Mensaje(Codigo_Formato_Mensaje, Nombre_Formato_Mensaje, Remitente_Formato_Mensaje,
        Asunto_Formato_Mensaje, Codigo_Tipo, Codigo_Tipo_Informacion)
        VALUES (secuencia_codigo_formato_mensaje.NEXTVAL, P_Nombre_Formato_Mensaje, P_Remitente_Formato_Mensaje,
        P_Asunto_Formato_Mensaje, P_Codigo_Tipo_Formato_Mensaje, P_Codigo_Tipo_Informacion_Formato_Mensaje);
        DBMS_OUTPUT.PUT_LINE('El Registro se Inserto correctamente');
        COMMIT;
    ELSIF P_Opcion = 2 THEN
        UPDATE Formato_Mensaje
        SET Nombre_Formato_Mensaje = P_Nombre_Formato_Mensaje, Remitente_Formato_Mensaje = P_Remitente_Formato_Mensaje,
        Asunto_Formato_Mensaje = P_Asunto_Formato_Mensaje, Codigo_Tipo = P_Codigo_Tipo_Formato_Mensaje,
        Codigo_Tipo_Informacion = P_Codigo_Tipo_Informacion_Formato_Mensaje
        WHERE Codigo_Formato_Mensaje = P_Codigo_Formato_Mensaje;
        DBMS_OUTPUT.PUT_LINE('El Registro se Actualizado correctamente');
        COMMIT;
    ELSIF P_Opcion = 3 THEN
        DELETE FROM Formato_Mensaje
        WHERE Codigo_Formato_Mensaje = P_Codigo_Formato_Mensaje;
        DBMS_OUTPUT.PUT_LINE('El Registro se Elimininado correctamente');
        COMMIT;
    ELSIF P_Opcion = 4 THEN
        SELECT Codigo_Formato_Mensaje, Nombre_Formato_Mensaje, Remitente_Formato_Mensaje,
        Asunto_Formato_Mensaje, Codigo_Tipo, Codigo_Tipo_Informacion 
        INTO V_Codigo_Formato_Mensaje, V_Nombre_Formato_Mensaje, V_Remitente_Formato_Mensaje,
        V_Asunto_Formato_Mensaje, V_Codigo_Tipo_Formato_Mensaje, V_Codigo_Tipo_Informacion_Formato_Mensaje 
        FROM Formato_Mensaje
        WHERE Codigo_Formato_Mensaje = P_Codigo_Formato_Mensaje;
        DBMS_OUTPUT.PUT_LINE('Codigo_Formato_Mensaje: ' || V_Codigo_Formato_Mensaje || ', Nombre_Formato_Mensaje: ' || V_Nombre_Formato_Mensaje ||
        ', Remitente_: ' || V_Remitente_Formato_Mensaje || ', Asunto: ' || V_Asunto_Formato_Mensaje || 
        ', Codigo_Tipo: ' || V_Codigo_Tipo_Formato_Mensaje || ', Codigo_Tipo_Informacion: ' || V_Codigo_Tipo_Informacion_Formato_Mensaje);
    ELSE
      DBMS_OUTPUT.PUT_LINE('Operacion no valida');
   END IF;
   EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Ha ocurrido un error');
    ROLLBACK TO formato_mensajes;
END;
/

--INVOCAMOS AL PROCEDIMIENTO pa_formato_mensaje
EXEC pa_formato_mensaje(4, 1, 'Edixon', 'Alexander', 'Prueba Técnica', 2, 1);

SELECT CODIGO_FORMATO_MENSAJE ,
NOMBRE_FORMATO_MENSAJE ,
REMITENTE_FORMATO_MENSAJE ,
ASUNTO_FORMATO_MENSAJE ,
CODIGO_TIPO ,
CODIGO_TIPO_INFORMACION  FROM Formato_Mensaje;

--CREAMOS UNA SECUENCIA PARA INCREMENTAR EL VALOR DE LA LLAVE PRIMARIA DE LA TABLA PROYECTO
CREATE SEQUENCE secuencia_codigo_proyecto START WITH 1 INCREMENT BY 1;

--MOSTRAMOS LA SALIDA EN CONSOLA
SET SERVEROUTPUT ON;

--TABLA FORMATO_MENSAJE
CREATE OR REPLACE PROCEDURE pa_proyecto (
    P_Opcion IN INT,
    P_Codigo_Proyecto IN INT,
    P_Nombre_Proyecto IN VARCHAR2
) AS
    v_Codigo_Proyecto                    Proyecto.Codigo_Proyecto%TYPE;
    v_Nombre_Proyecto                    Proyecto.Nombre_Proyecto%TYPE;
BEGIN
    --ESTABLECEMOS UN PUNTO DE CONTROL PARA HACER UN ROLLBACK EN CASO DE QUE SEA NECESARIO
    SAVEPOINT proyectos;
    
    IF P_Opcion = 1 THEN
        INSERT INTO Proyecto(Codigo_Proyecto, Nombre_Proyecto)
        VALUES (secuencia_codigo_proyecto.NEXTVAL, P_Nombre_Proyecto);
        DBMS_OUTPUT.PUT_LINE('El Registro se Inserto correctamente');
        COMMIT;
    ELSIF P_Opcion = 2 THEN
        UPDATE Proyecto
        SET Nombre_Proyecto = P_Nombre_Proyecto
        WHERE Codigo_Proyecto = P_Codigo_Proyecto;
        DBMS_OUTPUT.PUT_LINE('El Registro se Actualizado correctamente');
        COMMIT;
    ELSIF P_Opcion = 3 THEN
        DELETE FROM Proyecto
        WHERE Codigo_Proyecto = P_Codigo_Proyecto;
        DBMS_OUTPUT.PUT_LINE('El Registro se Elimininado correctamente');
        COMMIT;
    ELSIF P_Opcion = 4 THEN
        SELECT Codigo_Proyecto, Nombre_Proyecto
        INTO V_Codigo_Proyecto, V_Nombre_Proyecto
        FROM Proyecto
        WHERE Codigo_Proyecto = P_Codigo_Proyecto;
        DBMS_OUTPUT.PUT_LINE('Codigo_Proyecto: ' || V_Codigo_Proyecto || ', Nombre_Proyecto: ' || V_Nombre_Proyecto);
    ELSE
      DBMS_OUTPUT.PUT_LINE('Operacion no valida');
   END IF;
   EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Ha ocurrido un error');
    ROLLBACK TO proyectos;
END;
/

--INVOCAMOS AL ALMACENAMIENTO PA_PROYECTO
EXEC pa_proyecto(1, 2, 'Yujule');

SELECT CODIGO_PROYECTO ,
NOMBRE_PROYECTO  FROM Proyecto;

--CREAMOS UNA SECUENCIA PARA INCREMENTAR EL VALOR DE LA LLAVE PRIMARIA DE LA TABLA PROYECTO
CREATE SEQUENCE secuencia_codigo_producto START WITH 1 INCREMENT BY 1;

--MOSTRAMOS LA SALIDA EN CONSOLA
SET SERVEROUTPUT ON;

--TABLA FORMATO_MENSAJE
CREATE OR REPLACE PROCEDURE pa_producto (
    P_Opcion IN INT,
    P_Codigo_Producto IN INT,
    P_Descripcion_Producto IN VARCHAR2
) AS
    v_Codigo_Producto                    Producto.Codigo_Producto%TYPE;
    v_Descripcion_Producto               Producto.Descripcion_Producto%TYPE;
BEGIN
    --ESTABLECEMOS UN PUNTO DE CONTROL PARA HACER UN ROLLBACK EN CASO DE QUE SEA NECESARIO
    SAVEPOINT productos;
    
    IF P_Opcion = 1 THEN
        INSERT INTO Producto(Codigo_Producto, Descripcion_Producto)
        VALUES (secuencia_codigo_producto.NEXTVAL, P_Descripcion_Producto);
        DBMS_OUTPUT.PUT_LINE('El Registro se Inserto correctamente');
        COMMIT;
    ELSIF P_Opcion = 2 THEN
        UPDATE Producto
        SET Descripcion_Producto = P_Descripcion_Producto
        WHERE Codigo_Producto = P_Codigo_Producto;
        DBMS_OUTPUT.PUT_LINE('El Registro se Actualizado correctamente');
        COMMIT;
    ELSIF P_Opcion = 3 THEN
        DELETE FROM Producto
        WHERE Codigo_Producto = P_Codigo_Producto;
        DBMS_OUTPUT.PUT_LINE('El Registro se Elimininado correctamente');
        COMMIT;
    ELSIF P_Opcion = 4 THEN
        SELECT Codigo_Producto, Descripcion_Producto
        INTO V_Codigo_Producto, V_Descripcion_Producto
        FROM Producto
        WHERE Codigo_Producto = P_Codigo_Producto;
        DBMS_OUTPUT.PUT_LINE('Codigo_Producto: ' || V_Codigo_Producto || ', Descripcion_Producto: ' || V_Descripcion_Producto);
    ELSE
      DBMS_OUTPUT.PUT_LINE('Operacion no valida');
   END IF;
   EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Ha ocurrido un error');
    ROLLBACK TO productos;
END;
/
--INVOCAMOS AL PA_PRODUCTO
EXEC pa_producto(1, 1, 'Premia Platinum');

SELECT CODIGO_PRODUCTO ,
DESCRIPCION_PRODUCTO  FROM Producto;

--INSERTAMOS REGISTROS EN LA TABLA PRODUCTO_PROYECTO
INSERT INTO Producto_Proyecto(Codigo_Producto, Codigo_Proyecto)
VALUES(3, 1);

--CREAMOS UNA SECUENCIA PARA INCREMENTAR EL VALOR DE LA LLAVE PRIMARIA DE LA TABLA MENSAJE
CREATE SEQUENCE secuencia_codigo_mensaje START WITH 1 INCREMENT BY 1;

--MOSTRAMOS LA SALIDA EN CONSOLA
SET SERVEROUTPUT ON;

--TABLA FORMATO_MENSAJE
CREATE OR REPLACE PROCEDURE pa_mensaje (
    P_Opcion IN INT,
    P_Codigo_Mensaje IN INT,
    P_Codigo_Formato_Mensaje IN INT,
    P_Codigo_Proyecto IN INT,
    P_Codigo_Producto IN INT
) AS
    v_Codigo_Mensaje                     Mensaje.Codigo_Mensaje%TYPE;
    v_Codigo_Formato_Mensaje             Mensaje.Codigo_Formato_Mensaje%TYPE;
    v_Codigo_Proyecto                    Mensaje.Codigo_Proyecto%TYPE;
    v_Codigo_Producto                    Mensaje.Codigo_Producto%TYPE;
    
BEGIN
    --ESTABLECEMOS UN PUNTO DE CONTROL PARA HACER UN ROLLBACK EN CASO DE QUE SEA NECESARIO
    SAVEPOINT mensajes;
    
    IF P_Opcion = 1 THEN
        INSERT INTO Mensaje(Codigo_Mensaje, Codigo_Formato_Mensaje, Codigo_Proyecto, Codigo_Producto)
        VALUES (secuencia_codigo_mensaje.NEXTVAL, P_Codigo_Formato_Mensaje, P_Codigo_Proyecto, P_Codigo_Producto);
        DBMS_OUTPUT.PUT_LINE('El Registro se Inserto correctamente');
        COMMIT;
    ELSIF P_Opcion = 2 THEN
        UPDATE Mensaje
        SET Codigo_Formato_Mensaje = P_Codigo_Formato_Mensaje,
        Codigo_Proyecto = P_Codigo_Proyecto, Codigo_Producto = P_Codigo_Producto
        WHERE Codigo_Mensaje = P_Codigo_Mensaje;
        DBMS_OUTPUT.PUT_LINE('El Registro se Actualizado correctamente');
        COMMIT;
    ELSIF P_Opcion = 3 THEN
        DELETE FROM Mensaje
        WHERE Codigo_Mensaje = P_Codigo_Mensaje;
        DBMS_OUTPUT.PUT_LINE('El Registro se Elimininado correctamente');
        COMMIT;
    ELSIF P_Opcion = 4 THEN
        SELECT Codigo_Mensaje, Codigo_Formato_Mensaje, Codigo_Proyecto, Codigo_Producto
        INTO V_Codigo_Mensaje, V_Codigo_Formato_Mensaje, V_Codigo_Proyecto, V_Codigo_Producto
        FROM Mensaje
        WHERE Codigo_Mensaje = P_Codigo_Mensaje;
        DBMS_OUTPUT.PUT_LINE('Codigo_Mensaje: ' || V_Codigo_Mensaje || ', Codigo_Formato_Mensaje: ' || V_Codigo_Formato_Mensaje || 
        ', Codigo_Proyecto: ' || V_Codigo_Proyecto || ', Codigo_Producto: ' || V_Codigo_Producto);
    ELSE
      DBMS_OUTPUT.PUT_LINE('Operacion no valida');
   END IF;
   EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Ha ocurrido un error');
    ROLLBACK TO mensajes;
END;
/

--INVOCAMOS AL PROCEDIMIENTO
EXEC pa_mensaje(4, 1, 1, 1, 1);

SELECT CODIGO_MENSAJE ,
CODIGO_FORMATO_MENSAJE ,
CODIGO_PROYECTO ,
CODIGO_PRODUCTO  FROM Mensaje;

--1. Escriba la consulta en SQL que devuelva el nombre del proyecto y sus productos correspondientes del proyecto premia cuyo código es 1
SELECT Proy.Nombre_Proyecto, Prod.Descripcion_Producto
FROM Proyecto Proy
INNER JOIN Producto_Proyecto ON Proy.Codigo_Proyecto = Producto_Proyecto.Codigo_Proyecto 
INNER JOIN Producto Prod ON Producto_Proyecto.Codigo_Producto = Prod.Codigo_Producto
WHERE Proy.Nombre_Proyecto = 'Premia' AND Proy.Codigo_Proyecto = 1;

--2. Escriba una consulta SQL que devuelva los distintos mensajes que hay, indicando a qué proyecto y producto pertenecen.
SELECT m.Codigo_Mensaje, proy.Nombre_Proyecto, prod.Descripcion_Producto, ti.Nombre_Tipo_Informacion
FROM Mensaje m
JOIN Proyecto proy ON m.Codigo_Proyecto = proy.Codigo_Proyecto
JOIN Producto prod ON m.Codigo_Producto = prod.Codigo_Producto
JOIN Formato_Mensaje fm ON m.Codigo_Formato_Mensaje = fm.Codigo_Formato_Mensaje
JOIN Tipo_Informacion ti ON fm.Codigo_Tipo_Informacion = ti.Codigo_Tipo_Informacion;

--3. Escriba una consulta SQL que devuelva los distintos mensajes que hay, 
--indicando a qué proyecto y producto pertenecen. Pero si el mensaje está en 
--todos los productos de un proyecto, en lugar de mostrar cada producto, debe
--mostrar el nombre del proyecto y un solo producto que diga “TODOS”.
SELECT m.Codigo_Mensaje, proy.Nombre_Proyecto, 
    CASE WHEN COUNT(DISTINCT prod.Codigo_Producto) = 1 THEN 
    MAX(prod.Descripcion_Producto) ELSE 'TODOS' END AS Descripcion_Del_Producto
FROM Mensaje m
JOIN Proyecto proy ON m.Codigo_Proyecto = proy.Codigo_Proyecto
JOIN Producto prod ON m.Codigo_Producto = prod.Codigo_Producto 
GROUP BY m.Codigo_Mensaje, proy.Nombre_Proyecto;


--SELECTS
SELECT CODIGO_PRODUCTO ,
DESCRIPCION_PRODUCTO  FROM Producto;

SELECT CODIGO_PROYECTO ,
NOMBRE_PROYECTO  FROM Proyecto;

SELECT CODIGO_FORMATO_MENSAJE ,
NOMBRE_FORMATO_MENSAJE ,
REMITENTE_FORMATO_MENSAJE ,
ASUNTO_FORMATO_MENSAJE ,
CODIGO_TIPO ,
CODIGO_TIPO_INFORMACION  FROM Formato_Mensaje;

SELECT CODIGO_TIPO_INFORMACION ,
NOMBRE_TIPO_INFORMACION  FROM Tipo_Informacion;

SELECT CODIGO_TIPO ,
NOMBRE_TIPO  FROM Tipo;

SELECT CODIGO_MENSAJE ,
CODIGO_FORMATO_MENSAJE ,
CODIGO_PROYECTO ,
CODIGO_PRODUCTO  FROM Mensaje;

SELECT CODIGO_PROYECTO ,
CODIGO_PRODUCTO  FROM Producto_Proyecto;









