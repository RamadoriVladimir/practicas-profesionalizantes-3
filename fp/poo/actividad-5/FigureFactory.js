import { Rectangle, Circle, Triangle } from "./Figures.js";

class FigureFactory {
    static createFigure(type, x, y, size, color) {
        switch(type.toLowerCase()) {
            case 'rectangle':
                return new Rectangle(x, y, size, color);
            case 'circle':
                return new Circle(x, y, size, color);
            case 'triangle':
                return new Triangle(x, y, size, color);
            default:
                throw new Error(`Tipo de figura no soportado: ${type}`);
        }
    }

    static getCreationPrompt(type) {
        const prompts = {
            rectangle: {
                size: 'Lado base del rectángulo (mínimo 10):',
                id: 'Ingrese un ID único para el rectángulo:'
            },
            circle: {
                size: 'Radio del círculo (mínimo 10):',
                id: 'Ingrese un ID único para el círculo:'
            },
            triangle: {
                size: 'Tamaño del triángulo (lado, mínimo 10):',
                id: 'Ingrese un ID único para el triángulo:'
            }
        };
        return prompts[type.toLowerCase()] || prompts.rectangle;
    }
}

export { FigureFactory };