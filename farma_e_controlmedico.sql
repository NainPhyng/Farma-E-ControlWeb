USE farma_e_control;

-- 1. Crear tabla de Pacientes
CREATE TABLE pacientes (
    id_paciente INT AUTO_INCREMENT PRIMARY KEY,
    nombre_completo VARCHAR(200) NOT NULL,
    edad INT NOT NULL,
    genero VARCHAR(20),
    diagnostico TEXT,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Crear tabla de Recetas Emitidas
CREATE TABLE recetas (
    id_receta INT AUTO_INCREMENT PRIMARY KEY,
    id_paciente INT,
    id_medicamento INT,
    dosis VARCHAR(255) NOT NULL, -- Ej. "1 tableta cada 8 horas por 5 días"
    cantidad_recetada INT NOT NULL, -- Cuántas cajas se lleva
    fecha_emision TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente) ON DELETE CASCADE,
    FOREIGN KEY (id_medicamento) REFERENCES medicamentos(id_medicamento) ON DELETE SET NULL
);

-- 3. Insertar unos pacientes de prueba para empezar con datos
INSERT INTO pacientes (nombre_completo, edad, genero, diagnostico) VALUES
('Juan Pérez Gómez', 45, 'Masculino', 'Hipertensión arterial y cefalea leve.'),
('María Elena Rosas', 29, 'Femenino', 'Infección en las vías respiratorias superiores.');