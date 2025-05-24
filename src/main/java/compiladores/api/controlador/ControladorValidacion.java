package compiladores.api.controlador;

import compiladores.api.dto.SolicitudEntradaCodigo;
import compiladores.api.dto.RespuestaValidacion;
import compiladores.servicios.ProcesadorCodigo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/v1") // Ruta base para los endpoints
public class ControladorValidacion {

    private final ProcesadorCodigo procesadorCodigo;

    @Autowired
    public ControladorValidacion(ProcesadorCodigo procesadorCodigo) {
        this.procesadorCodigo = procesadorCodigo;
    }

    @PostMapping("/validar")
    public ResponseEntity<RespuestaValidacion> validarCodigo(@RequestBody(required = false) SolicitudEntradaCodigo solicitud) {
        if (solicitud == null || solicitud.getCodigo() == null) {
            RespuestaValidacion respuestaError = new RespuestaValidacion("error", List.of("Cuerpo de la petición inválido o el campo 'codigo' es nulo."));
            return ResponseEntity.badRequest().body(respuestaError);
        }
        RespuestaValidacion respuesta = procesadorCodigo.procesar(solicitud.getCodigo());
        return ResponseEntity.ok(respuesta);
    }
}