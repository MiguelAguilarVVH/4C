CREATE TABLE biblioteca (
    id_biblioteca NUMBER(2) NOT NULL,
    nombre        VARCHAR2(40 CHAR) NOT NULL,
    municipalidad VARCHAR2(50) NOT NULL
);

ALTER TABLE biblioteca ADD CONSTRAINT biblioteca_pk PRIMARY KEY ( id_biblioteca );

CREATE TABLE libros (
    id_libro                 NUMBER(2) NOT NULL,
    categoria                VARCHAR2(50 CHAR) NOT NULL,
    autor                    VARCHAR2(30 CHAR),
    biblioteca_id_biblioteca NUMBER(2) NOT NULL
);

ALTER TABLE libros ADD CONSTRAINT libros_pk PRIMARY KEY ( id_libro );

ALTER TABLE libros
    ADD CONSTRAINT libros_biblioteca_fk FOREIGN KEY ( biblioteca_id_biblioteca )
        REFERENCES biblioteca ( id_biblioteca );
