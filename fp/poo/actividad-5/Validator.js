class Validator {
    static validateNumberInput(value, name, min = 1) {
        const num = Number(value);
        if (isNaN(num) || num < min) {
            throw new Error(`El valor de ${name} debe ser un número mayor o igual a ${min}`);
        }
        return num;
    }

    static validateUniqueId(id, existingObjects) {
        if (!id || id.trim() === '') {
            throw new Error('El ID no puede estar vacío');
        }
        if (existingObjects.has(id)) {
            throw new Error(`El ID "${id}" ya está en uso`);
        }
        return id.trim();
    }

    static validatePosition(value, name, max) {
        const num = Number(value);
        if (isNaN(num) || num < 0 || num > max) {
            throw new Error(`La posición ${name} debe estar entre 0 y ${max}`);
        }
        return num;
    }
}

export { Validator };