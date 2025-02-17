DROP DATABASE IF EXISTS ejemplo_transacciones;
CREATE DATABASE ejemplo_transacciones;
USE ejemplo_transacciones;

CREATE TABLE A (
    id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    atributo text
);

CREATE TABLE B (
    id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    atributo text
);

CREATE TABLE A_B (
    a_id int(11) DEFAULT NULL,
    b_id int(11) DEFAULT NULL,
    FOREIGN KEY (a_id) REFERENCES A(id),
    FOREIGN KEY (b_id) REFERENCES B(id)
);