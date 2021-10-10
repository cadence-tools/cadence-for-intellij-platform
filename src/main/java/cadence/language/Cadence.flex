package cadence.language;

import com.intellij.lexer.FlexLexer;
import com.intellij.psi.tree.IElementType;
import cadence.language.psi.CadenceTypes;
import com.intellij.psi.TokenType;

%%

%class CadenceLexer
%implements FlexLexer
%unicode
%function advance
%type IElementType
%eof{  return;
%eof}

/* main character classes */
LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]

WhiteSpace = {LineTerminator} | [ \t\f]



/* comments */
DocumentationComment = {DocumentationEndOfLineComment} | {DocumentationBlockComment}
DocumentationEndOfLineComment = "///" {InputCharacter}* {LineTerminator}?
DocumentationBlockComment = "/**"+ [^/*] ~"*/"

SimpleComment = {TraditionalComment} | {EndOfLineComment}
TraditionalComment = "/*" [^*] ~"*/" | "/*" "*"+ "/"
EndOfLineComment = "//" {InputCharacter}* {LineTerminator}?


/* identifiers */
Identifier = [A-Za-z][A-Za-z\R]*

/* integer literals */
DecIntegerLiteral = 0 | [1-9][0-9]*
DecLongLiteral    = {DecIntegerLiteral} [lL]

HexIntegerLiteral = 0 [xX] 0* {HexDigit} {1,8}
HexLongLiteral    = 0 [xX] 0* {HexDigit} {1,16} [lL]
HexDigit          = [0-9a-fA-F]

OctIntegerLiteral = 0+ [1-3]? {OctDigit} {1,15}
OctLongLiteral    = 0+ 1? {OctDigit} {1,21} [lL]
OctDigit          = [0-7]

/* floating point literals */
FloatLiteral  = ({FLit1}|{FLit2}|{FLit3}) {Exponent}? [fF]
DoubleLiteral = ({FLit1}|{FLit2}|{FLit3}) {Exponent}?

FLit1    = [0-9]+ \. [0-9]*
FLit2    = \. [0-9]+
FLit3    = [0-9]+
Exponent = [eE] [+-]? [0-9]+

/* string and character literals */
StringCharacter = [^\r\n\"\\]
SingleCharacter = [^\r\n\'\\]

%state STRING

%%

<YYINITIAL> {

  /* keywords */
  "abstract"                     { return CadenceTypes.KEYWORD; }
  "boolean"                      { return CadenceTypes.KEYWORD; }
  "break"                        { return CadenceTypes.KEYWORD; }
  "byte"                         { return CadenceTypes.KEYWORD; }
  "case"                         { return CadenceTypes.KEYWORD; }
  "catch"                        { return CadenceTypes.KEYWORD; }
  "char"                         { return CadenceTypes.KEYWORD; }
  "class"                        { return CadenceTypes.KEYWORD; }
  "const"                        { return CadenceTypes.KEYWORD; }
  "continue"                     { return CadenceTypes.KEYWORD; }
  "do"                           { return CadenceTypes.KEYWORD; }
  "double"                       { return CadenceTypes.KEYWORD; }
  "else"                         { return CadenceTypes.KEYWORD; }
  "extends"                      { return CadenceTypes.KEYWORD; }
  "final"                        { return CadenceTypes.KEYWORD; }
  "finally"                      { return CadenceTypes.KEYWORD; }
  "float"                        { return CadenceTypes.KEYWORD; }
  "for"                          { return CadenceTypes.KEYWORD; }
  "default"                      { return CadenceTypes.KEYWORD; }
  "implements"                   { return CadenceTypes.KEYWORD; }
  "import"                       { return CadenceTypes.KEYWORD; }
  "instanceof"                   { return CadenceTypes.KEYWORD; }
  "int"                          { return CadenceTypes.KEYWORD; }
  "interface"                    { return CadenceTypes.KEYWORD; }
  "long"                         { return CadenceTypes.KEYWORD; }
  "native"                       { return CadenceTypes.KEYWORD; }
  "new"                          { return CadenceTypes.KEYWORD; }
  "goto"                         { return CadenceTypes.KEYWORD; }
  "if"                           { return CadenceTypes.KEYWORD; }
  "public"                       { return CadenceTypes.KEYWORD; }
  "short"                        { return CadenceTypes.KEYWORD; }
  "super"                        { return CadenceTypes.KEYWORD; }
  "switch"                       { return CadenceTypes.KEYWORD; }
  "synchronized"                 { return CadenceTypes.KEYWORD; }
  "package"                      { return CadenceTypes.KEYWORD; }
  "private"                      { return CadenceTypes.KEYWORD; }
  "protected"                    { return CadenceTypes.KEYWORD; }
  "transient"                    { return CadenceTypes.KEYWORD; }
  "return"                       { return CadenceTypes.KEYWORD; }
  "void"                         { return CadenceTypes.KEYWORD; }
  "static"                       { return CadenceTypes.KEYWORD; }
  "while"                        { return CadenceTypes.KEYWORD; }
  "this"                         { return CadenceTypes.KEYWORD; }
  "throw"                        { return CadenceTypes.KEYWORD; }
  "throws"                       { return CadenceTypes.KEYWORD; }
  "try"                          { return CadenceTypes.KEYWORD; }
  "volatile"                     { return CadenceTypes.KEYWORD; }
  "strictfp"                     { return CadenceTypes.KEYWORD; }

  /* boolean literals */
  "true"                         { return CadenceTypes.KEYWORD;  }
  "false"                        { return CadenceTypes.KEYWORD;  }

  /* null literal */
  "null"                         { return CadenceTypes.KEYWORD;  }


  /* separators */
  "("                            { return CadenceTypes.SEPARATOR; }
  ")"                            { return CadenceTypes.SEPARATOR; }
  "{"                            { return CadenceTypes.SEPARATOR; }
  "}"                            { return CadenceTypes.SEPARATOR; }
  "["                            { return CadenceTypes.SEPARATOR; }
  "]"                            { return CadenceTypes.SEPARATOR; }
  ";"                            { return CadenceTypes.SEPARATOR; }
  ","                            { return CadenceTypes.SEPARATOR; }
  "."                            { return CadenceTypes.SEPARATOR; }

  /* operators */
  "="                            { return CadenceTypes.SEPARATOR; }
  ">"                            { return CadenceTypes.SEPARATOR; }
  "<"                            { return CadenceTypes.SEPARATOR; }
  "!"                            { return CadenceTypes.SEPARATOR; }
  "~"                            { return CadenceTypes.SEPARATOR; }
  "?"                            { return CadenceTypes.SEPARATOR; }
  ":"                            { return CadenceTypes.SEPARATOR; }
  "=="                           { return CadenceTypes.SEPARATOR; }
  "<="                           { return CadenceTypes.SEPARATOR; }
  ">="                           { return CadenceTypes.SEPARATOR; }
  "!="                           { return CadenceTypes.SEPARATOR; }
  "&&"                           { return CadenceTypes.SEPARATOR; }
  "||"                           { return CadenceTypes.SEPARATOR; }
  "++"                           { return CadenceTypes.SEPARATOR; }
  "--"                           { return CadenceTypes.SEPARATOR; }
  "+"                            { return CadenceTypes.SEPARATOR; }
  "-"                            { return CadenceTypes.SEPARATOR; }
  "*"                            { return CadenceTypes.SEPARATOR; }
  "/"                            { return CadenceTypes.SEPARATOR; }
  "&"                            { return CadenceTypes.SEPARATOR; }
  "|"                            { return CadenceTypes.SEPARATOR; }
  "^"                            { return CadenceTypes.SEPARATOR; }
  "%"                            { return CadenceTypes.SEPARATOR; }
  "<<"                           { return CadenceTypes.SEPARATOR; }
  ">>"                           { return CadenceTypes.SEPARATOR; }
  ">>>"                          { return CadenceTypes.SEPARATOR; }
  "+="                           { return CadenceTypes.SEPARATOR; }
  "-="                           { return CadenceTypes.SEPARATOR; }
  "*="                           { return CadenceTypes.SEPARATOR; }
  "/="                           { return CadenceTypes.SEPARATOR; }
  "&="                           { return CadenceTypes.SEPARATOR; }
  "|="                           { return CadenceTypes.SEPARATOR; }
  "^="                           { return CadenceTypes.SEPARATOR; }
  "%="                           { return CadenceTypes.SEPARATOR; }
  "<<="                          { return CadenceTypes.SEPARATOR; }
  ">>="                          { return CadenceTypes.SEPARATOR; }
  ">>>="                         { return CadenceTypes.SEPARATOR; }

  /* string literal */
  \"                             { yybegin(STRING); }

  /* numeric literals */

  /* This is matched together with the minus, because the number is too big to
     be represented by a positive integer. */
  "-2147483648"                  { return CadenceTypes.NUMERIC_VALUE; }

  {DecIntegerLiteral}            { return CadenceTypes.NUMERIC_VALUE; }
  {DecLongLiteral}               { return CadenceTypes.NUMERIC_VALUE; }
  {HexIntegerLiteral}            { return CadenceTypes.NUMERIC_VALUE; }
  {HexLongLiteral}               { return CadenceTypes.NUMERIC_VALUE; }

  {OctIntegerLiteral}            { return CadenceTypes.NUMERIC_VALUE; }
  {OctLongLiteral}               { return CadenceTypes.NUMERIC_VALUE; }

  {FloatLiteral}                 { return CadenceTypes.NUMERIC_VALUE; }
  {DoubleLiteral}                { return CadenceTypes.NUMERIC_VALUE; }
  {DoubleLiteral}[dD]            { return CadenceTypes.NUMERIC_VALUE; }

  /* comments */
  {DocumentationComment}         { return CadenceTypes.DOCUMENTATION_COMMENT;}
  {SimpleComment}                { return CadenceTypes.SIMPLE_COMMENT; }

//  /* whitespace */
  {WhiteSpace}                   { return CadenceTypes.SEPARATOR; }
//
//  /* identifiers */
  {Identifier}                   { return CadenceTypes.SEPARATOR; }
}

<STRING> {
  \"                             { yybegin(YYINITIAL); return CadenceTypes.STRING_VALUE; }

  {StringCharacter}+             { }

  \\[0-3]?{OctDigit}?{OctDigit}  { }

  /* error cases */
  \\.                            { return TokenType.BAD_CHARACTER; }
  {LineTerminator}               { return TokenType.BAD_CHARACTER; }
}

/* error fallback */
[^]                              { return TokenType.BAD_CHARACTER; }
//<<EOF>>                          { return TokenType.BAD_CHARACTER; }