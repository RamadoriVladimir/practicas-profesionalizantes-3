class FigureController {
    constructor(figure, canvas) {
        this.figure = figure;
        this.canvas = canvas;
        this.activeKeys = new Set();
        
        this.setupEventListeners();
    }

    setupEventListeners() {
        window.addEventListener('keydown', this.handleKeyDown.bind(this));
        window.addEventListener('keyup', this.handleKeyUp.bind(this));
        window.addEventListener('blur', this.handleWindowBlur.bind(this));
    }

    handleKeyDown(event) {
        if (['ArrowUp', 'ArrowDown', 'ArrowLeft', 'ArrowRight', ' '].includes(event.key)) {
            event.preventDefault();
        }
        this.activeKeys.add(event.key);
    }

    handleKeyUp(event) {
        this.activeKeys.delete(event.key);
        
        if (!['ArrowUp', 'ArrowDown'].some(key => this.activeKeys.has(key))) {
            this.figure.stop();
        }
    }

    handleWindowBlur() {
        this.activeKeys.clear();
        this.figure.stop();
    }

    update() {
        if (this.activeKeys.has('ArrowUp')) {
            this.figure.moveForward(this.canvas.width, this.canvas.height);
        }
        if (this.activeKeys.has('ArrowDown')) {
            this.figure.moveBackwards(this.canvas.width, this.canvas.height);
        }
        if (this.activeKeys.has('ArrowLeft')) {
            this.figure.rotateLeft();
        }
        if (this.activeKeys.has('ArrowRight')) {
            this.figure.rotateRight();
        }
    }
}

export { FigureController };