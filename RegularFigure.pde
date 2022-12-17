class RegularFigure{
  
 
    private int numOfSides;
    private float diameterCircumscribedCircle;
    private float radiusCircumscribedCircle;
    
    private float diameterInscribedCircle;
    private float radiusInscribedCircle;

    private PVector []points;
    private PVector []touchingPoints;
    private Axis []perpendicularAxes;

    private float alpha = 0;
    private float alphaVelocity;

    private color colore;

    RegularFigure(int numOfSides, int diameterInscribedCircle, float alphaVelocity, color colore) {
    
        this.numOfSides = numOfSides;
        // this.diameterCircumscribedCircle = diameterCircumscribedCircle;
        // this.radiusCircumscribedCircle = this.diameterCircumscribedCircle / 2;
        this.diameterInscribedCircle = diameterInscribedCircle;
        this.radiusInscribedCircle = this.diameterInscribedCircle / 2;

        this.alphaVelocity = alphaVelocity;

        this.colore = colore;

        points = new PVector[numOfSides];
        touchingPoints = new PVector[numOfSides];
        perpendicularAxes = new Axis[numOfSides];
  
        for (int i = 0; i < this.numOfSides; ++i) {

            float alpha = 1 + i * 2 * PI / this.numOfSides;
            touchingPoints[i] = new PVector(this.radiusInscribedCircle * cos(alpha) , this.radiusInscribedCircle * sin(alpha));
            // Axes is (m, q)
            float perpendicularAlpha = -1 / tan(alpha);
            perpendicularAxes[i] = new Axis(perpendicularAlpha, touchingPoints[i].y - perpendicularAlpha * touchingPoints[i].x);
            
        }

        for (int i = 0; i < this.numOfSides; ++i) {

            points[i] = perpendicularAxes[i].intersect(perpendicularAxes[(i + 1) % this.numOfSides]);

        }

    }

    void draw() {

        noFill();
        stroke(255);

        stroke(Options.inscribedCirclesColor, Options.inscribedCirclesAlpha);
        if (Options.showInscribedCircles) circle(0, 0, this.diameterInscribedCircle);
        
        for (int i = 0; i < this.numOfSides; ++i) {
            strokeWeight(2);
            // stroke(0, 255, 0);
            stroke(this.colore);
            PVector pointRotated = rotatePoint(points[i]);
            PVector secondPointRotated = rotatePoint(points[(i+1) % this.numOfSides]);
            line(pointRotated.x, pointRotated.y, 
                secondPointRotated.x, secondPointRotated.y);
        }

    }

    void update() {
        this.alpha += this.alphaVelocity;
    }

    PVector rotatePoint(PVector point) {

        float s = sin(this.alpha);
        float c = cos(this.alpha);

        float xnew = point.x * c - point.y * s;
        float ynew = point.x * s + point.y * c;

        return new PVector(xnew, ynew);
         
    }

    int getCircumscribedCircleRadius() {

        return (int) dist(0, 0, points[0].x, points[0].y);

    }

    int getCircumscribedCircleDiameter() {

        return this.getCircumscribedCircleRadius() * 2;

    }

}
