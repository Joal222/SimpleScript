// Código de usuario
package compiladores;

import java_cup.runtime.Symbol;

%%
// Opciones y declaraciones
%class AnalizadorLexico
%public
%cup
%char
%line
%column

%{
    // Método para imprimir información del lexema (opcional para depuración)
    public void imprimirLexema(String lexema, String tokenName) {
        // System.out.println("Token: " + tokenName + ", Lexema: " + lexema + ", Col: " + yycolumn + ", Lin: " + (yyline + 1));
    }

    // Método para crear Símbolos para CUP
    public Symbol getToken(int tipo, Object valor) {
        return new Symbol(tipo, yyline, yycolumn, valor);
    }

    public Symbol getToken(int tipo) { // Sobrecarga para tokens sin valor específico (solo el texto)
        return new Symbol(tipo, yyline, yycolumn, yytext());
    }
%}

// Macros (Expresiones Regulares Reutilizables)
EOL                 = \r|\n|\r\n
ESPACIO_BLANCO      = [ \t\f]+
COMENTARIO_LINEA    = "//" [^\r\n]* ({EOL})?

IDENTIFICADOR       = [a-zA-Z_][a-zA-Z_0-9]*

DIGITO              = [0-9]
ENTERO              = {DIGITO}+
FLOTANTE            = {ENTERO} \. {ENTERO} | {ENTERO} \. | \. {ENTERO}

// Cadenas: entre comillas dobles, permite comillas escapadas \" y otras secuencias de escape \.
CADENA              = \" ( [^\"\\] | \\. )* \"

%%

// Reglas Léxicas
<YYINITIAL> {
    // Ignorar Espacios en Blanco y Comentarios
    {ESPACIO_BLANCO}    { /* Ignorar */ }
    {COMENTARIO_LINEA}  { /* Ignorar */ }
    {EOL}               { /* Ignorar, o contar líneas si es necesario para alguna lógica especial */ }

    // Palabras Clave
    "DEFINE"            { imprimirLexema(yytext(), "DEFINE"); return getToken(sym.DEFINE); }
    "PRINT"             { imprimirLexema(yytext(), "PRINT"); return getToken(sym.PRINT); }
    "IF"                { imprimirLexema(yytext(), "IF"); return getToken(sym.IF); }
    "ELSE"              { imprimirLexema(yytext(), "ELSE"); return getToken(sym.ELSE); }
    "ELSEIF"            { imprimirLexema(yytext(), "ELSEIF"); return getToken(sym.ELSEIF); }
    "WHILE"             { imprimirLexema(yytext(), "WHILE"); return getToken(sym.WHILE); }
    "LOOP"              { imprimirLexema(yytext(), "LOOP"); return getToken(sym.LOOP); }
    "FUNCTION"          { imprimirLexema(yytext(), "FUNCTION"); return getToken(sym.FUNCTION); }
    "RETURN"            { imprimirLexema(yytext(), "RETURN"); return getToken(sym.RETURN); }
    "END"               { imprimirLexema(yytext(), "END"); return getToken(sym.END); }
    "DO"                { imprimirLexema(yytext(), "DO"); return getToken(sym.DO); }
    "THEN"                { imprimirLexema(yytext(), "THEN"); return getToken(sym.THEN); }

    // Literales Booleanos
    "true"              { imprimirLexema(yytext(), "TRUE"); return getToken(sym.TRUE, true); }
    "false"             { imprimirLexema(yytext(), "FALSE"); return getToken(sym.FALSE, false); }

    // Operadores Aritméticos
    "+"                 { imprimirLexema(yytext(), "SUMA"); return getToken(sym.SUMA); }
    "-"                 { imprimirLexema(yytext(), "RESTA"); return getToken(sym.RESTA); }
    "*"                 { imprimirLexema(yytext(), "MULTIPLICACION"); return getToken(sym.MULTIPLICACION); }
    "/"                 { imprimirLexema(yytext(), "DIVISION"); return getToken(sym.DIVISION); }

    // Operadores Relacionales
    "<"                 { imprimirLexema(yytext(), "MENOR_QUE"); return getToken(sym.MENOR_QUE); }
    ">"                 { imprimirLexema(yytext(), "MAYOR_QUE"); return getToken(sym.MAYOR_QUE); }
    "<="                { imprimirLexema(yytext(), "MENOR_IGUAL_QUE"); return getToken(sym.MENOR_IGUAL_QUE); }
    ">="                { imprimirLexema(yytext(), "MAYOR_IGUAL_QUE"); return getToken(sym.MAYOR_IGUAL_QUE); }
    "=="                { imprimirLexema(yytext(), "IGUAL_IGUAL"); return getToken(sym.IGUAL_IGUAL); }
    "!="                { imprimirLexema(yytext(), "DIFERENTE_DE"); return getToken(sym.DIFERENTE_DE); }

    // Operadores Lógicos (como cadenas de texto)
    "AND"               { imprimirLexema(yytext(), "AND"); return getToken(sym.AND); }
    "OR"                { imprimirLexema(yytext(), "OR"); return getToken(sym.OR); }
    "NOT"               { imprimirLexema(yytext(), "NOT"); return getToken(sym.NOT); }

    // Símbolos de Puntuación y Asignación
    "("                 { imprimirLexema(yytext(), "PARENTESIS_A"); return getToken(sym.PARENTESIS_A); }
    ")"                 { imprimirLexema(yytext(), "PARENTESIS_C"); return getToken(sym.PARENTESIS_C); }
    ";"                 { imprimirLexema(yytext(), "PUNTO_Y_COMA"); return getToken(sym.PUNTO_Y_COMA); }
    ","                 { imprimirLexema(yytext(), "COMA"); return getToken(sym.COMA); }
    "="                 { imprimirLexema(yytext(), "IGUAL"); return getToken(sym.IGUAL); } // Para asignaciones

    // Literales Numéricos y de Cadena
    {ENTERO}            { imprimirLexema(yytext(), "LITERAL_ENTERO"); return getToken(sym.LITERAL_ENTERO, Integer.valueOf(yytext())); }
    {FLOTANTE}          { imprimirLexema(yytext(), "LITERAL_FLOTANTE"); return getToken(sym.LITERAL_FLOTANTE, Float.valueOf(yytext())); }
    {CADENA}            { imprimirLexema(yytext(), "LITERAL_CADENA"); String val = yytext(); return getToken(sym.LITERAL_CADENA, val.substring(1, val.length()-1)); } // Quita comillas

    // Identificadores (Importante: esta regla debe ir DESPUÉS de las palabras clave y operadores textuales)
    {IDENTIFICADOR}     { imprimirLexema(yytext(), "IDENTIFICADOR"); return getToken(sym.IDENTIFICADOR, yytext()); }
}

// Regla para cualquier otro carácter no reconocido (Error Léxico)
[^]                   { System.err.println("Error léxico: Carácter no reconocido <" + yytext() + "> en línea " + (yyline + 1) + ", columna " + (yycolumn + 1)); /* No retorna token, idealmente se reporta y se intenta seguir o se aborta */ }