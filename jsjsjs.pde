class ParticulaCuadrada implements Particula {
    float px;
    float py;
    color c;
    float lado = 20;
    boolean haciaDerecha = true;
    // Crea un nuevo cuadrado 
    // con un color aleatorio
    // en un punto aleatorio entre 25 y alto o ancho-25 (para evitar que se atasquen)
    ParticulaCuadrada() {
        px = random(25, width - 25);
        py = random(25, height - 25);
        c = color(96, 230, 150);
    }
    
    ParticulaCuadrada(float px, float py){
      this.px=px;
      this.py=py;
    }

    void display() {
        // Si choca, pinta de verde (r,g,b)
        if (colision()) fill(color(0, 255, 0));
        else fill(c);
        
        square(px, py, lado);
    }
    void mover() {
        // Si va a la derecha o izquierda
        if (haciaDerecha == true) {
            px++;
        } else {
            px--;
        }
        
        // Si llega a algún limite, cambia de dirección
        // Límite derecho
        if (px + 20 >= width) {
            haciaDerecha = false;
        }
        // Límite izquierdo
        else if(px - 20 <= 0){
          haciaDerecha = true;
        }
    }
    boolean colision() {
      // Si este cuadrado (this) choca con algún círculo p, regresa true
       //for (ParticulaRedonda p : particulasRedondas) {
       //     //if (colisiona(p, this)) return true;
       //     if (colisiona(p, new ParticulaCuadrada(px, py))) return true;
       // }
       for (Particula p : particulas) {
            //if (colisiona(p, this)) return true;
            if (p instanceof ParticulaRedonda && colisiona((ParticulaRedonda)p, this)) return true;
        }
        // Si no choca con ningún círculo, regresa false
        return false;
    }
}
class ParticulaRedonda implements Particula {
    float px;
    float py;
    color c;
    float radio = 20;
    boolean haciaAbajo = true;
    // Crea una nueva particula 
    // con un color aleatorio
    // en un punto aleatorio entre 25 y alto o ancho-25 (para evitar que se atasquen)
    ParticulaRedonda() {
        px = random(25, width - 25);
        py = random(25, height - 25);
        c = color(34, 8, 24);
    }
    void display() {
        // Si choca, pinta de verde (r,g,b)
        if (colision()) fill(color(0, 255, 0));
        else fill(c);
        
        circle(px, py, radio);
    }
    void mover() {
        // Si va a a arriba o abajo
        if (haciaAbajo == true) {
            py++;
        } else {
            py--;
        }

        // Si llega a algún limite, cambia de dirección
        // Límite inferior ||  Limite superior
        if (py + 20 >= height || py - 20 <= 0){
          // voltea el valor asignando el contrario
          haciaAbajo = !haciaAbajo;
        }
    }
    boolean colision() {
      // Si este circulo (this) choca con algún cuadrado p, regresa true
        //for (int i=0; i<particulasCuadradas.size(); i++) {
        //    if (colisiona(this, particulasCuadradas.get(i))) return true;
        //}
       for (int i=0; i<particulas.size(); i++) {
            if (particulas.get(i) instanceof ParticulaCuadrada &&  colisiona(this, (ParticulaCuadrada)particulas.get(i))) return true;
        }
        // Si no choca con ningún cuadrado, regresa false
        return false;
    }
}

// Recibe un círculo y un cuadrado y regresa si colisionan comprobando su distancia
boolean colisiona(ParticulaRedonda circulo, ParticulaCuadrada cuad) {
    float distX = abs(circulo.px - cuad.px - 20 / 2);
    float distY = abs(circulo.py - cuad.py - 20 / 2);
    if (distX > (20 / 2 + 20)) {
        return false;
    }
    if (distY > (20 / 2 + 20)) {
        return false;
    }
    if (distX <= (20 / 2)) {
        return true;
    }
    if (distY <= (20 / 2)) {
        return true;
    }
    float dx = distX - 20 / 2;
    float dy = distY - 20 / 2;
    return (dx * dx + dy * dy <= (20 * 20));
}


ArrayList< Particula > particulas;

void setup() {
    size(500, 500);
    //frameRate(60);
    
    particulas = new ArrayList();
    
    // Crea la lista de cuadrados
    // Agrega 10 cuadrados
    for (int i = 0; i < 10; i++) {
        //particulasCuadradas.add(new ParticulaCuadrada());
        particulas.add(new ParticulaCuadrada());
    }
    // Crea la lista de circulos
    // Agrega 20 cuadrados
    for (int i = 0; i < 20; i++) {
        //particulasRedondas.add(new ParticulaRedonda());
        particulas.add(new ParticulaRedonda());
    }
}

void draw() {
  // Pinta el fondo
    background(255);
    // Para cada cuadrado lo pinta y lo mueve
    //for (ParticulaCuadrada p: particulasCuadradas) {
    //    p.display();
    //    p.mover();
    //}
    //// Para cada circulo lo pinta y lo mueve
    //for (int i=0; i<particulasRedondas.size(); i++) {
    //    particulasRedondas.get(i).display();
    //    particulasRedondas.get(i).mover();
    //}
    
    for (Particula p: particulas) {
        p.display();
        p.mover();
    }
}
