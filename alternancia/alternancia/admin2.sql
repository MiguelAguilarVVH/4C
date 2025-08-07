--Crear tabla para juegos
CREATE TABLE resultados (
    id NUMBER PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    eleccion_jugador VARCHAR2(20) NOT NULL,
    eleccion_computador VARCHAR2(20) NOT NULL,
    gano VARCHAR2(5),
    FECHA TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
    SELECT * FROM resultados;
    
-- Crear el auto incrementador

CREATE SEQUENCE resultados_seq START WITH 1 INCREMENT BY 1;

-- Crer un trigger para automatizar el ID
CREATE OR REPLACE TRIGGER trg_resultados_id
BEFORE INSERT ON resultados
FOR EACH ROW
BEGIN
    :new.id := resultados_seq.NEXTVAL;
END;
