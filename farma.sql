CREATE DATABASE farma;

USE farma;

CREATE TABLE productos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    precio DOUBLE,
    imagen VARCHAR(255),
    categoria VARCHAR(100),
    subcategoria VARCHAR(100),
    item VARCHAR(100)
);

INSERT INTO productos
(nombre, precio, imagen, categoria, subcategoria, item)
VALUES
(
'Amoxicilina 500 mg',
120,
'img/amoxicilina.png',
'medicamentos',
'antibioticos',
'antibioticos_orales'
);

INSERT INTO productos
(nombre, precio, imagen, categoria, subcategoria, item)
VALUES
(
'Ciprofloxacino 500 mg',
180,
'img/ciprofloxacino.png',
'medicamentos',
'antibioticos',
'antibioticos_orales'
);

INSERT INTO productos
(nombre, precio, imagen, categoria, subcategoria, item)
VALUES
(
'Mupirocina Unguento',
95,
'img/mupirocina.png',
'medicamentos',
'antibioticos',
'antibioticos_topicos'
);

INSERT INTO productos
(nombre, precio, imagen, categoria, subcategoria, item)
VALUES
(
'Paracetamol 500mg',
65,
'img/paracetamol.png',
'medicamentos',
'analgesicos',
'analgesicos'
);

INSERT INTO productos
(nombre, precio, imagen, categoria, subcategoria, item)
VALUES
(
'Ibuprofeno 400mg',
89,
'img/ibuprofeno.png',
'medicamentos',
'analgesicos',
'ibuprofeno'
);