package compiladores;

import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;
import java.io.StringReader;

public class Main {
 public static void main(String[] args) {
        System.out.println("--- Iniciando Prueba del Compilador SimpleScript (Ejemplo Simple) ---");

        // Ejemplo de código SimpleScript más básico
        String codigoSimpleScript =
                "// Programa SimpleScript muy basico\n" +
                        "DEFINE var1 = 100;\n" +
                        "DEFINE var2 = var1 + 25;\n" +
                        "PRINT \"var1 es: \", var1;\n" +
                        "PRINT \"var2 es: \", var2;\n" +
                        "DEFINE texto = \"hola mundo\";\n" +
                        "PRINT texto;";

        System.out.println("\n--- Código SimpleScript a Analizar ---");
        System.out.println(codigoSimpleScript);
        System.out.println("--------------------------------------\n");

        try {
            Reader lector = new StringReader(codigoSimpleScript);
            AnalizadorLexico analizadorLexico = new AnalizadorLexico(lector);

            System.out.println("--- Salida del Analizador Léxico (si 'imprimirLexema' está activo) ---");
            // Los tokens se imprimirán si tu método imprimirLexema en .flex está activo
            // mientras el parser los consume.

            compiladores.AnalizadorSintactico analizadorSintactico = new compiladores.AnalizadorSintactico(analizadorLexico);
            System.out.println("\n--- Iniciando Análisis Sintáctico ---");

            Object resultadoDelParse = analizadorSintactico.parse();

            System.out.println("\n--- Análisis Sintáctico Completado Exitosamente ---");

            if (resultadoDelParse != null) {
                System.out.println("Resultado del parsing (puede ser un Symbol o la raíz de tu AST): " + resultadoDelParse);
            } else {
                System.out.println("El parsing no produjo un resultado (AST no implementado o la regla 'start' no retorna valor).");
            }

        } catch (IOException e) {
            System.err.println("Error de E/S durante el análisis: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("\n--- Error Durante el Análisis ---");
            System.err.println(e.getMessage());
            // Tu método syntax_error en gramatica.cup debería haber impreso detalles
            // si el error fue puramente sintáctico y detectado por CUP.
            e.printStackTrace();
        } finally {
            System.out.println("\n--- Fin de la Prueba ---");
        }
    }
}