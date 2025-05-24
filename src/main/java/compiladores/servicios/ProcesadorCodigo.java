package compiladores.servicios;

import compiladores.AnalizadorLexico;
import compiladores.AnalizadorSintactico; // Tu parser generado por CUP
import compiladores.api.dto.RespuestaValidacion;

import java.io.StringReader;
import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Service;

@Service // Anotación para que Spring Boot lo reconozca como un servicio
public class ProcesadorCodigo {

    public RespuestaValidacion procesar(String codigo) {
        List<String> mensajes = new ArrayList<>();

        try {
            StringReader lector = new StringReader(codigo);
            AnalizadorLexico analizadorLexico = new AnalizadorLexico(lector);
            AnalizadorSintactico analizadorSintactico = new AnalizadorSintactico(analizadorLexico);

            analizadorSintactico.parse(); // Ejecuta el parsing

            List<String> erroresDeSintaxis = analizadorSintactico.obtenerErroresSintaxis();

            if (erroresDeSintaxis.isEmpty()) {
                mensajes.add("El código es sintácticamente válido.");
                return new RespuestaValidacion("valido", mensajes);
            } else {
                mensajes.addAll(erroresDeSintaxis);
                return new RespuestaValidacion("invalido", mensajes);
            }

        } catch (Exception e) {
            // Esta excepción es usualmente de unrecovered_syntax_error
            mensajes.add("Error crítico durante el análisis.");
            if (e.getMessage() != null && !e.getMessage().trim().isEmpty()) {
                mensajes.add("Detalle: " + e.getMessage());
            }
            return new RespuestaValidacion("error", mensajes);
        }
    }
}