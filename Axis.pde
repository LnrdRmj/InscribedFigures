class Axis{

    private float m, q;

    Axis(float m, float q){

        this.m = m;
        this.q = q; 

    }

    float getM() { return this.m; }
    float getQ() { return this.q; }

    void draw(float x1, float x2) {

        line(x1, x1 * m + q, x2, x2 * m + q);

    }

    PVector intersect(Axis otherAxis) {

        float x = (otherAxis.getQ() - this.q) / (this.m - otherAxis.getM());
        return new PVector((int)x, (int)this.evaluate(x));
        
    }

    float evaluate(float x) {
        return this.m * x + this.q;
    }

    String toString(){
        return "[ " + m + ", " + q + " ]";
    }
}
