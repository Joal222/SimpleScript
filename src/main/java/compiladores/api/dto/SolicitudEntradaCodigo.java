package compiladores.api.dto;

public class SolicitudEntradaCodigo {
    private String codigo; // 'code' traducido a 'codigo'

    // Constructor vacío para deserialización JSON
    public SolicitudEntradaCodigo() {
    }

    public SolicitudEntradaCodigo(String codigo) {
        this.codigo = codigo;
    }

    // Getters y Setters
    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }
}