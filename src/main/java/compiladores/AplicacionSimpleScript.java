package compiladores; // Tu paquete raíz

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
// Si tus componentes (Controlador, Servicio, Configuracion) están en subpaquetes
// de 'compiladores', Spring Boot los encontrará automáticamente con @SpringBootApplication.
// Si estuvieran en paquetes completamente diferentes, necesitarías @ComponentScan.

@SpringBootApplication
public class AplicacionSimpleScript {

    public static void main(String[] args) {
        SpringApplication.run(AplicacionSimpleScript.class, args);
        System.out.println("Servidor Spring Boot iniciado. API de validación en: http://localhost:8080/api/v1/validar");
        System.out.println("Puedes enviar peticiones POST con JSON: {\"codigo\": \"tu código SimpleScript\"}");
    }
}