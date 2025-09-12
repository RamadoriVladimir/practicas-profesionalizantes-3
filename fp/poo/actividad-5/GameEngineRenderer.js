import { FigureFactory } from './FigureFactory.js';
import { Validator } from './Validator.js';
import { FigureController } from './FigureController.js';

class GameEngineRenderer {
    constructor(canvasInstance) {
        this.canvas = canvasInstance;
        this.ctx = this.canvas.getContext('2d');
        this.objects = new Map();
        this.controllers = new Map();
        this.selectedFigureId = null;
        this.colorInput = document.getElementById('colorInput');
        
        this.setupEventListeners();
    }

    addObject(id, object) {
        object.color = this.colorInput.value;
        this.objects.set(id, object);
        this.updateFiguresTable();
        return this;
    }

    removeObject(id = this.selectedFigureId) {
        if (!id) {
            this.showError('No hay figura seleccionada para borrar');
            return false;
        }

        if (!this.objects.has(id)) {
            this.showError(`La figura con ID ${id} no existe`);
            return false;
        }

        this.objects.delete(id);
        this.controllers.delete(`${id}-controller`);

        if (this.selectedFigureId === id) {
            this.selectedFigureId = null;
            document.getElementById('statusBar').textContent = 'Figura borrada. Ninguna figura seleccionada';
        }

        this.updateFiguresTable();
        return true;
    }

    addController(id, controller) {
        this.controllers.set(`${id}-controller`, controller);
        return this;
    }

    getObject(id) {
        return this.objects.get(id);
    }

    getController(id) {
        return this.controllers.get(`${id}-controller`);
    }

    render() {
        this.ctx.clearRect(0, 0, this.canvas.width, this.canvas.height);

        for (const controller of this.controllers.values()) {
            controller.update();
        }
        for (const object of this.objects.values()) {
            object.draw(this.ctx);
        }
    }

    updateFiguresTable() {
        const tableBody = document.querySelector('#figuresTable tbody');
        tableBody.innerHTML = '';
        
        this.objects.forEach((figure, id) => {
            const row = document.createElement('tr');
            if (id === this.selectedFigureId) {
                row.classList.add('selected');
            }
            
            row.onclick = this.handleRowClick.bind(this, id);
            
            const typeCell = document.createElement('td');
            typeCell.textContent = figure.constructor.name;
            
            const idCell = document.createElement('td');
            idCell.textContent = id;
            
            row.appendChild(typeCell);
            row.appendChild(idCell);
            tableBody.appendChild(row);
        });
    }

    handleRowClick(id) {
        this.selectFigure(id);
    }

    selectFigure(id) {
        this.selectedFigureId = id;
        const figure = this.getObject(id);
        this.colorInput.value = figure.color;
        
        document.getElementById('statusBar').textContent = 
            `Figura seleccionada: ${figure.constructor.name} (${id})`;
        this.setAsControlled(id);
        this.updateFiguresTable();
    }

    setAsControlled(id) {
        const figure = this.getObject(id);
        if (figure) {
            this.controllers.clear();
            const controller = new FigureController(figure, this.canvas);
            this.addController(id, controller);
        }
    }

    updateSelectedFigureColor() {
        if (this.selectedFigureId) {
            const figure = this.getObject(this.selectedFigureId);
            if (figure) {
                figure.color = this.colorInput.value;
            }
        }
    }

    gameLoop() {
        this.render();
        requestAnimationFrame(this.gameLoop.bind(this));
    }

    start() {
        this.gameLoop();
    }

    showError(message) {
        const errorElement = document.getElementById('errorMessage');
        errorElement.textContent = message;
        setTimeout(() => errorElement.textContent = '', 5000);
    }

    handleColorInput() {
        this.updateSelectedFigureColor();
    }

    createFigure(type) {
        try {
            const prompts = FigureFactory.getCreationPrompt(type);
            const id = Validator.validateUniqueId(
                prompt(prompts.id), 
                this.objects
            );
            const size = Validator.validateNumberInput(
                prompt(prompts.size), 
                'tamaño', 
                10
            );
            const x = Validator.validatePosition(
                prompt(`Posición X (0-${this.canvas.width}):`), 
                'X', 
                this.canvas.width
            );
            const y = Validator.validatePosition(
                prompt(`Posición Y (0-${this.canvas.height}):`), 
                'Y', 
                this.canvas.height
            );
            
            const figure = FigureFactory.createFigure(
                type, 
                x, 
                y, 
                size, 
                this.colorInput.value
            );
            
            this.addObject(id, figure);
            this.selectFigure(id);
        } catch (error) {
            this.showError(error.message);
        }
    }

    handleCreateRectangle() {
        this.createFigure('rectangle');
    }

    handleCreateCircle() {
        this.createFigure('circle');
    }

    handleCreateTriangle() {
        this.createFigure('triangle');
    }

    handleDelete() {
        this.removeObject();
    }

    setupEventListeners() {
        this.colorInput.addEventListener('input', this.handleColorInput.bind(this));
        
        document.getElementById('btnRectangle').addEventListener(
            'click', 
            this.handleCreateRectangle.bind(this)
        );
        
        document.getElementById('btnCircle').addEventListener(
            'click', 
            this.handleCreateCircle.bind(this)
        );
        
        document.getElementById('btnTriangle').addEventListener(
            'click', 
            this.handleCreateTriangle.bind(this)
        );

        document.getElementById('btnDelete').addEventListener(
            'click', 
            this.handleDelete.bind(this)
        );
    }
}

export { GameEngineRenderer };