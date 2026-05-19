USE farma_e_control;

-- 1. Tabla de Categorías
CREATE TABLE IF NOT EXISTS categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre_categoria VARCHAR(100) NOT NULL UNIQUE,
    descripcion TEXT
);

-- 2. Tabla de Medicamentos (Relacionada con categorías)
CREATE TABLE IF NOT EXISTS medicamentos (
    id_medicamento INT AUTO_INCREMENT PRIMARY KEY,
    nombre_comercial VARCHAR(150) NOT NULL,
    sustancia_activa VARCHAR(150) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    id_categoria INT,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria) ON DELETE SET NULL
);

-- 3. Insertar categorías base para que ya tengas de dónde escoger
INSERT IGNORE INTO categorias (nombre_categoria, descripcion) VALUES 
('Analgésicos', 'Medicamentos para aliviar el dolor físico.'),
('Antibióticos', 'Medicamentos para combatir infecciones bacterianas.'),
('Vitaminas y Suplementos', 'Nutrientes para reforzar el sistema inmunológico.'),
('Antiinflamatorios', 'Medicamentos que reducen la inflamación.');


USE farma_e_control;

-- 1. Eliminar las tablas viejas en orden (por las llaves foráneas) para reestructurar limpio
DROP TABLE IF EXISTS medicamentos;
DROP TABLE IF EXISTS categorias;

-- 2. Crear la tabla de Categorías (se queda igual, es nuestra base)
CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre_categoria VARCHAR(100) NOT NULL UNIQUE,
    descripcion TEXT
);

-- 3. Crear la tabla de Medicamentos NUEVA (Ya incluye la columna 'stock')
CREATE TABLE medicamentos (
    id_medicamento INT AUTO_INCREMENT PRIMARY KEY,
    nombre_comercial VARCHAR(150) NOT NULL,
    sustancia_activa VARCHAR(150) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL DEFAULT 0, -- <--- ¡Aquí está la magia para el inventario!
    id_categoria INT,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria) ON DELETE SET NULL
);

-- 4. Insertar las categorías de fábrica
INSERT INTO categorias (nombre_categoria, descripcion) VALUES 
('Analgésicos', 'Medicamentos para aliviar el dolor físico.'),
('Antibióticos', 'Medicamentos para combatir infecciones bacterianas.'),
('Vitaminas y Suplementos', 'Nutrientes para reforzar el sistema inmunológico.'),
('Antiinflamatorios', 'Medicamentos que reducen la inflamación.');

-- 5. Insertar unos medicamentos de prueba con stock para que la tabla no aparezca vacía al inicio
INSERT INTO medicamentos (nombre_comercial, sustancia_activa, precio, stock, id_categoria) VALUES
('Paracetamol', 'Acetaminofén', 45.00, 100, 1),
('Amoxicilina', 'Amoxicilina Trihidratada', 120.50, 50, 2),
('Vitamina C', 'Ácido Ascórbico', 85.00, 200, 3),
('Ibuprofeno', 'Ibuprofeno', 35.50, 150, 4);

-- 6. Consulta rápida para verificar que todo se creó hermoso
SELECT m.id_medicamento, m.nombre_comercial, m.sustancia_activa, m.precio, m.stock, c.nombre_categoria 
FROM medicamentos m
LEFT JOIN categorias c ON m.id_categoria = c.id_categoria;