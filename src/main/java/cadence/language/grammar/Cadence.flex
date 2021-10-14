package cadence.language.grammar;

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

WhiteSpaceOnly = [ \t\f]
WhiteSpace = {LineTerminator} | {WhiteSpaceOnly}



/* comments */
DocumentationComment = {DocumentationEndOfLineComment} | {DocumentationBlockComment}
DocumentationEndOfLineComment = "///" {InputCharacter}* {LineTerminator}?
DocumentationBlockComment = "/**"+ [^/*] ~"*/"

SimpleComment = {TraditionalComment} | {EndOfLineComment}
TraditionalComment = "/*" [^*] ~"*/" | "/*" "*"+ "/"
EndOfLineComment = "//" {InputCharacter}* {LineTerminator}?


/* identifiers */
Identifier = {NameFirstCharacter}{NameLegalCharacters}\R*
FunctionIdentifier = {NameFirstCharacter}{NameLegalCharacters}
ParamIdentifier = {NameFirstCharacter}{NameLegalCharacters}:
TypeIdentifier = {TypeFirstCharacter}{NameLegalCharacters}

NameLegalCharacters = [_A-Za-z0-9]*
NameFirstCharacter = [_A-Za-z]
TypeFirstCharacter = [@_A-Za-z] // TODO confirm

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


/* identifiers literals */
IdentifierFirstCharacter = [_A-Za-z]
IdentifierCharacter = [_A-Za-z\R]*

%state STRING, DEFINITION, FUNCTION_NAME, FUNCTION_PARAMS

%%

<YYINITIAL> {


// Control
  "if"                           { return CadenceTypes.KEYWORD; }
  "else"                         { return CadenceTypes.KEYWORD; }
  "switch"                       { return CadenceTypes.KEYWORD; }
  "case"                         { return CadenceTypes.KEYWORD; }
   "default"                     { return CadenceTypes.KEYWORD; }

// Control transfer
  "break"                        { return CadenceTypes.KEYWORD; }
  "continue"                     { return CadenceTypes.KEYWORD; }
  "return"                       { return CadenceTypes.KEYWORD; }

// Loop
  "while"                        { return CadenceTypes.KEYWORD; }
  "for"                          { return CadenceTypes.KEYWORD; }
  "in"                           { return CadenceTypes.KEYWORD; }

// Imports
  "import"                       { return CadenceTypes.KEYWORD; }
  "from"                         { return CadenceTypes.KEYWORD; }

   "Never"                       { return CadenceTypes.KEYWORD; }
// Variable declaration
  "let"                          { yybegin(DEFINITION); return CadenceTypes.KEYWORD; }
  "var"                          { yybegin(DEFINITION); return CadenceTypes.KEYWORD; }


// Function
  "fun"                          { yybegin(FUNCTION_NAME); return CadenceTypes.KEYWORD; }
  "return"                       { return CadenceTypes.KEYWORD; }
  "pre"                          { return CadenceTypes.KEYWORD; }
  "post"                         { return CadenceTypes.KEYWORD; }
  "execute"                      { return CadenceTypes.KEYWORD; }
  "prepare"                      { return CadenceTypes.KEYWORD; }

// Composite types
  "create"                       { return CadenceTypes.KEYWORD; }
  "destroy"                      { return CadenceTypes.KEYWORD; }
  "init"                         { return CadenceTypes.KEYWORD; }
  "synthetic"                    { return CadenceTypes.KEYWORD; }
  "self"                         { return CadenceTypes.KEYWORD; }
  "get"                          { return CadenceTypes.KEYWORD; }
  "set"                          { return CadenceTypes.KEYWORD; }

// events
  "emit"                         { yybegin(FUNCTION_NAME); return CadenceTypes.KEYWORD; }

// Access
  "priv"                         { return CadenceTypes.KEYWORD; }
  "pub"                          { return CadenceTypes.KEYWORD; }
 // "access"                   { return CadenceTypes.KEYWORD; } //TODO probably not highlighted

// Types
  "Void"                         { return CadenceTypes.KEYWORD; }
  "Bool"                         { return CadenceTypes.KEYWORD; }

  "Int8"                         { return CadenceTypes.KEYWORD; }
  "Int16"                        { return CadenceTypes.KEYWORD; }
  "Int32"                        { return CadenceTypes.KEYWORD; }
  "Int64"                        { return CadenceTypes.KEYWORD; }
  "Int128"                       { return CadenceTypes.KEYWORD; }
  "Int256"                       { return CadenceTypes.KEYWORD; }

  "UInt8"                        { return CadenceTypes.KEYWORD; }
  "UInt16"                       { return CadenceTypes.KEYWORD; }
  "UInt32"                       { return CadenceTypes.KEYWORD; }
  "UInt64"                       { return CadenceTypes.KEYWORD; }
  "UInt128"                      { return CadenceTypes.KEYWORD; }
  "UInt256"                      { return CadenceTypes.KEYWORD; }

  "Word8"                        { return CadenceTypes.KEYWORD; }
  "Word16"                       { return CadenceTypes.KEYWORD; }
  "Word32"                       { return CadenceTypes.KEYWORD; }
  "Word64"                       { return CadenceTypes.KEYWORD; }

  "Fix64"                        { return CadenceTypes.KEYWORD; }
  "UFix64"                       { return CadenceTypes.KEYWORD; }

  "contract"                     { yybegin(DEFINITION); return CadenceTypes.KEYWORD; }
  "account"                      { yybegin(DEFINITION); return CadenceTypes.KEYWORD; }
  "all"                          { return CadenceTypes.KEYWORD; }

   "event"                       { yybegin(DEFINITION); return CadenceTypes.KEYWORD; }
   "transaction"                 { return CadenceTypes.KEYWORD; }

   "AnyStruct"                   { return CadenceTypes.KEYWORD; }
   "AnyResource"                 { return CadenceTypes.KEYWORD; }
   "struct"                      { yybegin(DEFINITION); return CadenceTypes.KEYWORD; }
   "resource"                    { yybegin(DEFINITION); return CadenceTypes.KEYWORD; }
   "interface"                   { yybegin(DEFINITION); return CadenceTypes.KEYWORD; }

   "Address"                     { return CadenceTypes.KEYWORD; }  //TODO should we?
   "PublicAccount"               { return CadenceTypes.KEYWORD; } //TODO should we?
   "AuthAccount"                 { return CadenceTypes.KEYWORD; } //TODO should we?
   "Type"                        { return CadenceTypes.KEYWORD; } //TODO should we?



  "String"                       { return CadenceTypes.KEYWORD; }
  "Character"                    { return CadenceTypes.KEYWORD; }

  "enum"                         { return CadenceTypes.KEYWORD; }

  /* boolean literals */
  "true"                         { return CadenceTypes.KEYWORD;  }
  "false"                        { return CadenceTypes.KEYWORD;  }

  /* nil literal */
  "nil"                          { return CadenceTypes.KEYWORD;  }


  /* separators */
   "@"                           { return CadenceTypes.SEPARATOR; }
  ";"                            { return CadenceTypes.SEPARATOR; }
  "("                            { return CadenceTypes.SEPARATOR; }
  ")"                            { return CadenceTypes.SEPARATOR; }
  "{"                            { return CadenceTypes.SEPARATOR; }
  "}"                            { return CadenceTypes.SEPARATOR; }
  "["                            { return CadenceTypes.SEPARATOR; }
  "]"                            { return CadenceTypes.SEPARATOR; }
  ","                            { return CadenceTypes.SEPARATOR; }
  "."                            { return CadenceTypes.SEPARATOR; }

  /* operators */
  "??"                           { return CadenceTypes.SEPARATOR; }
  "<-!"                          { return CadenceTypes.SEPARATOR; }
  "<-"                          { return CadenceTypes.SEPARATOR; }
  "as?"                          { return CadenceTypes.SEPARATOR; }
  "="                            { return CadenceTypes.SEPARATOR; }
  "<->"                          { return CadenceTypes.SEPARATOR; }

  "+"                            { return CadenceTypes.SEPARATOR; }
  "-"                            { return CadenceTypes.SEPARATOR; }
  "*"                            { return CadenceTypes.SEPARATOR; }
  "/"                            { return CadenceTypes.SEPARATOR; }
  "%"                            { return CadenceTypes.SEPARATOR; }
  "!"                            { return CadenceTypes.SEPARATOR; }

  "&&"                           { return CadenceTypes.SEPARATOR; }
  "||"                           { return CadenceTypes.SEPARATOR; }

  ">"                            { return CadenceTypes.SEPARATOR; }
  "<"                            { return CadenceTypes.SEPARATOR; }
  "=="                           { return CadenceTypes.SEPARATOR; }
  "<="                           { return CadenceTypes.SEPARATOR; }
  ">="                           { return CadenceTypes.SEPARATOR; }
  "!="                           { return CadenceTypes.SEPARATOR; }

  "?"                            { return CadenceTypes.SEPARATOR; }
  ":"                            { return CadenceTypes.SEPARATOR; }

  "<<"                           { return CadenceTypes.SEPARATOR; }
  ">>"                           { return CadenceTypes.SEPARATOR; }
  "&"                            { return CadenceTypes.SEPARATOR; }
  "|"                            { return CadenceTypes.SEPARATOR; }
  "^"                            { return CadenceTypes.SEPARATOR; }

  /* string literal */
  \"                             { yybegin(STRING); }  //TODO escape sequences? https://docs.onflow.org/cadence/language/values-and-types/

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

<DEFINITION> {
{WhiteSpaceOnly}                           {return CadenceTypes.SEPARATOR;}
  {Identifier}                { yybegin(YYINITIAL); return CadenceTypes.DEFINITION; }


  /* error cases */
 // ^({Identifier}|\R)                           { return TokenType.BAD_CHARACTER; }
  {LineTerminator}               { return TokenType.BAD_CHARACTER; }
}

<FUNCTION_NAME> {
 {WhiteSpaceOnly}                    {return CadenceTypes.SEPARATOR;}
  {FunctionIdentifier}               { return CadenceTypes.FUNCTION_NAME; }
  \(                              { yybegin(FUNCTION_PARAMS); return CadenceTypes.SEPARATOR;}
  \)                                  { yybegin(YYINITIAL); return CadenceTypes.SEPARATOR;}

  /* error cases */
 // ^({Identifier}|\R)                           { return TokenType.BAD_CHARACTER; }
  {LineTerminator}               { return TokenType.BAD_CHARACTER; }
}
<FUNCTION_PARAMS> {
 ,                                {return CadenceTypes.SEPARATOR;}
 {WhiteSpaceOnly}                    {return CadenceTypes.SEPARATOR;}
  {ParamIdentifier}               { return CadenceTypes.FUNCTION_PARAMETER; }
  {TypeIdentifier}                    { return CadenceTypes.TYPE; }
  \)                                  { yybegin(YYINITIAL); return CadenceTypes.SEPARATOR;}

  /* error cases */
 // ^({Identifier}|\R)                           { return TokenType.BAD_CHARACTER; }
  {LineTerminator}               { return TokenType.BAD_CHARACTER; }
}

/* error fallback */
[^]                              { return TokenType.BAD_CHARACTER; }
//<<EOF>>                          { return TokenType.BAD_CHARACTER; }