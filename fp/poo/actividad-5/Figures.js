class Figure {
    constructor(x, y, boundaryOffset) {
        this.x = x;
        this.y = y;
        this.angle = 0;
        this.speed = 3;
        this.rotationSpeed = 0.05;
        this.moving = false;
        this.boundaryOffset = boundaryOffset;
    }

    draw(ctx) {
        throw new Error("Method 'draw()' must be implemented.");
    }

    moveForward(canvasWidth, canvasHeight) {
        const dx = Math.cos(this.angle) * this.speed;
        const dy = Math.sin(this.angle) * this.speed;
        
        const newX = this.x + dx;
        const newY = this.y + dy;
        
        if (newX > this.boundaryOffset && newX < canvasWidth - this.boundaryOffset) {
            this.x = newX;
        }
        
        if (newY > this.boundaryOffset && newY < canvasHeight - this.boundaryOffset) {
            this.y = newY;
        }
        
        this.moving = true;
    }

    moveBackwards(canvasWidth, canvasHeight) {
        const dx = Math.cos(this.angle) * this.speed;
        const dy = Math.sin(this.angle) * this.speed;
    
        const newX = this.x - dx;
        const newY = this.y - dy;
        
        if (newX > this.boundaryOffset && newX < canvasWidth - this.boundaryOffset) {
            this.x = newX;
        }
        
        if (newY > this.boundaryOffset && newY < canvasHeight - this.boundaryOffset) {
            this.y = newY;
        }
        
        this.moving = true;
    }

    rotateLeft() {
        this.angle -= this.rotationSpeed;
        this.moving = true;
    }

    rotateRight() {
        this.angle += this.rotationSpeed;
        this.moving = true;
    }

    stop() {
        this.moving = false;
    }
}

class Rectangle extends Figure {
    constructor(x, y, side = 60, color = '#3498db') {
        const height = side * 2; 
        super(x, y, Math.max(side, height) / 2);
        this.width = side;
        this.height = height;
        this.color = color;
    }

    draw(ctx) {
        ctx.save();
        ctx.translate(this.x, this.y);
        ctx.rotate(this.angle - Math.PI / 2);
        ctx.fillStyle = this.color;
        ctx.fillRect(-this.width/2, -this.height/2, this.width, this.height);
        ctx.restore();
    }
}

class Circle extends Figure {
    constructor(x, y, radius = 30, color = '#e74c3c') {
        super(x, y, radius);
        this.radius = radius;
        this.color = color;
    }

    draw(ctx) {
        ctx.save();
        ctx.translate(this.x, this.y);
        ctx.rotate(this.angle);
        ctx.fillStyle = this.color;
        ctx.beginPath();
        ctx.arc(0, 0, this.radius, 0, Math.PI * 2);
        ctx.fill();
        ctx.restore();
    }
}

class Triangle extends Figure {
    constructor(x, y, sideLength = 40, color = '#2ecc71') {
        const height = (Math.sqrt(3)/2) * sideLength;
        const boundaryOffset = height * 2/3;
        super(x, y, boundaryOffset);
        this.sideLength = sideLength;
        this.height = height;
        this.color = color;
    }

    draw(ctx) {
        ctx.save();
        ctx.translate(this.x, this.y);
        ctx.rotate(this.angle + Math.PI/2);

        ctx.fillStyle = this.color;
        ctx.beginPath();
        ctx.moveTo(0, -this.height * 2/3);
        ctx.lineTo(this.sideLength/2, this.height/3);
        ctx.lineTo(-this.sideLength/2, this.height/3);
        
        ctx.closePath();
        ctx.fill();
        ctx.restore();
    }
}

export { Figure, Rectangle, Circle, Triangle };