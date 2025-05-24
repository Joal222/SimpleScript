package compiladores.api.dto;

import java.util.List;

public class RespuestaValidacion {
    private String estado; // 'status' traducido a 'estado' ("valido", "invalido", "error")
    private List<String> mensajes; // 'messages' traducido a 'mensajes'

    public RespuestaValidacion(String estado, List<String> mensajes) {
        this.estado = estado;
        this.mensajes = mensajes;
    }

    // Getters y Setters
    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public List<String> getMensajes() {
        return mensajes;
    }

    public void setMensajes(List<String> mensajes) {
        this.mensajes = mensajes;
    }
}