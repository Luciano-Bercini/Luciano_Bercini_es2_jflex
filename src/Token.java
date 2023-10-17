public class Token {
    private int sym;
    private Object attribute;

    public Token(int name, Object attribute) {
        this.sym = name;
        this.attribute = attribute;
    }

    public Token(int name) {
        this.sym = name;
        this.attribute = null;
    }

    public int getSym() {
        return sym;
    }

    public void setSym(int sym) {
        this.sym = sym;
    }

    public Object getAttribute() {
        return attribute;
    }

    public void setAttribute(Object attribute) {
        this.attribute = attribute;
    }

    public String toString() {
        return attribute == null ? String.valueOf(sym) : "(" + sym + ", \"" + attribute.toString() + "\")";
    }
}
