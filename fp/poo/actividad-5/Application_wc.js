export class Application_wc {
    static createGUI() {
        const body = document.body;
        body.style.display = 'flex';
        body.style.justifyContent = 'center';
        body.style.alignItems = 'flex-start';
        body.style.height = '100vh';
        body.style.margin = '0';
        body.style.padding = '20px';
        body.style.backgroundColor = '#f0f0f0';
        body.style.fontFamily = 'Arial, sans-serif';

        const container = document.createElement('div');
        container.className = 'container';
        container.style.display = 'flex';
        container.style.gap = '20px';
        body.appendChild(container);

        const canvasContainer = document.createElement('div');
        container.appendChild(canvasContainer);

        const canvas = document.createElement('canvas');
        canvas.id = 'gameCanvas';
        canvas.style.border = '2px solid black';
        canvas.style.backgroundColor = 'white';
        canvas.style.boxShadow = '0 0 10px rgba(0,0,0,0.2)';
        canvas.width = 800;
        canvas.height = 500;
        canvasContainer.appendChild(canvas);

        const controls = document.createElement('div');
        controls.className = 'controls';
        controls.style.display = 'flex';
        controls.style.flexDirection = 'column';
        controls.style.gap = '10px';
        controls.style.width = '250px';
        container.appendChild(controls);

        const figureButtons = this.createFigureButtons();
        controls.appendChild(figureButtons);

        const colorPicker = this.createColorPicker();
        controls.appendChild(colorPicker);

        const figuresTable = this.createFiguresTable();
        controls.appendChild(figuresTable);

        const statusBar = this.createStatusBar();
        controls.appendChild(statusBar);

        const errorMessage = this.createErrorMessage();
        controls.appendChild(errorMessage);

        return canvas;
    }

    static createFigureButtons() {
        const figureButtons = document.createElement('div');
        figureButtons.className = 'figure-buttons';
        figureButtons.style.display = 'flex';
        figureButtons.style.flexDirection = 'column';
        figureButtons.style.gap = '5px';
        figureButtons.style.marginBottom = '15px';

        const buttons = [
            { id: 'btnRectangle', text: 'Crear Rectángulo' },
            { id: 'btnCircle', text: 'Crear Círculo' },
            { id: 'btnTriangle', text: 'Crear Triángulo' },
            { id: 'btnDelete', text: 'Borrar Figura Seleccionada' }
        ];

        buttons.forEach(button => {
            const btn = document.createElement('button');
            btn.id = button.id;
            btn.textContent = button.text;
            btn.style.padding = '8px';
            btn.style.cursor = 'pointer';
            figureButtons.appendChild(btn);
        });

        return figureButtons;
    }

    static createColorPicker() {
        const colorPicker = document.createElement('div');
        colorPicker.className = 'color-picker';
        colorPicker.style.margin = '10px 0';

        const label = document.createElement('label');
        label.htmlFor = 'colorInput';
        label.textContent = 'Color de la figura:';
        colorPicker.appendChild(label);

        const input = document.createElement('input');
        input.type = 'color';
        input.id = 'colorInput';
        input.value = '#3498db';
        colorPicker.appendChild(input);

        return colorPicker;
    }

    static createFiguresTable() {
        const tableContainer = document.createElement('div');

        const title = document.createElement('h3');
        title.textContent = 'Figuras creadas:';
        tableContainer.appendChild(title);

        const table = document.createElement('table');
        table.id = 'figuresTable';
        table.style.width = '100%';
        table.style.borderCollapse = 'collapse';
        table.style.marginTop = '15px';

        const thead = document.createElement('thead');
        const headerRow = document.createElement('tr');

        const typeHeader = document.createElement('th');
        typeHeader.textContent = 'Tipo';
        typeHeader.style.border = '1px solid #ddd';
        typeHeader.style.padding = '8px';
        typeHeader.style.textAlign = 'left';
        typeHeader.style.backgroundColor = '#f2f2f2';
        headerRow.appendChild(typeHeader);

        const idHeader = document.createElement('th');
        idHeader.textContent = 'ID';
        idHeader.style.border = '1px solid #ddd';
        idHeader.style.padding = '8px';
        idHeader.style.textAlign = 'left';
        idHeader.style.backgroundColor = '#f2f2f2';
        headerRow.appendChild(idHeader);

        thead.appendChild(headerRow);
        table.appendChild(thead);

        const tbody = document.createElement('tbody');
        table.appendChild(tbody);

        tableContainer.appendChild(table);

        const style = document.createElement('style');
        style.textContent = `
            #figuresTable tr:nth-child(even) {
                background-color: #f9f9f9;
            }
            #figuresTable tr.selected {
                background-color: #d4edff;
                font-weight: bold;
            }
        `;
        document.head.appendChild(style);

        return tableContainer;
    }

    static createStatusBar() {
        const statusBar = document.createElement('div');
        statusBar.className = 'status-bar';
        statusBar.id = 'statusBar';
        statusBar.textContent = 'Ninguna figura seleccionada';
        statusBar.style.marginTop = '15px';
        statusBar.style.padding = '8px';
        statusBar.style.backgroundColor = '#e9e9e9';
        statusBar.style.borderRadius = '4px';
        statusBar.style.fontSize = '14px';

        return statusBar;
    }

    static createErrorMessage() {
        const errorMessage = document.createElement('div');
        errorMessage.id = 'errorMessage';
        errorMessage.className = 'error';
        errorMessage.style.color = 'red';
        errorMessage.style.marginTop = '10px';

        return errorMessage;
    }
}