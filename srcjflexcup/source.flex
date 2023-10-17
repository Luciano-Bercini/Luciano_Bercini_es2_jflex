import java_cup.runtime.Symbol;

%% Let's define our stuff.

%class Lexer
%unicode
%public
%cup
// Turning on line and column counting; we can access those with yyline and yycolumn variables.
%line
%column

%{
private Symbol symbol(int sym) {
    return new Symbol(sym);
}

private Symbol symbol(int sym, Object value) {
      return new Symbol(sym, value);
}
%}

/* comments */
Comment = {TraditionalComment} | {EndOfLineComment} | {DocumentationComment}
TraditionalComment = "/*" [^*] ~"*/" | "/*" "*"+ "/"
// Comment can be the last line of the file, without line terminator.
EndOfLineComment = "//" {InputCharacter}* {LineTerminator}?
DocumentationComment = "/**" {CommentContent} "*"+ "/"
CommentContent = ( [^*] | \*+ [^/*] )*
/* Whitespaces */
LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
WhiteSpace = ({LineTerminator} | [ \t\f])+

%% // And now we match the regex and return the respective token.

"if" { return symbol(sym.IF); }
"else" { return symbol(sym.ELSE); }
"while" { return symbol(sym.WHILE); }
"int" { return symbol(sym.INTEGER); }
"float" { return symbol(sym.FLOAT); }

";" { return symbol(sym.SEMICOLON); }
[0-9]+ { return symbol(sym.INTEGER_LITERAL, yytext()); }
[a-zA-Z][a-zA-Z0-9]* { return symbol(sym.IDENTIFIER, yytext()); }
// Operators.
"*" { return symbol(sym.MUL); }     
"/" { return symbol(sym.DIV); }    
"+" { return symbol(sym.PLUS); }    
"-" { return symbol(sym.MINUS); }    
"=" { return symbol(sym.EQ); }
"==" { return symbol(sym.EQEQ); }
"(" { return symbol(sym.BRACKET_LEFT); }
")" { return symbol(sym.BRACKET_RIGHT); }
      
// Whitespaces.      
{WhiteSpace} { /* Ignore */ }
// Comments.  
{Comment} { /* Ignore */ }

// Error fallback.
. {
    return symbol(sym.ERROR, "Illegal character \"" + yytext() + "\" at: " + yyline + ", " + yycolumn);
  }