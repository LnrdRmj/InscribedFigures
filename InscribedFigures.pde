static class Options {
   
    static final int backgroundColor = #27272a;
    static final int figuresColor = #C5D1EB;
  
    static final int numOfShapes = 30;
    static final int numOfSidesOfFirstFigure = 3;
    static final int startingInscribedCircleDiameter = 100;

    static final float initialAlphaVelocity = 0.04;
  
}
RegularFigure triangle;
RegularFigure []figures;

void setup () {
  
    size(800, 800);
    fullScreen();
    translate(width/2, height/2);
    // rotate(-PI / 2);
    triangle = new RegularFigure(3, 100, 0.01);
    figures = new RegularFigure[Options.numOfShapes];

    int diameterInscribedCircle = Options.startingInscribedCircleDiameter;
    for (int i = 0; i < Options.numOfShapes; ++i) {
        figures[i] = new RegularFigure(i + Options.numOfSidesOfFirstFigure, diameterInscribedCircle, Options.initialAlphaVelocity / sqrt(i+1));
        diameterInscribedCircle = figures[i].getCircumscribedCircleDiameter();
    }

}

void draw () {
    
    translate(width/2, height/2);
    background(Options.backgroundColor);
    
    // triangle.draw();
    // triangle.update();

    for (int i = 0; i < Options.numOfShapes; ++i) {
        figures[i].draw();
        figures[i].update();
    }

}
