CREATE DATABASE IF NOT EXISTS ;
USE farma_e_control;

CREATE TABLE IF NOT EXISTS usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE,
    correo VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    rol ENUM('Administrador', 'Personal de Almacén', 'Cliente', 'Doctor') DEFAULT 'Cliente',
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Registros de prueba para que cales los diferentes roles cuando quede el Servlet:
INSERT INTO usuarios (nombre, username, correo, password, rol) VALUES 
('Admin Supremo', 'admin', 'admin@farma.com', 'admin123', 'Administrador'),
('Doctor Simi', 'doc_simi', 'simi@farma.com', 'doc123', 'Doctor'),
('Lupita Díaz', 'lupita_dev', 'lupita@farma.com', 'user123', 'Cliente');