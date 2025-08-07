

CREATE TABLE empleado (
    id_empleado        NUMBER(2) NOT NULL,
    nombre_completo    VARCHAR2(100 CHAR) NOT NULL,
    cargo              VARCHAR2(90 CHAR),
    empresa_id_empresa NUMBER(2) NOT NULL
);

ALTER TABLE empleado ADD CONSTRAINT empleado_pk PRIMARY KEY ( id_empleado );

CREATE TABLE empresa (
    id_empresa NUMBER(2) NOT NULL,
    nombre     VARCHAR2(50 CHAR) NOT NULL,
    rubro      VARCHAR2(100 CHAR)
);

ALTER TABLE empresa ADD CONSTRAINT empresa_pk PRIMARY KEY ( id_empresa );

ALTER TABLE empleado
    ADD CONSTRAINT empleado_empresa_fk FOREIGN KEY ( empresa_id_empresa )
        REFERENCES empresa ( id_empresa );



INSERT INTO empresa (id_empresa, nombre, rubro)
VALUES (1,'Ejemplo 1','Informatica');

INSERT INTO empresa (id_empresa, nombre, rubro)
VALUES (2,'Ejemplo 2','Informatica');

INSERT INTO empresa (id_empresa, nombre, rubro)
VALUES (3,'Ejemplo 3','Informatica');

INSERT INTO empleado VALUES (10,'Juan Perez','Jefe',1);
INSERT INTO empleado VALUES (11,'Alexander Bustamante','Presidente',2);
INSERT INTO empleado VALUES (12,'Max Diaz','Convivencia',3);

SELECT * FROM empresa;

SELECT* FROM empleado;

-- NOMBRE EMPLEADO, CARGO EMPLEADO, NOMBRE EMPRESA

SELECT nombre_completo, empleado.cargo, empresa.nombre FROM empleado
JOIN empresa ON id_empresa = empresa_id_empresa


